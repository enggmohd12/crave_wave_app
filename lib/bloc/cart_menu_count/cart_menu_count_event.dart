abstract class CartMenuCountEvent {}

class LoadCategories extends CartMenuCountEvent {
  final String userId;
  LoadCategories({
    required this.userId,
  });
}

class UpdateItemCount extends CartMenuCountEvent {
  final String itemId;
  final int newCount;
  final String userId;

  UpdateItemCount({
    required this.itemId,
    required this.newCount,
    required this.userId,
  });
}
