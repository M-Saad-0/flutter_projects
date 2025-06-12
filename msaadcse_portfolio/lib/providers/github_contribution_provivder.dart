import 'dart:convert';

import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
class GithubContributionProvivder with ChangeNotifier {
  List<Map<String, dynamic>> _yearData = [];
  int _selectedYear = 2020;

  GithubContributionProvivder(){
    loadYearData();
  }
  List<Map<String, dynamic>> get  yearDate => _yearData;
  int get  selectedYear => _selectedYear;
  loadYearData({int? year})async{
    _selectedYear = year??DateTime.now().year;
    final response = await http.get(Uri.parse("https://github-contributions-api.jogruber.de/v4/M-Saad-0?y=$_selectedYear"));
    if(response.statusCode==200){
      _yearData = (jsonDecode(response.body)['contributions'] as List).map((e)=>e as Map<String, dynamic>).toList();
    }
    notifyListeners();
  }

}