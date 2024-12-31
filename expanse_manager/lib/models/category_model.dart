class CategoryModel {
  final String categoryName;
  final String id;

  const CategoryModel({required this.categoryName, required this.id});
  factory CategoryModel.fromJson(Map<String, dynamic> categoryMap){
    return CategoryModel(categoryName: categoryMap['categoryName'], id: categoryMap['id']);
  }
  Map<String, dynamic> toJson(){
    return {
'categoryName':categoryName,
'id':id,};
  }
}

