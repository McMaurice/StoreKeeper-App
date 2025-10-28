import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:storekepper_app/src/app/constants/color.dart';
import 'package:storekepper_app/src/app/utilities/validators.dart';
import 'package:storekepper_app/src/domain/vm/form_screen_vm.dart';
import 'package:storekepper_app/src/ui/widgets/button.dart';
import 'package:storekepper_app/src/ui/widgets/image_source_selector.dart';

class ProductFormScreen extends ConsumerStatefulWidget {
  const ProductFormScreen({
    super.key,
    required this.isEditing,
    required this.product,
  });

  final bool isEditing;
  final dynamic product;

  @override
  ConsumerState<ProductFormScreen> createState() => _ProductFormScreenState();
}

class _ProductFormScreenState extends ConsumerState<ProductFormScreen> {
  late final ProductFormViewModel vm;

  @override
  void initState() {
    super.initState();
    vm = ref.read(productFormViewModelProvider);
    vm.init(widget.product, widget.isEditing);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.isEditing ? 'Edit Product' : 'Create Product',
          style: TextStyle(fontFamily: GoogleFonts.exo2().fontFamily),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: vm.formKey,
          child: Column(
            children: [
              //---FORMS----
              TextFormField(
                controller: vm.nameController,
                decoration: const InputDecoration(
                  labelText: 'Product Name',
                  border: OutlineInputBorder(),
                ),
                validator: AppValidators.name,
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: vm.quantityController,
                keyboardType: TextInputType.number,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                decoration: const InputDecoration(
                  labelText: 'Quantity',
                  border: OutlineInputBorder(),
                ),
                validator: AppValidators.quantity,
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: vm.priceController,
                keyboardType: TextInputType.number,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Amount',
                  prefixText: '₦',
                ),
                validator: AppValidators.amount,
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: vm.descriptionController,
                maxLines: 3,
                decoration: const InputDecoration(
                  labelText: 'Description',
                  border: OutlineInputBorder(),
                ),
                validator: AppValidators.description,
              ),
              const SizedBox(height: 12),
              AbsorbPointer(
                absorbing: !widget.isEditing,
                child: Stack(
                  alignment: Alignment.centerRight,
                  children: [
                    DropdownButtonFormField<String>(
                      initialValue: vm.status,
                      iconDisabledColor: Colors.grey,
                      iconEnabledColor: AppColors.primaryColor,
                      decoration: InputDecoration(
                        labelText: 'Status',
                        border: const OutlineInputBorder(),
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
                      onChanged: (value) => setState(() => vm.status = value!),
                    ),
                    if (!widget.isEditing)
                      const Padding(
                        padding: EdgeInsets.only(right: 12),
                        child: Icon(Icons.lock, color: Colors.grey, size: 20),
                      ),
                  ],
                ),
              ),
              //---IMAGE SECTOR---
              const SizedBox(height: 24),
              Consumer(
                builder: (context, ref, _) {
                  final imagePath = ref
                      .watch(productFormViewModelProvider)
                      .imagePath;
                  return GestureDetector(
                    onTap: () => ImageSourceSelector.show(
                      context,
                      vm: vm,
                      isEditing: widget.isEditing,
                    ),
                    child: Container(
                      height: 120,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        border: imagePath.startsWith('assets/')
                            ? Border.all(color: Colors.grey.shade400)
                            : null,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      alignment: Alignment.center,
                      child: imagePath.startsWith('assets/')
                          ? Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.add_a_photo,
                                  size: 40,
                                  color: AppColors.primaryColor,
                                ),
                                const SizedBox(height: 8),
                                const Text('Add image'),
                              ],
                            )
                          : Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(12),
                                  child: Image.file(
                                    File(imagePath),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                const SizedBox(width: 20),
                                GestureDetector(
                                  behavior: HitTestBehavior.opaque,
                                  onTap: vm.removeImage,
                                  child: const Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text('Remove Image'),
                                      Icon(Icons.cancel),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                    ),
                  );
                },
              ),
              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                height: 48,
                child: CustomButton(
                  title: widget.isEditing ? 'Update Product' : 'Add Product',
                  color: AppColors.primaryColor,
                  onPressed: () =>
                      vm.save(context, widget.isEditing, widget.product),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
