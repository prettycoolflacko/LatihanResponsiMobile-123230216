import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quiz_mobile/models/product_model.dart';
import 'package:quiz_mobile/services/session_service.dart';

class ProductDetailPage extends StatefulWidget {
  final Product product;
  const ProductDetailPage({super.key, required this.product});

  @override
  State<ProductDetailPage> createState() => _ProductDetailPageState();
}

class _ProductDetailPageState extends State<ProductDetailPage> {
  bool _inCart = false;
  bool _cartLoading = true;
  int _imgIdx = 0;

  Product get p => widget.product;

  @override
  void initState() {
    super.initState();
    _checkCart();
  }

  Future<void> _checkCart() async {
    final r = await SessionService.isInCart(p.id);
    if (!mounted) return;
    setState(() { _inCart = r; _cartLoading = false; });
  }

  Future<void> _toggleCart() async {
    setState(() => _cartLoading = true);
    _inCart ? await SessionService.removeFromCart(p.id) : await SessionService.addToCart(p.id);
    if (!mounted) return;
    setState(() { _inCart = !_inCart; _cartLoading = false; });
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(_inCart ? 'Added to cart' : 'Removed from cart'),
      behavior: SnackBarBehavior.floating,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      duration: const Duration(seconds: 1),
    ));
  }

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final imgs = p.images.isNotEmpty ? p.images : [p.thumbnail];

    return Scaffold(
      backgroundColor: cs.surface,
      body: CustomScrollView(slivers: [
        SliverAppBar(
          expandedHeight: 300, pinned: true,
          leading: IconButton(
            icon: Container(padding: const EdgeInsets.all(8), decoration: BoxDecoration(color: cs.surface.withOpacity(0.8), shape: BoxShape.circle),
              child: Icon(Icons.arrow_back, color: cs.onSurface, size: 20)),
            onPressed: () => Get.back(),
          ),
          flexibleSpace: FlexibleSpaceBar(background: Stack(fit: StackFit.expand, children: [
            PageView.builder(itemCount: imgs.length, onPageChanged: (i) => setState(() => _imgIdx = i),
              itemBuilder: (_, i) => Container(color: cs.surfaceContainerHighest.withOpacity(0.3),
                child: Image.network(imgs[i], fit: BoxFit.contain,
                  errorBuilder: (_, __, ___) => Center(child: Icon(Icons.image_not_supported_outlined, size: 60, color: cs.onSurface.withOpacity(0.2)))))),
            if (imgs.length > 1) Positioned(bottom: 16, left: 0, right: 0,
              child: Row(mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(imgs.length, (i) => AnimatedContainer(duration: const Duration(milliseconds: 250),
                  width: _imgIdx == i ? 22 : 8, height: 8, margin: const EdgeInsets.symmetric(horizontal: 3),
                  decoration: BoxDecoration(color: _imgIdx == i ? cs.primary : cs.onSurface.withOpacity(0.25), borderRadius: BorderRadius.circular(4)))))),
          ])),
        ),
        SliverToBoxAdapter(child: Padding(padding: const EdgeInsets.all(20), child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          // Category + Brand
          Row(children: [
            _chip(p.category.replaceAll('-', ' ').toUpperCase(), cs.primary),
            if (p.brand.isNotEmpty) ...[const SizedBox(width: 8), _chip(p.brand, cs.tertiary)],
          ]),
          const SizedBox(height: 14),
          Text(p.title, style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: cs.onSurface)),
          const SizedBox(height: 12),
          // Price + Rating
          Row(crossAxisAlignment: CrossAxisAlignment.end, children: [
            Text('\$${p.price.toStringAsFixed(2)}', style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold, color: cs.primary)),
            if (p.discountPercentage > 0) ...[const SizedBox(width: 10),
              Text('-${p.discountPercentage.toStringAsFixed(1)}%', style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: Colors.redAccent))],
            const Spacer(),
            Icon(Icons.star_rounded, color: Colors.amber.shade700, size: 22), const SizedBox(width: 4),
            Text(p.rating.toStringAsFixed(1), style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: cs.onSurface.withOpacity(0.7))),
          ]),
          const SizedBox(height: 20),
          Text('Description', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700, color: cs.onSurface)),
          const SizedBox(height: 8),
          Text(p.description, style: TextStyle(fontSize: 14, color: cs.onSurface.withOpacity(0.7), height: 1.6)),
          const SizedBox(height: 24),
          // Info tiles
          _infoTile(cs, Icons.inventory_2_outlined, 'Stock', '${p.stock}'),
          _infoTile(cs, Icons.verified_outlined, 'Warranty', p.warrantyInformation),
          _infoTile(cs, Icons.local_shipping_outlined, 'Shipping', p.shippingInformation),
          _infoTile(cs, Icons.check_circle_outline, 'Status', p.availabilityStatus),
          _infoTile(cs, Icons.assignment_return_outlined, 'Return', p.returnPolicy),
          const SizedBox(height: 80),
        ]))),
      ]),
      bottomNavigationBar: SafeArea(child: Padding(padding: const EdgeInsets.fromLTRB(20, 8, 20, 12),
        child: SizedBox(height: 54, child: FilledButton.icon(
          onPressed: _cartLoading ? null : _toggleCart,
          icon: _cartLoading
              ? const SizedBox(width: 20, height: 20, child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white))
              : Icon(_inCart ? Icons.remove_shopping_cart : Icons.add_shopping_cart),
          label: Text(_inCart ? 'Remove from Cart' : 'Add to Cart', style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
          style: FilledButton.styleFrom(backgroundColor: _inCart ? Colors.redAccent : cs.primary,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16))),
        )))),
    );
  }

  Widget _chip(String label, Color color) => Container(
    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
    decoration: BoxDecoration(color: color.withOpacity(0.12), borderRadius: BorderRadius.circular(8)),
    child: Text(label, style: TextStyle(fontSize: 11, fontWeight: FontWeight.w600, color: color, letterSpacing: 0.5)),
  );

  Widget _infoTile(ColorScheme cs, IconData icon, String label, String value) {
    if (value.isEmpty) return const SizedBox.shrink();
    return Padding(padding: const EdgeInsets.only(bottom: 10), child: Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(color: cs.surfaceContainerLow, borderRadius: BorderRadius.circular(14),
        border: Border.all(color: cs.outlineVariant.withOpacity(0.3))),
      child: Row(children: [
        Icon(icon, size: 20, color: cs.primary), const SizedBox(width: 12),
        Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(label, style: TextStyle(fontSize: 11, color: cs.onSurface.withOpacity(0.5))),
          const SizedBox(height: 2),
          Text(value, style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: cs.onSurface)),
        ]),
      ]),
    ));
  }
}
