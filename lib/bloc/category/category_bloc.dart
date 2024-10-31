import 'package:crave_wave_app/backend/search_menu_item_category_wise.dart';
import 'package:crave_wave_app/bloc/category/category_event.dart';
import 'package:crave_wave_app/bloc/category/category_state.dart';
import 'package:crave_wave_app/model/menu/menu_item.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CategoryBloc extends Bloc<CategoryEvent, CategoryState> {
  CategoryBloc() : super(const CategoryInitialize(isLoading: false)) {
    on<CategoryWiseItemEvent>(
      (event, emit) async {
        emit(const CategoryNoData(
          isLoading: true,
        ));
        try {
          final menuItem = await getMenuItemCateforyWise(
            searchTerm: event.searchWord,
          );
          List<MenuItem> lst = menuItem.toList();
          if (lst.isNotEmpty) {
            emit(
              CategoryData(
                menuItem: lst,
                isLoading: false,
              ),
            );
          } else {
            emit(
              const CategoryNoData(
                isLoading: false,
              ),
            );
          }
        } catch (e) {
          emit(
            CategoryError(
              isLoading: false,
              error: e.toString(),
            ),
          );
        }
      },
    );
  }
}
