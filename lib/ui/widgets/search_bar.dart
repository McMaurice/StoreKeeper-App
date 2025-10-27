import 'package:flutter/material.dart';
import 'package:storekepper_app/app/constants/color.dart';

class CustomSearchBar extends StatefulWidget {
  const CustomSearchBar({
    super.key,
    required this.onChanged,
  });

  // callback instead of storing state here
  final ValueChanged<String> onChanged;

  @override
  State<CustomSearchBar> createState() => _CustomSearchBarState();
}

class _CustomSearchBarState extends State<CustomSearchBar> {
  final FocusNode _focusNode = FocusNode();
  final TextEditingController _controller = TextEditingController();
  bool isActive = false;

  @override
  void dispose() {
    _focusNode.dispose();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SearchBar(
      focusNode: _focusNode,
      controller: _controller,
      hintText: 'Anything in mind?..',
      leading: Icon(Icons.search, color: AppColors.primaryColor),
      backgroundColor: WidgetStatePropertyAll(
        isActive ? Colors.white : Colors.grey.shade200,
      ),
      onTap: () => setState(() => isActive = true),
      onChanged: widget.onChanged, // report change upward
    );
  }
}
