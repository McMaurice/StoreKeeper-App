import 'package:flutter/material.dart';
import 'package:storekepper_app/app/theme/color.dart';

class CustomSearchBar extends StatefulWidget {
  const CustomSearchBar({super.key, value});

  @override
  State<CustomSearchBar> createState() => _CustomSearchBarState();
}

class _CustomSearchBarState extends State<CustomSearchBar> {
  final FocusNode _focusNode = FocusNode();
  final TextEditingController _controller = TextEditingController();
  bool isActive = false;

  // Listen for focus changes
  @override
  void initState() {
    super.initState();
    _focusNode.addListener(() {
      setState(() {
        isActive = _focusNode.hasFocus;
      });
    });
  }

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
      hintText: 'Anything in mind ?..',
      leading: Icon(Icons.barcode_reader, color: AppColors.primaryColor),
      backgroundColor: WidgetStatePropertyAll(
        isActive ? Colors.white : Colors.grey.shade200,
      ),
      onTap: () {
        setState(() {
          isActive = true;
        });
      },
      onChanged: (value) {
        //TODO: Handle search query change
      },
    );
  }
}
