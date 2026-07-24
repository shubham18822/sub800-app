import 'package:flutter/material.dart';

import '../config/theme.dart';
import '../utils/responsive.dart';
import 'app_logo.dart';

class AppHeaderSearch extends StatefulWidget {
  const AppHeaderSearch({
    super.key,
    this.padding,
    this.hintText = 'Search here',
    this.onChanged,
  });

  final EdgeInsetsGeometry? padding;
  final String hintText;
  final ValueChanged<String>? onChanged;

  @override
  State<AppHeaderSearch> createState() => _AppHeaderSearchState();
}

class _AppHeaderSearchState extends State<AppHeaderSearch> {
  final TextEditingController _controller = TextEditingController();
  final FocusNode _focusNode = FocusNode();
  bool _isExpanded = false;

  @override
  void dispose() {
    _controller.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  void _expand() {
    if (_isExpanded) return;
    setState(() {
      _isExpanded = true;
    });
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        _focusNode.requestFocus();
      }
    });
  }

  void _collapse() {
    if (!_isExpanded) return;
    _focusNode.unfocus();
    setState(() {
      _isExpanded = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final resolvedPadding =
        widget.padding ??
        EdgeInsets.symmetric(horizontal: width * 0.05, vertical: 16);

    return Padding(
      padding: resolvedPadding,
      child: Row(
        children: [
          const AppLogo(),
          const Spacer(),
          TapRegion(
            onTapOutside: (_) => _collapse(),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              curve: Curves.easeOut,
              width: _isExpanded ? width * 0.42 : context.rw(40),
              height: context.rw(40),
              decoration: BoxDecoration(
                color: _isExpanded ? const Color(0xFFF3F3F3) : Colors.white,
                borderRadius: BorderRadius.circular(context.rw(20)),
                border: Border.all(
                  color: Colors.grey.withValues(alpha: _isExpanded ? 0.0 : 0.15),
                ),
              ),
              child: _isExpanded
                  ? Row(
                      children: [
                        Expanded(
                          child: TextField(
                            controller: _controller,
                            focusNode: _focusNode,
                            onChanged: widget.onChanged,
                            textInputAction: TextInputAction.search,
                            textAlignVertical: TextAlignVertical.center,
                            style: AppTheme.dmSans(
                              fontSize: context.rf(13),
                              color: Colors.black87,
                            ),
                            decoration: InputDecoration(
                              isDense: true,
                              hintText: widget.hintText,
                              hintStyle: AppTheme.dmSans(
                                fontSize: context.rf(13),
                                color: Colors.grey[500] ?? Colors.grey,
                              ),
                              border: InputBorder.none,
                              contentPadding: EdgeInsets.symmetric(
                                horizontal: context.rw(12),
                                vertical: 0,
                              ),
                            ),
                          ),

                        ),
                        Padding(
                          padding: EdgeInsets.only(right: context.rw(10)),
                          child: Icon(
                            Icons.search,
                            size: context.rw(16),
                            color: Colors.black54,
                          ),
                        ),
                      ],
                    )
                  : Material(
                      color: Colors.transparent,
                      child: InkWell(
                        borderRadius: BorderRadius.circular(context.rw(20)),
                        onTap: _expand,
                        child: Center(
                          child: Icon(
                            Icons.search,
                            size: context.rw(18),
                            color: Colors.black54,
                          ),
                        ),
                      ),
                    ),
            ),
          ),
        ],
      ),
    );
  }
}

