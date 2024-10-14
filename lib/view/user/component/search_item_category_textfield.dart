import 'package:crave_wave_app/backend/search_menu_item_category_wise.dart';
import 'package:crave_wave_app/components/color.dart';
import 'package:crave_wave_app/model/menu/item_type.dart';
import 'package:crave_wave_app/model/menu/menu_item.dart';
import 'package:crave_wave_app/view/user/component/sliding_textfield.dart';
import 'package:crave_wave_app/view/user/item/item_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';

class SearchTextField extends StatefulWidget {
  final TextEditingController searchFoodController;
  const SearchTextField({
    super.key,
    required this.searchFoodController,
  });

  @override
  State<SearchTextField> createState() => _SearchTextFieldState();
}

class _SearchTextFieldState extends State<SearchTextField> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 20.0,
      ),
      child: TypeAheadField(
        loadingBuilder: (context) {
          return const Center(child: CircularProgressIndicator(
            color: backgroundColor,

          ),);
        },
        itemBuilder: (context, value) {
          return ListTile(
            leading: CircleAvatar(
              radius: 25,
              child: ClipOval(
                child: Image.network(
                  value.fileUrl,
                  width: 50,
                  height: 50,
                  fit: BoxFit.fill,
                ),
              ),
            ),
            title: Text(value.itemName),
            subtitle: Text(
              '\u{20B9}${value.itemPrice.toString()}',
            ),
            trailing: Stack(
              alignment: Alignment.center,
              children: [
                Icon(
                  Icons.crop_square_sharp,
                  color: value.itemType == ItemType.veg
                      ? Colors.green
                      : Colors.red,
                  size: 30,
                ),
                Icon(
                  Icons.circle,
                  color: value.itemType == ItemType.veg
                      ? Colors.green
                      : Colors.red,
                  size: 8,
                ),
              ],
            ),
          );
        },
        onSelected: (value) {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => ItemScreen(menuDetails: value),
            ),
          );
        },
        suggestionsCallback: (search) async {
          final menuItem = await getMenuItemCateforyWise(searchTerm: search);
          List<MenuItem> lst = menuItem.toList();
          return lst;
        },
        builder: (context, controller, focusNode) {
          return SlidingTextField(
            controller: controller,
            focusNode: focusNode,
          );
        },
        errorBuilder: (context, error) {
          return const Text('Error Occured');
        },
        controller: widget.searchFoodController,
      ),
      // child: SlidingTextField(
      //   controller: searchFoodController,
      // ),
      // UserSearchFoodTextField(
      //   controller: searchFoodController,
      //   hintText: 'Search Food',
      // ),
    );
  }
}
