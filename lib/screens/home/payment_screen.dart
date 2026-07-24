import 'package:flutter/material.dart';

import '../../config/theme.dart';
import '../../models/category_model.dart';
import '../../utils/responsive.dart';
import '../../widgets/app_bottom_nav_bar.dart';
import '../../widgets/app_header_search.dart';
import 'order_confirmation_screen.dart';

class PaymentScreen extends StatefulWidget {
  final int currentNavIndex;
  final Function(int) onNavTap;
  final Map<String, String> deliveryDate;
  final String deliveryAddress;

  const PaymentScreen({
    super.key,
    required this.currentNavIndex,
    required this.onNavTap,
    required this.deliveryDate,
    required this.deliveryAddress,
  });

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  int _selectedPaymentMethod = 0; // 0: Credit/Debit Card, 1: PayPal
  bool _useAllowance = false;
  bool _showReferralField = true;
  final TextEditingController _referralController = TextEditingController();

  double get _totalPrice {
    if (globalCart.isEmpty) return 120.0;
    return globalCart.fold<double>(
        0, (sum, item) => sum + ((double.tryParse(item.product.price) ?? 0) * item.quantity));
  }

  @override
  void dispose() {
    _referralController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: size.width * 0.05,
                        vertical: 0,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 16),
                          const AppHeaderSearch(padding: EdgeInsets.zero),
                          SizedBox(height: context.rh(20)),

                          // Screen Title (Newsreader Italic)
                          Center(
                            child: Text(
                              'Payment',
                              style: AppTheme.newsreader(
                                fontSize: context.rf(22),
                                fontStyle: FontStyle.italic,
                                color: const Color(0xFF1F2023),
                              ),
                            ),
                          ),
                          SizedBox(height: context.rh(24)),

                          // Payment Methods Section
                          Text(
                            'Payment Methods',
                            style: AppTheme.dmSans(
                              fontSize: context.rf(13),
                              fontWeight: FontWeight.w500,
                              color: const Color(0xFF1F2023),
                              height: 1.2,
                            ),
                          ),
                          SizedBox(height: context.rh(12)),

                          // Card Icons Row (VISA, MasterCard, Amex, PayPal badges)
                          Row(
                            children: [
                              _buildCardBadge('VISA', const Color(0xFF1A1F71)),
                              SizedBox(width: context.rw(6)),
                              _buildCardBadge('MC', const Color(0xFFEB001B)),
                              SizedBox(width: context.rw(6)),
                              _buildCardBadge('AMEX', const Color(0xFF006FCF)),
                              SizedBox(width: context.rw(6)),
                              _buildCardBadge('PayPal', const Color(0xFF003087)),
                            ],
                          ),
                          SizedBox(height: context.rh(16)),

                          // Option 1: Credit/Debit Card
                          GestureDetector(
                            onTap: () =>
                                setState(() => _selectedPaymentMethod = 0),
                            child: Container(
                              width: double.infinity,
                              padding: EdgeInsets.symmetric(
                                horizontal: context.rw(14),
                                vertical: context.rh(12),
                              ),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                border: Border.all(
                                  color: _selectedPaymentMethod == 0
                                      ? const Color(0xFF587B7F)
                                      : const Color(0xFF1F2023),
                                  width: _selectedPaymentMethod == 0 ? 1.5 : 1.0,
                                ),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Credit/Debit Card',
                                    style: AppTheme.dmSans(
                                      fontSize: context.rf(13),
                                      fontWeight: FontWeight.w500,
                                      color: const Color(0xFF1F2023),
                                    ),
                                  ),
                                  SizedBox(height: context.rh(2)),
                                  Text(
                                    'Use your card to pay',
                                    style: AppTheme.dmSans(
                                      fontSize: context.rf(9),
                                      color: const Color(0xFF7A9AA0),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(height: context.rh(12)),

                          // Option 2: PayPal
                          GestureDetector(
                            onTap: () =>
                                setState(() => _selectedPaymentMethod = 1),
                            child: Container(
                              width: double.infinity,
                              padding: EdgeInsets.symmetric(
                                horizontal: context.rw(14),
                                vertical: context.rh(12),
                              ),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                border: Border.all(
                                  color: _selectedPaymentMethod == 1
                                      ? const Color(0xFF587B7F)
                                      : const Color(0xFF1F2023),
                                  width: _selectedPaymentMethod == 1 ? 1.5 : 1.0,
                                ),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'PayPal',
                                    style: AppTheme.dmSans(
                                      fontSize: context.rf(13),
                                      fontWeight: FontWeight.w500,
                                      color: const Color(0xFF1F2023),
                                    ),
                                  ),
                                  SizedBox(height: context.rh(2)),
                                  Text(
                                    'Pay today (your order contains product that don\'t qualify for Pay in 3 option)',
                                    style: AppTheme.dmSans(
                                      fontSize: context.rf(9),
                                      color: const Color(0xFF7A9AA0),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(height: context.rh(28)),
                        ],
                      ),
                    ),

                    // Allowance Banner (Full width Dark Teal bar)
                    Container(
                      width: double.infinity,
                      padding: EdgeInsets.symmetric(
                        horizontal: size.width * 0.05,
                        vertical: context.rh(14),
                      ),
                      color: const Color(0xFF587B7F),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Text(
                              'I want to use my £1,200 sub800 allowance',
                              style: AppTheme.dmSans(
                                fontSize: context.rf(12),
                                color: Colors.white,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ),
                          Switch(
                            value: _useAllowance,
                            activeThumbColor: Colors.white,
                            activeTrackColor: Colors.white.withValues(alpha: 0.4),
                            onChanged: (val) {
                              setState(() => _useAllowance = val);
                            },
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: context.rh(24)),

                    // Referral Code Section
                    Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: size.width * 0.05,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          GestureDetector(
                            onTap: () => setState(
                                () => _showReferralField = !_showReferralField),
                            child: Row(
                              children: [
                                Icon(
                                  _showReferralField
                                      ? Icons.keyboard_arrow_down
                                      : Icons.keyboard_arrow_right,
                                  size: context.rw(18),
                                  color: const Color(0xFF1F2023),
                                ),
                                SizedBox(width: context.rw(4)),
                                Text(
                                  'Add a referral code',
                                  style: AppTheme.dmSans(
                                    fontSize: context.rf(13),
                                    fontWeight: FontWeight.w500,
                                    color: const Color(0xFF1F2023),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          if (_showReferralField) ...[
                            SizedBox(height: context.rh(10)),
                            Container(
                              height: context.rh(38),
                              padding: EdgeInsets.symmetric(
                                  horizontal: context.rw(12)),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                border: Border.all(
                                    color: const Color(0xFF7A9AA0), width: 1),
                                borderRadius: BorderRadius.zero,
                              ),
                              child: TextField(
                                controller: _referralController,
                                style: AppTheme.dmSans(
                                  fontSize: context.rf(11),
                                  color: const Color(0xFF1F2023),
                                ),
                                decoration: InputDecoration(
                                  hintText: 'Add referral code',
                                  hintStyle: AppTheme.dmSans(
                                    fontSize: context.rf(11),
                                    color: const Color(0xFF7A9AA0),
                                  ),
                                  border: InputBorder.none,
                                  isDense: true,
                                  contentPadding: EdgeInsets.symmetric(
                                      vertical: context.rh(10)),
                                ),
                              ),
                            ),
                          ],
                          SizedBox(height: context.rh(40)),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // Bottom Fixed Section
            Container(
              padding: EdgeInsets.symmetric(
                horizontal: size.width * 0.05,
                vertical: context.rh(16),
              ),
              decoration: const BoxDecoration(
                color: Colors.white,
                border: Border(
                  top: BorderSide(color: Color(0xFFEEEEEE), width: 1),
                ),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Total £${_totalPrice.toStringAsFixed(0)}',
                    style: AppTheme.dmSans(
                      fontSize: context.rf(13),
                      fontWeight: FontWeight.w700,
                      color: const Color(0xFF1F2023),
                    ),
                  ),
                  SizedBox(height: context.rh(10)),
                  SizedBox(
                    width: double.infinity,
                    height: context.rh(40),
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (_) => OrderConfirmationScreen(
                              currentNavIndex: widget.currentNavIndex,
                              onNavTap: widget.onNavTap,
                              deliveryDate: widget.deliveryDate,
                              deliveryAddress: widget.deliveryAddress,
                            ),
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        elevation: 0,
                        backgroundColor: const Color(0xFF587B7F),
                        shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.zero),
                      ),
                      child: Text(
                        'Make Payment',
                        style: AppTheme.dmSans(
                          fontSize: context.rf(12),
                          fontWeight: FontWeight.w500,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: AppBottomNavBar(
        currentIndex: widget.currentNavIndex,
        onTap: (i) {
          widget.onNavTap(i);
          Navigator.of(context).popUntil((route) => route.isFirst);
        },
      ),
    );
  }

  Widget _buildCardBadge(String label, Color color) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: context.rw(8),
        vertical: context.rh(4),
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: const Color(0xFFE0E0E0), width: 1),
        borderRadius: BorderRadius.circular(2),
      ),
      child: Text(
        label,
        style: AppTheme.dmSans(
          fontSize: context.rf(9),
          fontWeight: FontWeight.w700,
          color: color,
        ),
      ),
    );
  }
}
