import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:storekepper_app/app/constants/color.dart';
import 'package:storekepper_app/app/utilities/image_helper.dart';
import 'package:storekepper_app/domain/provider/product_provider.dart';
import 'package:storekepper_app/models/product_model.dart';
import 'package:storekepper_app/ui/widgets/button.dart';

class ProductFormScreen extends ConsumerStatefulWidget {
  const ProductFormScreen({
    super.key,
    required this.isEditing,
    required this.product,
  });
  final bool isEditing;
  final ProductModel? product;

  @override
  ConsumerState<ProductFormScreen> createState() => _ProductFormScreenState();
}

class _ProductFormScreenState extends ConsumerState<ProductFormScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _quantityController = TextEditingController();
  final _priceController = TextEditingController();
  final _descriptionController = TextEditingController();
  final picker = ImagePicker();
  String _status = 'InStock';
  String _imagePath = '';

  @override
  void initState() {
    super.initState();

    if (widget.isEditing && widget.product != null) {
      _nameController.text = widget.product!.name;
      _quantityController.text = widget.product!.quantity.toString();
      _priceController.text = widget.product!.price.toString();
      _descriptionController.text = widget.product!.description;
      _status = widget.product!.status;
      _imagePath = widget.product!.imagePath;
    }
  }

  final imageHelper = ImageHelper();

  Future<void> _pickImage(ImageSource source) async {
    final newPath = await imageHelper.pickAndSaveImage(source);

    if (newPath != null && newPath.isNotEmpty) {
      setState(() => _imagePath = newPath);
    } else {
      setState(() => _imagePath = 'assets/no_image.png');
    }

    if (context.mounted) Navigator.pop(context);
  }

  void onSave() async {
    final notifier = ref.read(productNotifierProvider.notifier);
    final product = ProductModel(
      id: widget.isEditing ? widget.product!.id : null,
      name: _nameController.text,
      description: _descriptionController.text,
      quantity: int.tryParse(_quantityController.text) ?? 0,
      price: int.tryParse(_priceController.text) ?? 0,
      imagePath: _imagePath,
      status: _status,
    );

    if (widget.isEditing) {
      await notifier.updateProduct(product);
    } else {
      await notifier.addProduct(product);
    }
    _saveProduct(_nameController.text);
    if (!mounted) return;
    context.go('/home');
  }

  void _showImageSourceSelector() {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (context) {
        return SafeArea(
          child: Wrap(
            children: [
              ListTile(
                leading: Icon(Icons.camera_alt, color: AppColors.primaryColor),
                title: const Text('Take a picture'),
                onTap: () => _pickImage(ImageSource.camera),
              ),
              ListTile(
                leading: Icon(
                  Icons.photo_library,
                  color: AppColors.primaryColor,
                ),
                title: const Text('Upload from gallery'),
                onTap: () => _pickImage(ImageSource.gallery),
              ),
            ],
          ),
        );
      },
    );
  }

  void _saveProduct(String name) {
    if (_formKey.currentState!.validate()) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: AppColors.primaryColor,
          content: Text(
            widget.isEditing
                ? '$name Updated Successfully'
                : '$name Registerd Successfully',
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.isEditing ? 'Edit Product' : 'Create Product'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(
                  labelText: 'Product Name',
                  border: OutlineInputBorder(),
                ),
                validator: (value) => value == null || value.isEmpty
                    ? 'Enter product name'
                    : null,
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: _quantityController,
                keyboardType: TextInputType.number,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                decoration: const InputDecoration(
                  labelText: 'Quantity',
                  border: OutlineInputBorder(),
                ),
                validator: (value) =>
                    value == null || value.isEmpty ? 'Enter quantity' : null,
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: _priceController,
                keyboardType: TextInputType.number,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Amount',
                  prefixText: '₦',
                ),
                validator: (value) =>
                    value == null || value.isEmpty ? 'Enter amount' : null,
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: _descriptionController,
                maxLines: 3,
                decoration: const InputDecoration(
                  labelText: 'Description',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Enter product description';
                  } else if (value.length > 200) {
                    return 'Description cannot exceed 200 characters';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 12),
              AbsorbPointer(
                absorbing: !widget.isEditing,
                child: Stack(
                  alignment: Alignment.centerRight,
                  children: [
                    DropdownButtonFormField<String>(
                      initialValue: _status,
                      iconDisabledColor: Colors.grey,
                      iconEnabledColor: AppColors.primaryColor,
                      decoration: InputDecoration(
                        labelText: 'Status',
                        border: const OutlineInputBorder(),
                        // Optional: subtle gray fill when locked
                        fillColor: widget.isEditing
                            ? Colors.grey.shade100
                            : null,
                        filled: widget.isEditing,
                      ),
                      items: const [
                        DropdownMenuItem(
                          value: 'InStock',
                          child: Text('InStock'),
                        ),
                        DropdownMenuItem(
                          value: 'Limited',
                          child: Text('Limited'),
                        ),
                      ],
                      onChanged: (value) => setState(() => _status = value!),
                    ),
                    if (!widget.isEditing)
                      const Padding(
                        padding: EdgeInsets.only(right: 12),
                        child: Icon(Icons.lock, color: Colors.grey, size: 20),
                      ),
                  ],
                ),
              ),

              const SizedBox(height: 24),
              GestureDetector(
                onTap: _showImageSourceSelector,
                child: Container(
                  height: 120,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey.shade400),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  alignment: Alignment.center,
                  child: _imagePath.isEmpty
                      ? Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.add_a_photo,
                              size: 40,
                              color: AppColors.primaryColor,
                            ),
                            SizedBox(height: 8),
                            Text('Add pictures'),
                          ],
                        )
                      : SizedBox(
                          height: 120,
                          width: 120,
                          child: _imagePath.startsWith('assets/')
                              ? Image.asset(_imagePath, fit: BoxFit.cover)
                              : Image.file(
                                  File(_imagePath),
                                  fit: BoxFit.cover,
                                  errorBuilder: (context, error, stackTrace) =>
                                      Image.asset(
                                        'assets/no_image.png',
                                        fit: BoxFit.cover,
                                      ),
                                ),
                        ),
                ),
              ),

              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                height: 48,
                child: CustomButton(
                  title: widget.isEditing ? 'Update' : 'Create',
                  color: AppColors.primaryColor,
                  onPressed: () => onSave(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
