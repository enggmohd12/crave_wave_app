import 'package:crave_wave_app/bloc/cart_menu_count/cart_menu_count_bloc.dart';
import 'package:crave_wave_app/bloc/cart_menu_count/cart_menu_count_event.dart';
import 'package:crave_wave_app/bloc/category/category_bloc.dart';
import 'package:crave_wave_app/bloc/category/category_state.dart';
import 'package:crave_wave_app/components/color.dart';
import 'package:crave_wave_app/typedef/user.dart';
import 'package:crave_wave_app/view/user/category/components/list_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CategoryView extends StatefulWidget {
  final String itemcategory;
  final UserId userId;
  const CategoryView({
    super.key,
    required this.itemcategory,
    required this.userId,
  });

  @override
  State<CategoryView> createState() => _CategoryViewState();
}

class _CategoryViewState extends State<CategoryView> {
  @override
  void initState() {
    context.read<CartMenuBloc>().add(
          LoadCategories(userId: widget.userId),
        );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: backgroundColor,
        centerTitle: true,
        title: const Text(
          'Category Item List',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: BlocBuilder<CategoryBloc, CategoryState>(
        builder: (context, state) {
          if (state is CategoryData) {
            return ListView.builder(
              padding: const EdgeInsets.all(8),
              itemCount: state.menuItem.length,
              itemBuilder: (context, index) {
                final data = state.menuItem.elementAt(index);

                return ListMenuCategory(
                  menuItem: data,
                  userId: widget.userId,
                );
              },
            );
          } else {
            return const Center(
              child: Text(
                'No data found',
              ),
            );
          }
        },
      ),
    );
  }
}
