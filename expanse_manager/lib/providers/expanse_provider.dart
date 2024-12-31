import 'dart:convert';

import 'package:expanse_manager/models/category_model.dart';
import 'package:expanse_manager/models/expense_model.dart';
import 'package:expanse_manager/models/tag_model.dart';
import 'package:flutter/material.dart';
import 'package:localstorage/localstorage.dart';

class ExpenseProvider with ChangeNotifier {
  List<ExpenseModel> _expenses = [];
  List<TagModel> _tags = [];
  List<CategoryModel> _categories = [];

  List<ExpenseModel> get expenses => _expenses;
  List<TagModel> get tags => _tags;
  List<CategoryModel> get categories => _categories;
  ExpenseProvider() {
    _loadExpensesFromStorage();
  }

  void _loadExpensesFromStorage() async {
    var storedExpenses = localStorage.getItem('expenses');
    var storedCategories = localStorage.getItem('categories');
    var storedTags = localStorage.getItem('tags');
    if (storedExpenses != null) {
      _expenses = List<ExpenseModel>.from(storedExpenses
          .split("|||||")
          .map((e) => ExpenseModel.fromJson(jsonDecode(e)))
          .toList());
    }
    if (storedTags != null) {
      print(storedTags);      _tags = List<TagModel>.from(storedTags
          .split("|||||")
          .map((e) => TagModel.fromJson(jsonDecode(e)))).toList();
    }
    if (storedCategories != null) {
      _categories = List<CategoryModel>.from(storedCategories
          .split("|||||")
          .map((e) => CategoryModel.fromJson(jsonDecode(e)))).toList();
    }
    notifyListeners();
  }

  void _saveExpenses() async {
    localStorage.setItem('expenses',
        _expenses.map((e) => jsonEncode(e.toJson())).toList().join("|||||"));
  }

  void _saveCategories() async {
    localStorage.setItem('categories',
        _categories.map((e) => jsonEncode(e.toJson())).toList().join("|||||"));
  }

  void _saveTags() async {
    localStorage.setItem('tags',
        _tags.map((e) => jsonEncode(e.toJson())).toList().join("|||||"));
  }

  void addExpense(ExpenseModel expense) async {
    _expenses.add(expense);
    _saveExpenses();
    notifyListeners();
  }

  void addCategories(CategoryModel category) async {
    _categories.add(category);
    _saveCategories();
    notifyListeners();
  }

  void addTags(TagModel tag) async {
    _tags.add(tag);
    _saveTags();
    notifyListeners();
  }

  void addOrUpdateExpenses(ExpenseModel expense) {
    int index = _expenses.indexWhere((e) => e.id == expense.id);
    if (index != -1) {
      _expenses[index] = expense;
    } else {
      _expenses.add(expense);
    }
    _saveExpenses();
    notifyListeners();
  }

  void removeExpanse(ExpenseModel expenseModel) {
    _expenses.removeWhere((e) => e.id == expenseModel.id);
    _saveExpenses();
    notifyListeners();
  }
  
  
  void addOrUpdateCatefory(CategoryModel category) {
    int index = _categories.indexWhere((e) => e.id == category.id);
    if (index != -1) {
      _categories[index] = category;
    } else {
      _categories.add(category);
    }
    _saveCategories();
    notifyListeners();
  }

  void removeCategory(CategoryModel category) {
    _categories.removeWhere((e) => e.id == category.id);
    _saveCategories();
    notifyListeners();
  }

  
  void addOrUpdateTag(TagModel tag) {
    int index = _expenses.indexWhere((e) => e.id ==tag.id);
    if (index != -1) {
      _tags[index] =tag;
    } else {
      _tags.add(tag);
    }
    _saveTags();
    notifyListeners();
  }

  void removeTag(TagModel tagModel) {
    _expenses.removeWhere((e) => e.id ==tagModel.id);
    _saveTags();
    notifyListeners();
  }
}
