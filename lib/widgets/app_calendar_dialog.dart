import 'package:flutter/material.dart';

import '../config/theme.dart';
import '../utils/responsive.dart';

class AppCalendarDialog extends StatefulWidget {
  final DateTime? initialDate;
  final ValueChanged<DateTime>? onDateSelected;
  final List<DateTime>? eventDates;

  const AppCalendarDialog({
    super.key,
    this.initialDate,
    this.onDateSelected,
    this.eventDates,
  });

  /// Helper method to open calendar dialog anywhere in the app
  static Future<DateTime?> show(
    BuildContext context, {
    DateTime? initialDate,
    List<DateTime>? eventDates,
  }) {
    return showDialog<DateTime>(
      context: context,
      barrierColor: Colors.black.withValues(alpha: 0.35),
      builder: (_) => AppCalendarDialog(
        initialDate: initialDate,
        eventDates: eventDates,
      ),
    );
  }

  @override
  State<AppCalendarDialog> createState() => _AppCalendarDialogState();
}

class _AppCalendarDialogState extends State<AppCalendarDialog> {
  late DateTime _focusedMonth;
  late DateTime _selectedDate;

  static const List<String> _monthNames = [
    'January', 'February', 'March', 'April', 'May', 'June',
    'July', 'August', 'September', 'October', 'November', 'December'
  ];

  @override
  void initState() {
    super.initState();
    _selectedDate = widget.initialDate ?? DateTime(2026, 6, 20);
    _focusedMonth = DateTime(_selectedDate.year, _selectedDate.month);
  }

  void _previousMonth() {
    setState(() {
      _focusedMonth = DateTime(_focusedMonth.year, _focusedMonth.month - 1);
    });
  }

  void _nextMonth() {
    setState(() {
      _focusedMonth = DateTime(_focusedMonth.year, _focusedMonth.month + 1);
    });
  }

  bool _isSameDay(DateTime a, DateTime b) {
    return a.year == b.year && a.month == b.month && a.day == b.day;
  }

  bool _hasEvent(DateTime date) {
    if (widget.eventDates != null) {
      return widget.eventDates!.any((d) => _isSameDay(d, date));
    }
    // Default demo event on June 15, 2026
    return date.year == 2026 && date.month == 6 && date.day == 15;
  }

  @override
  Widget build(BuildContext context) {
    final monthTitle = '${_monthNames[_focusedMonth.month - 1]}, ${_focusedMonth.year}';

    return Dialog(
      backgroundColor: Colors.transparent,
      insetPadding: EdgeInsets.symmetric(horizontal: context.rw(20)),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Close button top right
          Align(
            alignment: Alignment.topRight,
            child: GestureDetector(
              onTap: () => Navigator.of(context).pop(),
              child: Container(
                padding: EdgeInsets.all(context.rw(4)),
                child: Icon(
                  Icons.close,
                  color: Colors.black87,
                  size: context.rw(24),
                ),
              ),
            ),
          ),
          SizedBox(height: context.rh(8)),

          // Calendar Card
          Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(
              horizontal: context.rw(20),
              vertical: context.rh(24),
            ),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(0),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.1),
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Header Row: Month Year < >
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      monthTitle,
                      style: AppTheme.dmSans(
                        fontSize: context.rf(16),
                        fontWeight: FontWeight.w500,
                        color: const Color(0xFF1F2023),
                        height: 1.2,
                      ),
                    ),
                    Row(
                      children: [
                        GestureDetector(
                          onTap: _previousMonth,
                          child: Icon(
                            Icons.chevron_left,
                            size: context.rw(22),
                            color: const Color(0xFF587B7F),
                          ),
                        ),
                        SizedBox(width: context.rw(12)),
                        GestureDetector(
                          onTap: _nextMonth,
                          child: Icon(
                            Icons.chevron_right,
                            size: context.rw(22),
                            color: const Color(0xFF587B7F),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(height: context.rh(20)),

                // Weekdays Header
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: ['Mon', 'Tue', 'Wed', 'Thur', 'Fri', 'Sat', 'Sun']
                      .map(
                        (day) => SizedBox(
                          width: context.rw(36),
                          child: Text(
                            day,
                            textAlign: TextAlign.center,
                            style: AppTheme.dmSans(
                              fontSize: context.rf(11),
                              fontWeight: FontWeight.w400,
                              color: const Color(0xFF1F2023),
                              height: 1.2,
                            ),
                          ),
                        ),
                      )
                      .toList(),
                ),
                SizedBox(height: context.rh(16)),

                // Days Grid
                _buildDaysGrid(context),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDaysGrid(BuildContext context) {
    final firstDayOfMonth = DateTime(_focusedMonth.year, _focusedMonth.month, 1);
    final daysInMonth = DateTime(_focusedMonth.year, _focusedMonth.month + 1, 0).day;
    
    // ISO weekday: Monday = 1, Sunday = 7
    final startingWeekday = firstDayOfMonth.weekday;
    final prevMonthDays = DateTime(_focusedMonth.year, _focusedMonth.month, 0).day;

    final List<DateTime> gridDates = [];

    // Previous month trailing days
    for (int i = startingWeekday - 1; i > 0; i--) {
      gridDates.add(DateTime(_focusedMonth.year, _focusedMonth.month - 1, prevMonthDays - i + 1));
    }

    // Current month days
    for (int i = 1; i <= daysInMonth; i++) {
      gridDates.add(DateTime(_focusedMonth.year, _focusedMonth.month, i));
    }

    // Next month leading days to complete grid (5 rows x 7 cols = 35 or 6 rows x 7 cols = 42)
    final totalCells = gridDates.length > 35 ? 42 : 35;
    final remainingCells = totalCells - gridDates.length;
    for (int i = 1; i <= remainingCells; i++) {
      gridDates.add(DateTime(_focusedMonth.year, _focusedMonth.month + 1, i));
    }

    final rowCount = totalCells ~/ 7;

    return Column(
      children: List.generate(rowCount, (rowIndex) {
        return Padding(
          padding: EdgeInsets.only(bottom: context.rh(10)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: List.generate(7, (colIndex) {
              final index = rowIndex * 7 + colIndex;
              final date = gridDates[index];
              final isCurrentMonth = date.month == _focusedMonth.month;
              final isSelected = _isSameDay(date, _selectedDate);
              final hasEvent = _hasEvent(date);

              return GestureDetector(
                onTap: () {
                  setState(() {
                    _selectedDate = date;
                    if (date.month != _focusedMonth.month) {
                      _focusedMonth = DateTime(date.year, date.month);
                    }
                  });
                  widget.onDateSelected?.call(date);
                  Navigator.of(context).pop(date);
                },
                child: Container(
                  width: context.rw(36),
                  height: context.rw(36),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: isSelected ? const Color(0xFF587B7F) : Colors.transparent,
                    shape: BoxShape.circle,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        '${date.day}',
                        style: AppTheme.dmSans(
                          fontSize: context.rf(12),
                          fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
                          color: isSelected
                              ? Colors.white
                              : (isCurrentMonth
                                  ? const Color(0xFF1F2023)
                                  : const Color(0xFFC0C0C0)),
                          height: 1.2,
                        ),
                      ),
                      if (hasEvent) ...[
                        SizedBox(height: context.rh(1)),
                        Container(
                          width: context.rw(3),
                          height: context.rw(3),
                          decoration: BoxDecoration(
                            color: isSelected ? Colors.white : const Color(0xFF587B7F),
                            shape: BoxShape.circle,
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
              );
            }),
          ),
        );
      }),
    );
  }
}
