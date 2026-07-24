import 'package:flutter/material.dart';
import '../config/theme.dart';
import '../models/category_model.dart';
import '../utils/responsive.dart';

enum CategoryItemVariant { circle, listTile }

class CategoryItem extends StatelessWidget {
  final Category category;
  final VoidCallback? onTap;
  final CategoryItemVariant variant;

  const CategoryItem({
    super.key,
    required this.category,
    this.onTap,
    this.variant = CategoryItemVariant.circle,
  });

  @override
  Widget build(BuildContext context) {
    if (variant == CategoryItemVariant.listTile) {
      return Column(
        children: [
          InkWell(
            onTap: onTap,
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: context.rw(20),
                vertical: context.rh(14),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      category.name,
                      style: AppTheme.dmSans(
                        fontSize: context.rf(13),
                        fontWeight: FontWeight.w400,
                        color: const Color(0xFF345556),
                      ),
                    ),
                  ),
                  Icon(
                    Icons.chevron_right_rounded,
                    color: Colors.grey[400],
                    size: context.rw(20),
                  ),
                ],
              ),
            ),
          ),
          Divider(
            height: 1,
            thickness: 0.5,
            indent: context.rw(20),
            endIndent: 0,
            color: Colors.grey.withValues(alpha: 0.15),
          ),
        ],
      );
    }

    // Default circle variant
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Container(
            width: context.rw(72),
            height: context.rw(72),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              image: DecorationImage(
                image: AssetImage(category.backgroundImage),
                fit: BoxFit.cover,
              ),
            ),
          ),
          SizedBox(height: context.rh(8)),
          SizedBox(
            width: context.rw(78),
            child: Text(
              category.name,
              textAlign: TextAlign.center,
              style: AppTheme.dmSans(
                fontSize: context.rf(11),
                fontWeight: FontWeight.w400,
                color: const Color(0xFF345556),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
