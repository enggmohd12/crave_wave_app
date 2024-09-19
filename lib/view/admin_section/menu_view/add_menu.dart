import 'dart:io';

import 'package:crave_wave_app/bloc/menu/menu_bloc.dart';
import 'package:crave_wave_app/bloc/menu/menu_event.dart';
import 'package:crave_wave_app/components/color.dart';
import 'package:crave_wave_app/components/dialogs/registring_dialog.dart';
import 'package:crave_wave_app/components/helper/permission_handler.dart';
import 'package:crave_wave_app/model/menu/item_type.dart';
import 'package:crave_wave_app/typedef/user.dart';
import 'package:crave_wave_app/view/admin_section/menu_view/components/radio_button.dart';
import 'package:crave_wave_app/view/admin_section/menu_view/components/textfield.dart';
import 'package:crave_wave_app/view/admin_section/menu_view/constants/item_type_list.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddMenuView extends StatefulWidget {
  final UserId userId;
  const AddMenuView({
    super.key,
    required this.userId,
  });

  @override
  State<AddMenuView> createState() => _AddMenuViewState();
}

class _AddMenuViewState extends State<AddMenuView> {
  bool isVeg = true;
  File? file;
  final itemNameController = TextEditingController();
  final priceController = TextEditingController();
  final descriptionController = TextEditingController();
  String dropdownvalue = 'Choose Item Category';
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Items'),
        backgroundColor: backgroundColor,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: height * 0.03,
            ),
            GestureDetector(
              onTap: () async {
                final a = await getPermission(context);
                if (a != null) {
                  setState(() {
                    file = a;
                  });
                }
              },
              child: Container(
                height: height * 0.2,
                width: MediaQuery.of(context).size.width,
                //
                margin: const EdgeInsets.symmetric(horizontal: 12),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: Colors.grey.shade200),
                child: file != null
                    ? Image.file(file!)
                    : const Icon(
                        Icons.image,
                        size: 90,
                        color: Colors.white,
                      ),
              ),
            ),
            SizedBox(
              height: height * 0.03,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                VegNonVegOption(
                  isVeg: isVeg,
                  onNonVegPressed: () {
                    setState(() {
                      isVeg = !isVeg;
                    });
                  },
                  onVegPressed: () {
                    setState(() {
                      isVeg = !isVeg;
                    });
                  },
                ),
              ],
            ),
            SizedBox(
              height: height * 0.03,
            ),
            TextFieldAddMenu(
              controller: itemNameController,
              hintext: 'Item name (required)',
              type: TextInputType.name,
            ),
            SizedBox(
              height: height * 0.02,
            ),
            Row(
              children: [
                Expanded(
                  child: Container(
                    margin: const EdgeInsets.symmetric(horizontal: 15),
                    color: Colors.grey
                        .shade200, // Set the background color of the dropdown to grey
                    padding:
                        const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                    child: DropdownButton(
                      // Initial Value
                      value: dropdownvalue,
                      isExpanded: true,
                      // Down Arrow Icon
                      icon: const Icon(Icons.keyboard_arrow_down),

                      // Array list of items
                      items: items.map((String items) {
                        return DropdownMenuItem(
                          value: items,
                          child: Text(items),
                        );
                      }).toList(),
                      // After selecting the desired option, it will
                      // change the button value to the selected value
                      onChanged: (String? newValue) {
                        setState(() {
                          dropdownvalue = newValue!;
                        });
                      },
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: height * 0.02,
            ),
            TextFieldAddMenu(
              controller: priceController,
              hintext: 'Item price',
              type: TextInputType.number,
            ),
            SizedBox(
              height: height * 0.02,
            ),
            TextFieldAddMenu(
              controller: descriptionController,
              hintext: 'Item description',
              type: TextInputType.name,
            ),
            SizedBox(
              height: height * 0.02,
            ),
            Container(
              //margin: const EdgeInsets.symmetric(horizontal: 15),
              height: 55,
              width: MediaQuery.of(context).size.width,
              margin: const EdgeInsets.symmetric(horizontal: 12),
              decoration: const BoxDecoration(
                color: backgroundColor,
                borderRadius: BorderRadius.all(
                  Radius.circular(
                    12,
                  ),
                ),
              ),
              child: TextButton(
                onPressed: () {
                  final validate = validation();
                  final mapData = validate.$2;
                  if (validate.$1) {
                    int price = int.parse(priceController.text);
                    context.read<MenuBloc>().add(AddMenuItemEvent(
                          file: file!,
                          userId: widget.userId,
                          itemType: isVeg ? ItemType.veg : ItemType.nonveg,
                          itemDescription: descriptionController.text,
                          itemPrice: price,
                          itemName: itemNameController.text,
                          itemCategory: dropdownvalue,
                        ));
                  } else {
                    final title = mapData['title'];
                    final message = mapData['message'];
                    showRegistrationDialog(
                      context,
                      title,
                      message,
                    );
                  }
                },
                child: const Text(
                  'Add Item',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  (bool, Map<String, dynamic>) validation() {
    (bool, Map<String, dynamic>) returnvalue = (true, {});

    if (itemNameController.text == '') {
      return returnvalue = (
        false,
        {'title': 'Validation Error', 'message': 'Item name required'}
      );
    }

    if (dropdownvalue == 'Choose Item Category') {
      return returnvalue = (
        false,
        {
          'title': 'Validation Error',
          'message': 'Item category is required',
        }
      );
    }

    if (priceController.text == '') {
      return returnvalue = (
        false,
        {'title': 'Validation Error', 'message': 'Item price required'}
      );
    }

    if (descriptionController.text == '') {
      return returnvalue = (
        false,
        {
          'title': 'Validation Error',
          'message': 'Item description is required',
        }
      );
    }

    if (file == null) {
      return returnvalue = (
        false,
        {
          'title': 'Validation Error',
          'message': 'Item image is required',
        }
      );
    }

    return returnvalue;
  }
}
