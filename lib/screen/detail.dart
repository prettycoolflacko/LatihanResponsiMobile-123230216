import 'package:flutter/material.dart';
import 'package:quiz_mobile/models/space_api.dart';
import 'package:quiz_mobile/models/space_item.dart';
import 'package:url_launcher/url_launcher.dart';

class ContentDetailPage extends StatefulWidget {
  final ContentType type;
  final int id;
  final String nama;

  const ContentDetailPage({
    super.key,
    required this.type,
    required this.id,
    required this.nama,
  });

  @override
  State<ContentDetailPage> createState() => _ContentDetailPageState();
}

class _ContentDetailPageState extends State<ContentDetailPage> {
  final SpaceApi _api = SpaceApi();
  late Future<SpaceItem> _detailFuture;

  @override
  void initState() {
    super.initState();
    _detailFuture = _api.fetchDetail(widget.type, widget.id);
  }

  String _formatDate(DateTime? value) {
    if (value == null) {
      return 'Unknown date';
    }
    final DateTime local = value.toLocal();
    final String month = local.month.toString().padLeft(2, '0');
    final String day = local.day.toString().padLeft(2, '0');
    return '${local.year}-$month-$day';
  }

  Future<void> _openUrl(String url) async {
    final Uri? uri = Uri.tryParse(url);
    if (uri == null) {
      if (!mounted) {
        return;
      }
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Invalid link.')),
      );
      return;
    }

    final bool launched = await launchUrl(
      uri,
      mode: LaunchMode.externalApplication,
    );

    if (!launched && mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Could not open link.')),
      );
    }
  }

  Widget _buildBody(SpaceItem item) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AspectRatio(
            aspectRatio: 16 / 9,
            child: Image.network(
              item.imageUrl,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) => const Icon(
                Icons.broken_image,
                size: 100,
                color: Colors.grey,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item.title,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  '${item.newsSite} • ${_formatDate(item.publishedAt)}',
                  style: const TextStyle(color: Colors.black54),
                ),
                const SizedBox(height: 16),
                Text(
                  item.summary,
                  style: const TextStyle(fontSize: 15),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<SpaceItem>(
      future: _detailFuture,
      builder: (context, snapshot) {
        final SpaceItem? item = snapshot.data;
        return Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.amberAccent,
            title: Text(
              widget.type.title,
              style: const TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          floatingActionButton: item == null || item.url.isEmpty
              ? null
              : FloatingActionButton(
                  onPressed: () => _openUrl(item.url),
                  backgroundColor: Colors.pinkAccent,
                  child: const Icon(Icons.open_in_new),
                ),
          body: Builder(
            builder: (context) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              }
              if (snapshot.hasError) {
                return const Center(child: Text('Failed to load detail.'));
              }
              if (item == null) {
                return const Center(child: Text('No detail available.'));
              }
              return _buildBody(item);
            },
          ),
        );
      },
    );
  }
}
