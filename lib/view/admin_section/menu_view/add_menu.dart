import 'package:crave_wave_app/components/color.dart';
import 'package:crave_wave_app/typedef/user.dart';
import 'package:crave_wave_app/view/admin_section/menu_view/components/radio_button.dart';
import 'package:crave_wave_app/view/admin_section/menu_view/components/textfield.dart';
import 'package:crave_wave_app/view/admin_section/menu_view/constants/item_type_list.dart';
import 'package:flutter/material.dart';

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
            Container(
              height: height * 0.2,
              width: MediaQuery.of(context).size.width,
              //
              margin: const EdgeInsets.symmetric(horizontal: 12),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: Colors.grey.shade200),
              child: const Icon(
                Icons.image,
                size: 90,
                color: Colors.white,
              ),
            ),
            SizedBox(
              height: height * 0.03,
            ),
            const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                 VegNonVegOption(),
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
                onPressed: () {},
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
}
