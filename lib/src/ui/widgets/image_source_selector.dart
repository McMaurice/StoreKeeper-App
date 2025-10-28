import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:storekepper_app/src/app/constants/color.dart';
import 'package:storekepper_app/src/domain/vm/form_screen_vm.dart';

class ImageSourceSelector extends StatelessWidget {
  final ProductFormViewModel vm;
  final bool isEditing;

  const ImageSourceSelector({
    super.key,
    required this.vm,
    required this.isEditing,
  });

  static Future<void> show(
    BuildContext context, {
    required ProductFormViewModel vm,
    required bool isEditing,
  }) {
    return showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (_) => ImageSourceSelector(vm: vm, isEditing: isEditing),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Wrap(
        children: [
          ListTile(
            leading: Icon(Icons.camera_alt, color: AppColors.primaryColor),
            title: const Text('Take a picture'),
            onTap: () {
              Navigator.pop(context);
              vm.pickImage(context, ImageSource.camera, isEditing);
            },
          ),
          ListTile(
            leading: Icon(Icons.photo_library, color: AppColors.primaryColor),
            title: const Text('Upload from gallery'),
            onTap: () {
              Navigator.pop(context);
              vm.pickImage(context, ImageSource.gallery, isEditing);
            },
          ),
        ],
      ),
    );
  }
}
