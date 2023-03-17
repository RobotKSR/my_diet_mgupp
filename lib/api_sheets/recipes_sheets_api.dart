import 'dart:developer';
import 'package:gsheets/gsheets.dart';
import 'package:yourdiet/model/recipe.dart';

class RecipeSheetsAPI {
  static const _credentials = r'''
{
  "type": "service_account",
  "project_id": "yourcredentialshere",
}
  ''';
  static final _spreadSheetId = '1d61UkwYOLJw2fS_OEI64KAaoDHFEReya6cIUgAf9ZL8';
  static final _gsheets = GSheets(_credentials);
  static Worksheet? _recipeSheet;

  static Future init() async{
    try {
      final spreadsheet = await _gsheets.spreadsheet(_spreadSheetId);
      _recipeSheet = await _getWorkSheet(spreadsheet, title: 'Recipes');

      final firstRow = RecipeFields.getFields();
      _recipeSheet!.values.insertRow(1, firstRow);
    }catch (e){
      log('Google Sheets Init Error: $e');
    }
  }

  //This method will create worksheet with given title if it is not existing
  static Future<Worksheet> _getWorkSheet(Spreadsheet spreadsheet, {required String title}) async {
    try {
      return await spreadsheet.addWorksheet(title);
    } catch(e) {
      return spreadsheet.worksheetByTitle(title)!;
    }
  }

  static Future<int> getRowCount() async {
    if(_recipeSheet == null) return 0;

    final lastRow = await _recipeSheet!.values.lastRow();
    return lastRow == null ? 0 : int.tryParse(lastRow.first) ?? 0;
  }

  static Future<List<Recipe>> getAll() async{
    if(_recipeSheet == null) return <Recipe>[];

    final users = await _recipeSheet!.values.map.allRows();
    return users == null ? <Recipe>[] : users.map(Recipe.fromJson).toList();
  }

  static Future<Recipe?> getById(String id) async {
    if(_recipeSheet == null) return null;

    final json = await _recipeSheet!.values.map.rowByKey(id, fromColumn: 1);
    return json == null ? null : Recipe.fromJson(json);
  }

  static Future insert(List<Map<String, dynamic>> rowList) async {
    if(_recipeSheet == null) return;

    _recipeSheet!.values.map.appendRows(rowList);
  }

  static Future<bool> update(String id, Map<String, dynamic> recipe) async {
    if(_recipeSheet == null) return false;

    return _recipeSheet!.values.map.insertRowByKey(id, recipe);
  }
}
