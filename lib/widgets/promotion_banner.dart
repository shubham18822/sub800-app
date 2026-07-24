import 'package:flutter/material.dart';
import '../config/theme.dart';
import '../models/category_model.dart';
import '../utils/responsive.dart';

class PromotionBanner extends StatelessWidget {
  final Promotion promotion;
  final VoidCallback? onTap;

  const PromotionBanner({
    super.key,
    required this.promotion,
    this.onTap,
  });

  Color _parseHexColor(String hexString) {
    final buffer = StringBuffer();
    if (hexString.length == 6 || hexString.length == 7) buffer.write('ff');
    buffer.write(hexString.replaceFirst('#', ''));
    return Color(int.parse(buffer.toString(), radix: 16));
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: context.rw(280),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.zero,
          color: _parseHexColor(promotion.backgroundColor),
        ),
        child: Stack(
          children: [
            // Background image
            Positioned.fill(
              child: ClipRRect(
                borderRadius: BorderRadius.zero,
                child: Image.asset(
                  promotion.backgroundImage,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) =>
                      const SizedBox.shrink(),
                  color: Colors.black.withValues(alpha: 0.35),
                  colorBlendMode: BlendMode.multiply,
                ),
              ),
            ),

            // Text overlay & solid white rectangular button
            Padding(
              padding: EdgeInsets.all(context.rw(16)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    width: context.rw(220),
                    child: Text(
                      promotion.title,
                      style: AppTheme.newsreader(
                        fontSize: context.rf(16),
                        fontStyle: FontStyle.italic,
                        color: Colors.white,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        promotion.subtitle,
                        style: AppTheme.dmSans(
                          fontSize: context.rf(11),
                          color: Colors.white.withValues(alpha: 0.9),
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      SizedBox(height: context.rh(12)),

                      // Solid White Rectangular Button with Black Text and zero border radius
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: context.rw(14),
                          vertical: context.rh(8),
                        ),
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.zero,
                        ),
                        child: Text(
                          promotion.buttonText,
                          style: AppTheme.dmSans(
                            fontSize: context.rf(11),
                            fontWeight: FontWeight.w500,
                            color: Colors.black87,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
