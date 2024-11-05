import 'package:crave_wave_app/bloc/category/category_bloc.dart';
import 'package:crave_wave_app/bloc/category/category_event.dart';
import 'package:crave_wave_app/typedef/user.dart';
import 'package:crave_wave_app/view/user/category/category.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ExploreBox extends StatelessWidget {
  final String image;
  final String name;
  final UserId userId;
  const ExploreBox({
    super.key,
    required this.image,
    required this.name,
    required this.userId,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        context.read<CategoryBloc>().add(
              CategoryWiseItemEvent(searchWord: name),
            );
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => CategoryView(
                userId: userId, itemcategory: name),
          ),
        );
      },
      child: Container(
        height: 70,
        width: 70,
        margin: const EdgeInsets.symmetric(horizontal: 7.0, vertical: 10),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            color: Colors.grey.shade200,
            boxShadow: const [
              BoxShadow(
                blurRadius: 3,
                color: Colors.black38,
                spreadRadius: 0.5,
              )
            ]),
        child: Center(
            child: Image.asset(
          image,
          width: 35,
          height: 35,
        )),
      ),
    );
  }
}
