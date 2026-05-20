import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class SessionService {
  static const String _keyUsername = 'session_username';
  static const String _keyCart = 'cart_product_ids';
  static const String _keyProfileImage = 'profile_image_path';

  // ── Session ──────────────────────────────────────────────

  static Future<void> saveLogin(String username) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(_keyUsername, username);
  }

  static Future<String?> getUsername() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(_keyUsername);
  }

  static Future<bool> isLoggedIn() async {
    final String? username = await getUsername();
    return username != null && username.isNotEmpty;
  }

  static Future<void> clearSession() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove(_keyUsername);
  }

  // ── Cart ─────────────────────────────────────────────────

  static Future<List<int>> getCartIds() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? raw = prefs.getString(_keyCart);
    if (raw == null || raw.isEmpty) return [];
    final List<dynamic> decoded = jsonDecode(raw) as List<dynamic>;
    return decoded.map((e) => e as int).toList();
  }

  static Future<void> _saveCartIds(List<int> ids) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(_keyCart, jsonEncode(ids));
  }

  static Future<void> addToCart(int id) async {
    final List<int> ids = await getCartIds();
    if (!ids.contains(id)) {
      ids.add(id);
      await _saveCartIds(ids);
    }
  }

  static Future<void> removeFromCart(int id) async {
    final List<int> ids = await getCartIds();
    ids.remove(id);
    await _saveCartIds(ids);
  }

  static Future<bool> isInCart(int id) async {
    final List<int> ids = await getCartIds();
    return ids.contains(id);
  }

  // ── Profile Image ────────────────────────────────────────

  static Future<void> saveProfileImagePath(String path) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(_keyProfileImage, path);
  }

  static Future<String?> getProfileImagePath() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(_keyProfileImage);
  }
}
