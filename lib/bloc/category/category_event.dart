abstract class CategoryEvent {
  const CategoryEvent();
}

class CategoryWiseItemEvent extends CategoryEvent {
  final String searchWord;
  const CategoryWiseItemEvent({
    required this.searchWord,
  });
}
