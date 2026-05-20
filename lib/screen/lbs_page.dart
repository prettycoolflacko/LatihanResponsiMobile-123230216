import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';

class LbsPage extends StatefulWidget {
  const LbsPage({super.key});

  @override
  State<LbsPage> createState() => _LbsPageState();
}

class _LbsPageState extends State<LbsPage> {
  bool _isLoading = false;
  String? _error;
  Position? _position;
  String _alamat = '-';
  String _kota = '-';
  String _negara = '-';

  final MapController _mapController = MapController();

  @override
  void initState() {
    super.initState();
    _getLocation();
  }

  // ── LOGIC ───────────────────────────────────────────────────────────────────

  Future<void> _getLocation() async {
    setState(() {
      _isLoading = true;
      _error = null;
    });

    try {
      // 1. Cek apakah GPS aktif
      if (!await Geolocator.isLocationServiceEnabled()) {
        return _setError('Layanan lokasi tidak aktif.\nAktifkan GPS terlebih dahulu.');
      }

      // 2. Cek & minta permission
      LocationPermission perm = await Geolocator.checkPermission();
      if (perm == LocationPermission.denied) {
        perm = await Geolocator.requestPermission();
      }
      if (perm == LocationPermission.denied) {
        return _setError('Izin lokasi ditolak.\nSilakan izinkan akses lokasi.');
      }
      if (perm == LocationPermission.deniedForever) {
        return _setError('Izin lokasi ditolak permanen.\nBuka pengaturan untuk mengaktifkannya.');
      }

      // 3. Ambil posisi
      final pos = await Geolocator.getCurrentPosition(
        locationSettings: const LocationSettings(accuracy: LocationAccuracy.high),
      );

      // 4. Reverse geocoding
      final placemarks = await placemarkFromCoordinates(pos.latitude, pos.longitude);
      final place = placemarks.isNotEmpty ? placemarks.first : null;

      setState(() {
        _position = pos;
        _alamat = place == null
            ? 'Lokasi tidak diketahui'
            : [place.street, place.subLocality, place.locality]
                .where((s) => s != null && s.isNotEmpty)
                .join(', ');
        _kota   = place?.administrativeArea ?? '-';
        _negara = place?.country ?? '-';
        _isLoading = false;
      });

      // 5. Geser peta setelah widget ter-render
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (mounted) {
          try {
            _mapController.move(LatLng(pos.latitude, pos.longitude), 15.0);
          } catch (_) {}
        }
      });
    } catch (e) {
      _setError('Gagal mendapatkan lokasi:\n$e');
    }
  }

  void _setError(String msg) {
    setState(() {
      _error = msg;
      _isLoading = false;
    });
  }

  // ── BUILD ────────────────────────────────────────────────────────────────────

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.amberAccent,
        title: const Text(
          'Lokasi Saya',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh, color: Colors.black),
            tooltip: 'Refresh Lokasi',
            onPressed: _isLoading ? null : _getLocation,
          ),
        ],
      ),
      body: _isLoading
          ? _buildLoading()
          : _error != null
              ? _buildError()
              : _buildContent(),
    );
  }

  // ── STATE VIEWS ──────────────────────────────────────────────────────────────

  Widget _buildLoading() {
    return const Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircularProgressIndicator(color: Colors.amberAccent),
          SizedBox(height: 16),
          Text('Mendeteksi lokasi...', style: TextStyle(color: Colors.grey)),
        ],
      ),
    );
  }

  Widget _buildError() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.location_off, size: 80, color: Colors.red),
            const SizedBox(height: 16),
            Text(
              _error!,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 16, color: Colors.redAccent),
            ),
            const SizedBox(height: 24),
            ElevatedButton.icon(
              onPressed: _getLocation,
              icon: const Icon(Icons.refresh),
              label: const Text('Coba Lagi'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.amberAccent,
                foregroundColor: Colors.black,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildContent() {
    return Column(
      children: [
        _buildMap(),
        Expanded(child: _buildInfo()),
      ],
    );
  }

  // ── MAP ──────────────────────────────────────────────────────────────────────

  Widget _buildMap() {
    final center = _position != null
        ? LatLng(_position!.latitude, _position!.longitude)
        : const LatLng(-6.2088, 106.8456); // Default: Jakarta

    return SizedBox(
      height: 300,
      child: FlutterMap(
        mapController: _mapController,
        options: MapOptions(initialCenter: center, initialZoom: 15.0),
        children: [
          TileLayer(
            urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
            userAgentPackageName: 'com.example.quiz_mobile',
          ),
          if (_position != null)
            MarkerLayer(
              markers: [
                Marker(
                  point: center,
                  width: 50,
                  height: 50,
                  child: const Icon(Icons.location_pin, color: Colors.red, size: 50),
                ),
              ],
            ),
        ],
      ),
    );
  }

  // ── INFO PANEL ───────────────────────────────────────────────────────────────

  Widget _buildInfo() {
    return ListView(
      children: [
        // Header: kota & negara
        Container(
          color: Colors.amberAccent,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          child: Row(
            children: [
              const Icon(Icons.location_pin, size: 32, color: Colors.red),
              const SizedBox(width: 12),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(_kota,
                      style: const TextStyle(
                          fontSize: 18, fontWeight: FontWeight.bold)),
                  Text(_negara,
                      style: const TextStyle(fontSize: 13, color: Colors.black54)),
                ],
              ),
            ],
          ),
        ),

        // Info tiles
        _infoTile(Icons.my_location, 'Koordinat GPS',
            'Lat: ${_position?.latitude.toStringAsFixed(6) ?? '-'}'
            '   Lng: ${_position?.longitude.toStringAsFixed(6) ?? '-'}'),
        const Divider(height: 1),
        _infoTile(Icons.home, 'Alamat', _alamat),
        const Divider(height: 1),
        _infoTile(Icons.radar, 'Akurasi',
            '${_position?.accuracy.toStringAsFixed(1) ?? '-'} meter'),
        const Divider(height: 1),

        // Refresh button
        Padding(
          padding: const EdgeInsets.all(16),
          child: ElevatedButton.icon(
            onPressed: _getLocation,
            icon: const Icon(Icons.refresh),
            label: const Text('Perbarui Lokasi'),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.amberAccent,
              foregroundColor: Colors.black,
              minimumSize: const Size(double.infinity, 48),
            ),
          ),
        ),
      ],
    );
  }

  Widget _infoTile(IconData icon, String title, String value) {
    return ListTile(
      leading: Icon(icon, color: Colors.amberAccent),
      title: Text(title,
          style: const TextStyle(fontSize: 12, color: Colors.grey)),
      subtitle: Text(value,
          style: const TextStyle(fontSize: 15, color: Colors.black87)),
    );
  }
}
