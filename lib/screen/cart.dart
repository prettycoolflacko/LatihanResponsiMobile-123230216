import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quiz_mobile/models/product_api.dart';
import 'package:quiz_mobile/models/product_model.dart';
import 'package:quiz_mobile/screen/detail.dart';
import 'package:quiz_mobile/services/session_service.dart';

class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  final ProductApi _api = ProductApi();
  List<Product> _cartProducts = [];
  bool _isLoading = true;
  String? _error;

  @override
  void initState() {
    super.initState();
    _loadCart();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // Reload cart whenever this page becomes visible
  }

  Future<void> _loadCart() async {
    setState(() { _isLoading = true; _error = null; });
    try {
      final ids = await SessionService.getCartIds();
      if (ids.isEmpty) {
        if (!mounted) return;
        setState(() { _cartProducts = []; _isLoading = false; });
        return;
      }
      final futures = ids.map((id) => _api.fetchProductById(id));
      final products = await Future.wait(futures);
      if (!mounted) return;
      setState(() { _cartProducts = products; _isLoading = false; });
    } catch (e) {
      if (!mounted) return;
      setState(() { _error = 'Failed to load cart.'; _isLoading = false; });
    }
  }

  Future<void> _removeItem(int productId) async {
    await SessionService.removeFromCart(productId);
    setState(() => _cartProducts.removeWhere((p) => p.id == productId));
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: const Text('Removed from cart'),
      behavior: SnackBarBehavior.floating,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      duration: const Duration(seconds: 1),
    ));
  }

  double get _totalPrice => _cartProducts.fold(0.0, (sum, p) => sum + p.price);

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    return Scaffold(
      backgroundColor: cs.surface,
      appBar: AppBar(
        title: const Text('My Cart', style: TextStyle(fontWeight: FontWeight.bold)),
        centerTitle: false,
        actions: [
          IconButton(icon: const Icon(Icons.refresh), onPressed: _loadCart),
        ],
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : _error != null
              ? Center(child: Column(mainAxisSize: MainAxisSize.min, children: [
                  Text(_error!, style: TextStyle(color: cs.error)),
                  const SizedBox(height: 12),
                  FilledButton.tonal(onPressed: _loadCart, child: const Text('Retry')),
                ]))
              : _cartProducts.isEmpty
                  ? Center(child: Column(mainAxisSize: MainAxisSize.min, children: [
                      Icon(Icons.shopping_cart_outlined, size: 80, color: cs.onSurface.withOpacity(0.2)),
                      const SizedBox(height: 16),
                      Text('Your cart is empty', style: TextStyle(fontSize: 18, color: cs.onSurface.withOpacity(0.5))),
                    ]))
                  : Column(children: [
                      Expanded(
                        child: ListView.builder(
                          padding: const EdgeInsets.all(16),
                          itemCount: _cartProducts.length,
                          itemBuilder: (context, index) {
                            final product = _cartProducts[index];
                            return Dismissible(
                              key: ValueKey(product.id),
                              direction: DismissDirection.endToStart,
                              onDismissed: (_) => _removeItem(product.id),
                              background: Container(
                                alignment: Alignment.centerRight,
                                padding: const EdgeInsets.only(right: 20),
                                margin: const EdgeInsets.only(bottom: 12),
                                decoration: BoxDecoration(
                                  color: Colors.redAccent,
                                  borderRadius: BorderRadius.circular(16),
                                ),
                                child: const Icon(Icons.delete_outline, color: Colors.white),
                              ),
                              child: GestureDetector(
                                onTap: () async {
                                  await Get.to(() => ProductDetailPage(product: product));
                                  _loadCart(); // reload after returning
                                },
                                child: Container(
                                  margin: const EdgeInsets.only(bottom: 12),
                                  padding: const EdgeInsets.all(12),
                                  decoration: BoxDecoration(
                                    color: cs.surfaceContainerLow,
                                    borderRadius: BorderRadius.circular(16),
                                    boxShadow: [BoxShadow(color: cs.shadow.withOpacity(0.04), blurRadius: 8, offset: const Offset(0, 2))],
                                  ),
                                  child: Row(children: [
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(12),
                                      child: Image.network(product.thumbnail, width: 72, height: 72, fit: BoxFit.cover,
                                        errorBuilder: (_, __, ___) => Container(width: 72, height: 72, color: cs.surfaceContainerHighest,
                                          child: Icon(Icons.image_not_supported, color: cs.onSurface.withOpacity(0.3)))),
                                    ),
                                    const SizedBox(width: 14),
                                    Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                                      Text(product.title, maxLines: 2, overflow: TextOverflow.ellipsis,
                                        style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: cs.onSurface)),
                                      const SizedBox(height: 6),
                                      Text('\$${product.price.toStringAsFixed(2)}',
                                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: cs.primary)),
                                    ])),
                                    IconButton(
                                      icon: Icon(Icons.delete_outline, color: cs.error.withOpacity(0.7)),
                                      onPressed: () => _removeItem(product.id),
                                    ),
                                  ]),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                      // Total bar
                      Container(
                        padding: const EdgeInsets.fromLTRB(24, 16, 24, 20),
                        decoration: BoxDecoration(
                          color: cs.surfaceContainerLow,
                          border: Border(top: BorderSide(color: cs.outlineVariant.withOpacity(0.3))),
                        ),
                        child: Row(children: [
                          Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                            Text('Total', style: TextStyle(fontSize: 13, color: cs.onSurface.withOpacity(0.5))),
                            Text('\$${_totalPrice.toStringAsFixed(2)}',
                              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: cs.primary)),
                          ]),
                          const Spacer(),
                          Text('${_cartProducts.length} item(s)',
                            style: TextStyle(color: cs.onSurface.withOpacity(0.5))),
                        ]),
                      ),
                    ]),
    );
  }
}
