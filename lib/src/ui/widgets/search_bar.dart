import 'dart:async';
import 'package:flutter/material.dart';
import 'package:storekepper_app/src/app/constants/color.dart';

class CustomSearchBar extends StatefulWidget {
  const CustomSearchBar({super.key, required this.onChanged});

  final ValueChanged<String> onChanged;

  @override
  State<CustomSearchBar> createState() => _CustomSearchBarState();
}

class _CustomSearchBarState extends State<CustomSearchBar> {
  final FocusNode _focusNode = FocusNode();
  final TextEditingController _controller = TextEditingController();
  bool isActive = false;
  Timer? _idleTimer;

// MAKES SURE SEARCH BAR IS NOT ACTIVE WHEN IDLE FOR 3 SEC
  void _resetIdleTimer() {
    _idleTimer?.cancel();
    _idleTimer = Timer(const Duration(seconds: 3), () {
      if (mounted) {
        setState(() {
          isActive = false;
        });
        _focusNode.unfocus();
      }
    });
  }

  @override
  void dispose() {
    _focusNode.dispose();
    _controller.dispose();
    _idleTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() => isActive = true);
        _focusNode.requestFocus();
      },
      child: Container(
        decoration: BoxDecoration(
          color: isActive ? Colors.white : Colors.grey.shade100,
          borderRadius: BorderRadius.circular(8),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 12),
        child: TextField(
          focusNode: _focusNode,
          controller: _controller,
          decoration: InputDecoration(
            hintText: 'Anything in mind?..',
            border: InputBorder.none,
            icon: Icon(Icons.barcode_reader, color: AppColors.primaryColor),
          ),
          onChanged: (value) {
            widget.onChanged(value);
            _resetIdleTimer();
          },
        ),
      ),
    );
  }
}
