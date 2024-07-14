import 'dart:typed_data';

class CategoryModel
{
  String? Category;
  Uint8List? image;
  int? id;

  CategoryModel({this.Category, this.image, this.id});

  CategoryModel fromMap(Map map)
  {
    CategoryModel categoryModel = CategoryModel(
      Category: map['categorytypes'],
      image: map['image'],
      id: map['id'],
    );

    return categoryModel;
  }
}