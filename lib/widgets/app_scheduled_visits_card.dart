import 'package:flutter/material.dart';

import '../config/theme.dart';
import '../utils/responsive.dart';

class AppScheduledVisitsCard extends StatelessWidget {
  final DateTime date;
  final VoidCallback onClose;

  const AppScheduledVisitsCard({
    super.key,
    required this.date,
    required this.onClose,
  });

  String _getFormattedSubDate(DateTime date) {
    const fullWeekdays = [
      'Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday', 'Sunday'
    ];
    const fullMonths = [
      'January', 'February', 'March', 'April', 'May', 'June',
      'July', 'August', 'September', 'October', 'November', 'December'
    ];

    String daySuffix(int d) {
      if (d >= 11 && d <= 13) return 'th';
      switch (d % 10) {
        case 1: return 'st';
        case 2: return 'nd';
        case 3: return 'rd';
        default: return 'th';
      }
    }

    final weekdayName = fullWeekdays[date.weekday - 1];
    final monthName = fullMonths[date.month - 1];
    return '$weekdayName ${date.day}${daySuffix(date.day)} $monthName ${date.year}';
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.only(bottom: context.rh(16)),
      padding: EdgeInsets.symmetric(
        horizontal: context.rw(16),
        vertical: context.rh(20),
      ),
      decoration: const BoxDecoration(
        color: Color(0xFF587B7F),
        borderRadius: BorderRadius.zero,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header Row
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Your Scheduled Visits',
                    style: AppTheme.dmSans(
                      fontSize: context.rf(18),
                      fontWeight: FontWeight.w500,
                      color: Colors.white,
                      height: 1.2,
                    ),
                  ),
                  SizedBox(height: context.rh(4)),
                  Text(
                    _getFormattedSubDate(date),
                    style: AppTheme.dmSans(
                      fontSize: context.rf(11),
                      color: Colors.white.withValues(alpha: 0.85),
                      height: 1.2,
                    ),
                  ),
                ],
              ),
              GestureDetector(
                onTap: onClose,
                child: Icon(
                  Icons.close,
                  size: context.rw(22),
                  color: Colors.white,
                ),
              ),
            ],
          ),
          SizedBox(height: context.rh(24)),

          // Timeline Slots
          _buildTimeSlotRow(context, '09:00', eventTitle: 'Boiler Review', eventCategory: 'Maintenance'),
          _buildTimeSlotRow(context, '10:00'),
          _buildTimeSlotRow(context, '10:30'),
          _buildTimeSlotRow(context, '11:00', eventTitle: 'Food & Beverage Delivery', eventCategory: 'F&B'),
          _buildTimeSlotRow(context, '11:30'),
          _buildTimeSlotRow(context, '12:00'),
          _buildTimeSlotRow(context, '12:30', isCurrentTimeLine: true),
          _buildTimeSlotRow(context, '13:00'),
          _buildTimeSlotRow(context, '13:30'),
          _buildTimeSlotRow(context, '14:00', eventTitle: 'Dedicated Account Manager Visit', eventCategory: 'Concierge'),
          _buildTimeSlotRow(context, '14:30'),
          _buildTimeSlotRow(context, '15:00'),
          _buildTimeSlotRow(context, '15:30'),
          _buildTimeSlotRow(context, '16:00'),
          _buildTimeSlotRow(context, '16:30'),
          _buildTimeSlotRow(context, '17:00'),
        ],
      ),
    );
  }

  Widget _buildTimeSlotRow(
    BuildContext context,
    String time, {
    String? eventTitle,
    String? eventCategory,
    bool isCurrentTimeLine = false,
  }) {
    return Padding(
      padding: EdgeInsets.only(bottom: context.rh(8)),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: context.rw(48),
            child: Text(
              time,
              style: AppTheme.dmSans(
                fontSize: context.rf(12),
                fontWeight: FontWeight.w600,
                color: Colors.white,
                height: 1.2,
              ),
            ),
          ),
          SizedBox(width: context.rw(8)),
          Expanded(
            child: isCurrentTimeLine
                ? Row(
                    children: [
                      Container(
                        width: context.rw(8),
                        height: context.rw(8),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(color: Colors.white, width: 1.5),
                        ),
                      ),
                      Expanded(
                        child: Container(
                          height: 1,
                          color: Colors.white.withValues(alpha: 0.8),
                        ),
                      ),
                    ],
                  )
                : (eventTitle != null
                    ? Container(
                        width: double.infinity,
                        padding: EdgeInsets.symmetric(
                          horizontal: context.rw(12),
                          vertical: context.rh(10),
                        ),
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.zero,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              eventTitle,
                              style: AppTheme.dmSans(
                                fontSize: context.rf(12),
                                fontWeight: FontWeight.w500,
                                color: const Color(0xFF1F2023),
                                height: 1.2,
                              ),
                            ),
                            SizedBox(height: context.rh(2)),
                            Text(
                              eventCategory!,
                              style: AppTheme.dmSans(
                                fontSize: context.rf(9),
                                color: const Color(0xFF7A9AA0),
                                height: 1.2,
                              ),
                            ),
                          ],
                        ),
                      )
                    : const SizedBox.shrink()),
          ),
        ],
      ),
    );
  }
}
