import 'package:flutter/material.dart';
import '../config/theme.dart';
import '../utils/responsive.dart';

class SectionHeader extends StatelessWidget {
  final String title;
  final String? actionLabel;
  final VoidCallback? onActionTap;

  const SectionHeader({
    super.key,
    required this.title,
    this.actionLabel,
    this.onActionTap,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: AppTheme.dmSans(
            fontSize: context.rf(12),
            fontWeight: FontWeight.w400,
            color: Colors.black87,
          ),
        ),
        if (actionLabel != null && onActionTap != null)
          GestureDetector(
            onTap: onActionTap,
            child: Text(
              actionLabel!,
              style: AppTheme.dmSans(
                fontSize: context.rf(8),
                fontWeight: FontWeight.w400,
                color: Colors.grey[400] ?? Colors.grey,
              ).copyWith(decoration: TextDecoration.underline),
            ),
          ),
      ],
    );
  }
}
