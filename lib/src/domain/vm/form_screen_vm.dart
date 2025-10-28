import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:storekepper_app/src/app/utilities/image_helper.dart';
import 'package:storekepper_app/src/domain/provider/product_provider.dart';
import 'package:storekepper_app/src/models/product_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:storekepper_app/src/app/constants/color.dart';

final productFormViewModelProvider =
    ChangeNotifierProvider.autoDispose<ProductFormViewModel>((ref) {
      return ProductFormViewModel(ref);
    });

class ProductFormViewModel extends ChangeNotifier {
  ProductFormViewModel(this.ref);

  final Ref ref;

  final formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final quantityController = TextEditingController();
  final priceController = TextEditingController();
  final descriptionController = TextEditingController();

  final picker = ImagePicker();
  String status = 'InStock';
  String imagePath = 'assets/no_image.png';

  bool get isValid => formKey.currentState?.validate() ?? false;

  void init(ProductModel? product, bool isEditing) {
    if (isEditing && product != null) {
      nameController.text = product.name;
      quantityController.text = product.quantity.toString();
      priceController.text = product.price.toString();
      descriptionController.text = product.description;
      status = product.status;
      imagePath = product.imagePath;
    }
  }

  Future<void> pickImage(
    BuildContext context,
    ImageSource source,
    bool isEditing,
  ) async {
    final newPath = await ImageHelper().pickAndSaveImage(source);
    if (newPath != null && newPath.isNotEmpty) {
      if (isEditing && newPath != imagePath) {
        await ImageHelper().deleteImage(imagePath);
      }
      imagePath = newPath;
      notifyListeners();
    }
    if (context.mounted) Navigator.pop(context);
  }

  void removeImage() {
    imagePath = 'assets/no_image.png';
    notifyListeners();
  }

  Future<void> save(
    BuildContext context,
    bool isEditing,
    ProductModel? existing,
  ) async {
    if (!isValid) return;

    final notifier = ref.read(productNotifierProvider.notifier);
    final product = ProductModel(
      id: isEditing ? existing?.id : null,
      name: nameController.text,
      description: descriptionController.text,
      quantity: int.tryParse(quantityController.text) ?? 0,
      price: int.tryParse(priceController.text) ?? 0,
      imagePath: imagePath,
      status: status,
    );

    if (isEditing) {
      await notifier.updateProduct(product);
    } else {
      await notifier.addProduct(product);
    }

    if (context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: AppColors.primaryColor,
          content: Text(
            isEditing
                ? '${product.name} Updated Successfully'
                : '${product.name} Registered Successfully',
          ),
        ),
      );
      context.go('/home');
    }
  }

  @override
  void dispose() {
    nameController.dispose();
    quantityController.dispose();
    priceController.dispose();
    descriptionController.dispose();
    super.dispose();
  }
}
