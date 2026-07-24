import 'package:flutter/material.dart';

import '../../config/theme.dart';
import '../../models/category_model.dart';
import '../../utils/responsive.dart';
import '../../widgets/app_bottom_nav_bar.dart';
import '../../widgets/app_header_search.dart';
import 'payment_screen.dart';

class DeliveryScreen extends StatefulWidget {
  final int currentNavIndex;
  final Function(int) onNavTap;

  const DeliveryScreen({
    super.key,
    required this.currentNavIndex,
    required this.onNavTap,
  });

  @override
  State<DeliveryScreen> createState() => _DeliveryScreenState();
}

class _DeliveryScreenState extends State<DeliveryScreen> {
  int _selectedDateIndex = 0;
  String _selectedTimeSlot = '09:00 - 12:00';
  final TextEditingController _addressController =
      TextEditingController(text: '3rd Floor, 20-22 Vestry Street, London, EC1M 4AN');

  static const List<Map<String, String>> _deliveryDates = [
    {'day': 'Monday', 'date': '09', 'month': 'June'},
    {'day': 'Tuesday', 'date': '10', 'month': 'June'},
    {'day': 'Wednesday', 'date': '11', 'month': 'June'},
    {'day': 'Thursday', 'date': '12', 'month': 'June'},
    {'day': 'Friday', 'date': '13', 'month': 'June'},
    {'day': 'Saturday', 'date': '14', 'month': 'June'},
    {'day': 'Sunday', 'date': '15', 'month': 'June'},
  ];

  static const List<String> _timeSlots = [
    '09:00 - 12:00',
    '12:00 - 15:00',
    '15:00 - 18:00',
  ];

  double get _totalPrice {
    if (globalCart.isEmpty) return 120.0;
    return globalCart.fold<double>(
        0, (sum, item) => sum + ((double.tryParse(item.product.price) ?? 0) * item.quantity));
  }

  @override
  void dispose() {
    _addressController.dispose();
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
                child: Padding(
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
                          'Delivery',
                          style: AppTheme.newsreader(
                            fontSize: context.rf(22),
                            fontStyle: FontStyle.italic,
                            color: const Color(0xFF1F2023),
                          ),
                        ),
                      ),
                      SizedBox(height: context.rh(28)),

                      // Delivery Address Section
                      Text(
                        'Delivery Address',
                        style: AppTheme.dmSans(
                          fontSize: context.rf(13),
                          fontWeight: FontWeight.w500,
                          color: const Color(0xFF1F2023),
                          height: 1.2,
                        ),
                      ),
                      SizedBox(height: context.rh(10)),
                      Row(
                        children: [
                          Expanded(
                            child: Container(
                              height: context.rh(38),
                              padding: EdgeInsets.symmetric(horizontal: context.rw(12)),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                border: Border.all(
                                    color: const Color(0xFF7A9AA0), width: 1),
                                borderRadius: BorderRadius.zero,
                              ),
                              child: TextField(
                                controller: _addressController,
                                style: AppTheme.dmSans(
                                  fontSize: context.rf(11),
                                  color: const Color(0xFF1F2023),
                                ),
                                decoration: InputDecoration(
                                  hintText: 'Enter postcode or full address',
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
                          ),
                          SizedBox(width: context.rw(8)),
                          Container(
                            width: context.rw(38),
                            height: context.rh(38),
                            decoration: BoxDecoration(
                              color: const Color(0xFFF2F4F4),
                              shape: BoxShape.circle,
                            ),
                            child: Icon(
                              Icons.search,
                              size: context.rw(18),
                              color: const Color(0xFF1F2023),
                            ),
                          ),
                        ],
                      ),

                      SizedBox(height: context.rh(28)),

                      // Delivery Date Section
                      Text(
                        'Delivery Date',
                        style: AppTheme.dmSans(
                          fontSize: context.rf(13),
                          fontWeight: FontWeight.w500,
                          color: const Color(0xFF1F2023),
                          height: 1.2,
                        ),
                      ),
                      SizedBox(height: context.rh(12)),

                      // Date Cards Strip
                      SizedBox(
                        height: context.rh(65),
                        child: ListView.separated(
                          scrollDirection: Axis.horizontal,
                          itemCount: _deliveryDates.length,
                          separatorBuilder: (_, __) =>
                              SizedBox(width: context.rw(8)),
                          itemBuilder: (context, index) {
                            final item = _deliveryDates[index];
                            final isSelected = index == _selectedDateIndex;

                            return GestureDetector(
                              onTap: () =>
                                  setState(() => _selectedDateIndex = index),
                              child: Container(
                                width: context.rw(55),
                                decoration: BoxDecoration(
                                  color: isSelected
                                      ? const Color(0xFF587B7F)
                                      : Colors.white,
                                  border: Border.all(
                                    color: const Color(0xFF587B7F),
                                    width: 1.5,
                                  ),
                                  borderRadius: BorderRadius.zero,
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      item['day']!,
                                      style: AppTheme.dmSans(
                                        fontSize: context.rf(9),
                                        color: isSelected
                                            ? Colors.white
                                            : const Color(0xFF1F2023),
                                        height: 1.2,
                                      ),
                                    ),
                                    SizedBox(height: context.rh(2)),
                                    Text(
                                      item['date']!,
                                      style: AppTheme.dmSans(
                                        fontSize: context.rf(16),
                                        fontWeight: FontWeight.w600,
                                        color: isSelected
                                            ? Colors.white
                                            : const Color(0xFF1F2023),
                                        height: 1.2,
                                      ),
                                    ),
                                    SizedBox(height: context.rh(2)),
                                    Text(
                                      item['month']!,
                                      style: AppTheme.dmSans(
                                        fontSize: context.rf(9),
                                        color: isSelected
                                            ? Colors.white
                                            : const Color(0xFF1F2023),
                                        height: 1.2,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                      ),

                      SizedBox(height: context.rh(28)),

                      // Select Time Slot Section
                      Text(
                        'Select Time Slot',
                        style: AppTheme.dmSans(
                          fontSize: context.rf(13),
                          fontWeight: FontWeight.w500,
                          color: const Color(0xFF1F2023),
                          height: 1.2,
                        ),
                      ),
                      SizedBox(height: context.rh(10)),

                      Container(
                        height: context.rh(38),
                        width: double.infinity,
                        padding: EdgeInsets.symmetric(horizontal: context.rw(12)),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(
                              color: const Color(0xFF7A9AA0), width: 1),
                          borderRadius: BorderRadius.zero,
                        ),
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton<String>(
                            value: _selectedTimeSlot,
                            isExpanded: true,
                            icon: const Icon(Icons.keyboard_arrow_down,
                                color: Color(0xFF1F2023)),
                            style: AppTheme.dmSans(
                              fontSize: context.rf(11),
                              color: const Color(0xFF1F2023),
                            ),
                            items: _timeSlots.map((slot) {
                              return DropdownMenuItem<String>(
                                value: slot,
                                child: Text(slot),
                              );
                            }).toList(),
                            onChanged: (val) {
                              if (val != null) {
                                setState(() => _selectedTimeSlot = val);
                              }
                            },
                          ),
                        ),
                      ),
                      SizedBox(height: context.rh(40)),
                    ],
                  ),
                ),
              ),
            ),

            // Bottom Fixed Checkout Section
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
                    'Total: £${_totalPrice.toStringAsFixed(0)}',
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
                            builder: (_) => PaymentScreen(
                              currentNavIndex: widget.currentNavIndex,
                              onNavTap: widget.onNavTap,
                              deliveryDate: _deliveryDates[_selectedDateIndex],
                              deliveryAddress: _addressController.text,
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
                        'Checkout',
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
}
