class FoodListModel {
  List<String> newFoodList = [];
  List<String> foodToAddList = [];
  List<String> foodToRemoveList = [];
  List<String> changedFoodList = [];
  int foodChangeTimeMinute = 0;

  FoodListModel(
      {required this.newFoodList,
      required this.foodToAddList,
      required this.foodToRemoveList,
      required this.foodChangeTimeMinute,
      required this.changedFoodList});
}
