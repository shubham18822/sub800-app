import 'package:flutter/material.dart';
import '../../config/theme.dart';
import '../../models/category_model.dart';
import '../../utils/responsive.dart';
import '../../widgets/app_bottom_nav_bar.dart';
import '../../widgets/app_header_search.dart';
class BasketScreen extends StatefulWidget {
  final int currentNavIndex;
  final Function(int) onNavTap;
  const BasketScreen({
    super.key,
    required this.currentNavIndex,
    required this.onNavTap,
  });
  @override
  State<BasketScreen> createState() => _BasketScreenState();
}
class _BasketScreenState extends State<BasketScreen> {
  static const List<String> _frequencyOptions = ['One-Off', 'Weekly', 'Monthly'];
  final Map<CartItem, String> _selectedFrequency = {};
  String _selectedFor(CartItem item) =>
      _selectedFrequency[item] ?? _frequencyOptions.first;
  double _parsePrice(String rawPrice) {
    final cleaned = rawPrice.replaceAll(RegExp(r'[^0-9.]'), '');
    return double.tryParse(cleaned) ?? 0;
  }
  double _cartTotal() => globalCart.fold<double>(
        0,
        (sum, item) => sum + (_parsePrice(item.product.price) * item.quantity),
      );
  String _formatCurrency(double amount) {
    if (amount == amount.roundToDouble()) {
      return '£${amount.toStringAsFixed(0)}';
    }
    return '£${amount.toStringAsFixed(2)}';
  }
  void _openItemActions(CartItem item) {
    showModalBottomSheet<void>(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      elevation: 0,
      builder: (ctx) {
        return SafeArea(
          child: Container(
            width: double.infinity,
            color: AppTheme.appTheme,
            padding: EdgeInsets.fromLTRB(
              context.rw(24),
              context.rh(28),
              context.rw(24),
              context.rh(28),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Options',
                      style: AppTheme.dmSans(
                        fontSize: context.rf(17),
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                    InkWell(
                      onTap: () => Navigator.of(ctx).pop(),
                      child: Icon(Icons.close, color: Colors.white, size: context.rw(26)),
                    ),
                  ],
                ),
                SizedBox(height: context.rh(28)),
                InkWell(
                  onTap: () {
                    Navigator.of(ctx).pop();
                    setState(() {
                      _selectedFrequency.remove(item);
                      globalCart.remove(item);
                    });
                    notifyCartChanged();
                  },
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: context.rh(8)),
                    child: Row(
                      children: [
                        Icon(Icons.delete_outline,
                            color: Colors.white.withValues(alpha: 0.9),
                            size: context.rw(22)),
                        SizedBox(width: context.rw(22)),
                        Text('Remove from Bag',
                            style: AppTheme.dmSans(
                                fontSize: context.rf(14),
                                fontWeight: FontWeight.w400,
                                color: Colors.white)),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: context.rh(10)),
                Divider(height: 1, thickness: 1, color: Colors.white.withValues(alpha: 0.45)),
                SizedBox(height: context.rh(10)),
                InkWell(
                  onTap: () {
                    Navigator.of(ctx).pop();
                    _openQuantitySheet(item);
                  },
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: context.rh(8)),
                    child: Row(
                      children: [
                        Icon(Icons.unfold_more,
                            color: Colors.white.withValues(alpha: 0.9),
                            size: context.rw(22)),
                        SizedBox(width: context.rw(22)),
                        Text('Change Quantity',
                            style: AppTheme.dmSans(
                                fontSize: context.rf(14),
                                fontWeight: FontWeight.w400,
                                color: Colors.white)),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
  void _openQuantitySheet(CartItem item) {
    int selectedQuantity = item.quantity;
    showModalBottomSheet<void>(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      elevation: 0,
      builder: (ctx) {
        return StatefulBuilder(
          builder: (context, setModalState) {
            return SafeArea(
              child: Container(
                width: double.infinity,
                color: AppTheme.appTheme,
                padding: EdgeInsets.fromLTRB(
                  context.rw(22),
                  context.rh(24),
                  context.rw(22),
                  context.rh(24),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Row(
                      children: [
                        InkWell(
                          onTap: () => Navigator.of(ctx).pop(),
                          child: Icon(Icons.arrow_back_ios_new,
                              color: Colors.white, size: context.rw(20)),
                        ),
                        const Spacer(),
                        Text('Quantity',
                            style: AppTheme.dmSans(
                                fontSize: context.rf(18),
                                fontWeight: FontWeight.w600,
                                color: Colors.white)),
                        const Spacer(),
                        InkWell(
                          onTap: () => Navigator.of(ctx).pop(),
                          child: Icon(Icons.close,
                              color: Colors.white, size: context.rw(26)),
                        ),
                      ],
                    ),
                    SizedBox(height: context.rh(28)),
                    SizedBox(
                      height: context.rh(38),
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: List.generate(15, (index) {
                            final qty = index + 1;
                            final isSelected = qty == selectedQuantity;
                            return Padding(
                              padding: EdgeInsets.only(right: context.rw(18)),
                              child: GestureDetector(
                                onTap: () => setModalState(() => selectedQuantity = qty),
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text('$qty',
                                        style: AppTheme.dmSans(
                                            fontSize: context.rf(15),
                                            fontWeight: isSelected
                                                ? FontWeight.w600
                                                : FontWeight.w400,
                                            color: Colors.white)),
                                    SizedBox(height: context.rh(4)),
                                    Container(
                                      width: context.rw(16),
                                      height: 2,
                                      color: isSelected
                                          ? Colors.white
                                          : Colors.transparent,
                                    ),
                                  ],
                                ),
                              ),
                            );
                          }),
                        ),
                      ),
                    ),
                    SizedBox(height: context.rh(28)),
                    SizedBox(
                      width: double.infinity,
                      height: context.rh(40),
                      child: ElevatedButton(
                        onPressed: () {
                          setState(() => item.quantity = selectedQuantity);
                          notifyCartChanged();
                          Navigator.of(ctx).pop();
                        },
                        style: ElevatedButton.styleFrom(
                          elevation: 0,
                          backgroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(0)),
                        ),
                        child: Text('Save',
                            style: AppTheme.dmSans(
                                fontSize: context.rf(13),
                                fontWeight: FontWeight.w500,
                                color: AppTheme.appTheme)),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }
  @override
  Widget build(BuildContext context) {
    final total = _formatCurrency(_cartTotal());
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const AppHeaderSearch(),
            Center(
              child: Padding(
                padding: EdgeInsets.only(bottom: context.rh(20)),
                child: Text(
                  'Your Basket',
                  style: AppTheme.newsreader(
                    fontSize: context.rf(24),
                    fontStyle: FontStyle.italic,
                    color: const Color(0xFF2B2B2B),
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: context.rw(12)),
              child: Text(
                'Your Products',
                style: AppTheme.dmSans(
                  fontSize: context.rf(16),
                  fontWeight: FontWeight.w500,
                  color: const Color(0xFF1F2023),
                ),
              ),
            ),
            SizedBox(height: context.rh(12)),
            if (globalCart.isEmpty)
              Expanded(
                child: Center(
                  child: Text(
                    'Your basket is empty',
                    style: AppTheme.dmSans(
                      fontSize: context.rf(15),
                      color: Colors.grey[600] ?? Colors.grey,
                    ),
                  ),
                ),
              )
            else
              Expanded(
                child: ListView.builder(
                  padding: EdgeInsets.symmetric(
                    horizontal: context.rw(12),
                    vertical: context.rh(8),
                  ),
                  itemCount: globalCart.length,
                  itemBuilder: (context, index) {
                    final cartItem = globalCart[index];
                    return Padding(
                      padding: EdgeInsets.only(bottom: context.rh(14)),
                      child: _buildCartItem(context, cartItem),
                    );
                  },
                ),
              ),
          ],
        ),
      ),
      bottomNavigationBar: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            decoration: const BoxDecoration(
              border: Border(top: BorderSide(color: Color(0xFFE9E9E9))),
              color: Colors.white,
            ),
            padding: EdgeInsets.fromLTRB(
              context.rw(12),
              context.rh(10),
              context.rw(12),
              context.rh(12),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Total: $total',
                  style: AppTheme.dmSans(
                    fontSize: context.rf(13),
                    fontWeight: FontWeight.w600,
                    color: Colors.black87,
                  ),
                ),
                SizedBox(height: context.rh(8)),
                SizedBox(
                  width: double.infinity,
                  height: context.rh(38),
                  child: ElevatedButton(
                    onPressed: globalCart.isEmpty ? null : () {},
                    style: ElevatedButton.styleFrom(
                      elevation: 0,
                      backgroundColor: AppTheme.appTheme,
                      disabledBackgroundColor: const Color(0xFFB3C5C6),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(2)),
                    ),
                    child: Text('Checkout',
                        style: AppTheme.dmSans(
                            fontSize: context.rf(12),
                            fontWeight: FontWeight.w500,
                            color: Colors.white)),
                  ),
                ),
              ],
            ),
          ),
          AppBottomNavBar(
            currentIndex: widget.currentNavIndex,
            onTap: widget.onNavTap,
          ),
        ],
      ),
    );
  }
  Widget _buildCartItem(BuildContext context, CartItem cartItem) {
    final product = cartItem.product;
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: context.rw(116),
          height: context.rh(126),
          decoration: BoxDecoration(
            color: Colors.grey[100],
            borderRadius: BorderRadius.circular(2),
          ),
          clipBehavior: Clip.antiAlias,
          child: Image.asset(
            product.image,
            fit: BoxFit.cover,
            errorBuilder: (context, error, stackTrace) => Center(
              child: Icon(Icons.image_not_supported,
                  color: Colors.grey[400], size: context.rw(22)),
            ),
          ),
        ),
        SizedBox(width: context.rw(10)),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Text(
                      product.name.replaceAll('\n', ' '),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: AppTheme.dmSans(
                        fontSize: context.rf(11.5),
                        fontWeight: FontWeight.w500,
                        color: const Color(0xFF1F2023),
                      ),
                    ),
                  ),
                  SizedBox(width: context.rw(8)),
                  InkWell(
                    onTap: () => _openItemActions(cartItem),
                    child: Icon(Icons.more_vert,
                        size: context.rw(16), color: const Color(0xFF2B2B2B)),
                  ),
                ],
              ),
              SizedBox(height: context.rh(4)),
              Text(product.price,
                  style: AppTheme.dmSans(
                      fontSize: context.rf(11),
                      fontWeight: FontWeight.w500,
                      color: const Color(0xFF1F2023))),
              SizedBox(height: context.rh(4)),
              Text('Notice: Requires 2 days notice',
                  style: AppTheme.dmSans(
                      fontSize: context.rf(9), color: const Color(0xFF1F2023))),
              SizedBox(height: context.rh(2)),
              Text('Color: N/A',
                  style: AppTheme.dmSans(
                      fontSize: context.rf(9), color: const Color(0xFF1F2023))),
              SizedBox(height: context.rh(2)),
              Text('Qty: ${cartItem.quantity}',
                  style: AppTheme.dmSans(
                      fontSize: context.rf(9), color: const Color(0xFF1F2023))),
              SizedBox(height: context.rh(8)),
              SizedBox(
                height: context.rh(28),
                width: context.rw(90),
                child: DropdownButtonFormField<String>(
                  initialValue: _selectedFor(cartItem),
                  iconSize: context.rw(14),
                  isDense: true,
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.symmetric(
                        horizontal: context.rw(8), vertical: context.rh(4)),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(0),
                      borderSide: BorderSide(
                          color: Colors.grey[300] ?? Colors.grey, width: 1),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(0),
                      borderSide: BorderSide(
                          color: Colors.grey[300] ?? Colors.grey, width: 1),
                    ),
                  ),
                  style: AppTheme.dmSans(
                      fontSize: context.rf(9), color: const Color(0xFF1F2023)),
                  items: _frequencyOptions
                      .map((option) =>
                          DropdownMenuItem<String>(value: option, child: Text(option)))
                      .toList(),
                  onChanged: (value) {
                    if (value == null) return;
                    setState(() => _selectedFrequency[cartItem] = value);
                  },
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
