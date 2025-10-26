import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:storekepper_app/app/theme/color.dart';
import 'package:storekepper_app/core/widgets/button.dart';

class ProductFormScreen extends StatefulWidget {
  const ProductFormScreen({
    super.key,
    required this.isEditing,
    required this.product,
  });
  final bool isEditing;
  final Map<String, dynamic>? product;

  @override
  State<ProductFormScreen> createState() => _ProductFormScreenState();
}

class _ProductFormScreenState extends State<ProductFormScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _quantityController = TextEditingController();
  final _amountController = TextEditingController();
  final _descriptionController = TextEditingController();
  String _status = 'InStock';
  final List<File> _images = [];

  final picker = ImagePicker();

  @override
  void initState() {
    super.initState();
    if (widget.isEditing && widget.product != null) {
      _nameController.text = widget.product!['name'] ?? '';
      _quantityController.text = widget.product!['quantity']?.toString() ?? '';
      _amountController.text = widget.product!['amount']?.toString() ?? '';
      _descriptionController.text = widget.product!['description'] ?? '';
      _status = widget.product!['status'] ?? 'Available';
    }
  }

  Future<void> _pickImage(ImageSource source) async {
    final pickedFile = await picker.pickImage(source: source, imageQuality: 80);
    if (pickedFile != null) {
      setState(() => _images.add(File(pickedFile.path)));
    }
    Navigator.pop(context);
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

  void _saveProduct() {
    if (_formKey.currentState!.validate()) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            widget.isEditing
                ? 'Product updated successfully'
                : 'Product created successfully',
          ),
        ),
      );
      Navigator.pop(context);
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
                decoration: const InputDecoration(labelText: 'Product Name'),
                validator: (value) => value == null || value.isEmpty
                    ? 'Enter product name'
                    : null,
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: _quantityController,
                keyboardType: TextInputType.number,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                decoration: const InputDecoration(labelText: 'Quantity'),
                validator: (value) =>
                    value == null || value.isEmpty ? 'Enter quantity' : null,
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: _amountController,
                keyboardType: TextInputType.number,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                decoration: const InputDecoration(
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
                decoration: const InputDecoration(labelText: 'Description'),
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
              DropdownButtonFormField<String>(
                initialValue: _status,
                decoration: const InputDecoration(labelText: 'Status'),
                items: const [
                  DropdownMenuItem(value: 'InStock', child: Text('InStock')),
                  DropdownMenuItem(value: 'Limited', child: Text('Limited')),
                ],
                onChanged: (value) => setState(() => _status = value!),
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
                  child: _images.isEmpty
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
                          child: ListView.separated(
                            scrollDirection: Axis.horizontal,
                            itemCount: _images.length,
                            separatorBuilder: (_, __) =>
                                const SizedBox(width: 8),
                            itemBuilder: (_, index) => ClipRRect(
                              borderRadius: BorderRadius.circular(8),
                              child: Image.file(
                                _images[index],
                                width: 120,
                                height: 120,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ),
                ),
              ),
              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                height: 48,
                child: customButton(
                  widget.isEditing ? 'Update' : 'Create',
                  AppColors.primaryColor,
                  null,
                  _saveProduct,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
