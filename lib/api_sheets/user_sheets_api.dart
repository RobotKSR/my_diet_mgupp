import 'dart:developer';
import 'package:gsheets/gsheets.dart';
import 'package:yourdiet/model/user.dart';

class UserSheetsAPI {
  static const _credentials = r'''
{
  "type": "service_account",
  "project_id": "yourdietapp",
  "private_key_id": "86acb0e1c674a59efb821ad58d81ce0ed0fbe422",
  "private_key": "-----BEGIN PRIVATE KEY-----\nMIIEvQIBADANBgkqhkiG9w0BAQEFAASCBKcwggSjAgEAAoIBAQDMic0/t/G5uhqf\nFz/veOtHsEMSnKbs/kH6KGy/18XkNk9rHX2GbDlozUAmsMsLP707lVhTCChyL+mW\na5QW0iQYKP5FmgnGwop1f+3ne9SLYdcahL00tGQle42uppZ41QAVb3odj9tZXkh4\nv4IwfF5JERY2zD3lA7oaZEMsFmXW44ojS1wb8lAqzpiA9vCRNBI2cecwFNWaNGGK\nR+Pb8KU/lHQxKGP7pE4JvsdVRHz/S/iseHBhCMjJi7GYoSKxFhI26QtCFxM1gptq\nR2P8JYMwBuwvgrfqesKdcyX5GFPmOqBIjZu5Jl5F1EXECzTHNFuIejCN34JG3u8m\nTKghngKlAgMBAAECggEACggx11yf41dYoIT1AqHdQfh7OBmtQxWvCfE013pinzB3\niyFr9RpJycIhBPf9Skf0cbLmUIXatf8NNFUcDLwYP4PpmzBUjZ/tFDMTtoIN74HI\nMxzF/iSUfnu/SNmsd7C6y4WNz8Is8aBjA/xT1/aOb7cCB+rS/lb4dPyF7uhwuXr8\nOvcnWL8BxywgnPJYQhinTTIzgtgpbm65TA2PnFtFAi/BT8RdscmTKHmryZRUpWP8\nnYybz3WrXz6pQbDUuS6caaEeF1nAlwE/uzMg0mb1rwTGkj4gLFHIwvdipfvTpXnm\n+GbhbFgC2ua3z0NZ53a1+cbvucYsn2OMnCcnym+d4QKBgQD5zqVwlv7ThJduZNoC\n6c0D0DYEP2ZN3S1p3lnkK9bUTwkxSDrhqHs7u8LPGI04WiaT2ooENqInl1qHRJFg\n0C/jhRBML3GhlXNdlsnJl8iTT+EfqlOj7sfdpMARbh1c7wirQSPrPxnXIm3ajfzb\nYlnuzUCG7NwD5ERHmCZ2hxHdDwKBgQDRm91r2IvxY7z6v79+DoukznoDq1Lzx9ib\nEPFGYmVmGpj/6+qGjLAh0JgcKt3kbapEdXMXvXXzP+tsTqu58favP73hshHC3PNO\n7eUirikRS3/0OmSIQaCmaLIflWxfOWW4cfw2RdE1/Y54PfWptBBGduppONGK8Iss\nGkX9veRNCwKBgQDX5QCWjekuZSl6/y5r1iSZZxlIEoMYSE83cDPAPyMr2iLXtNUu\nsa3PsjZrRYzHZyJwJi+h9JWwId7biScbxNGekSHEtjw+qitKd0duMv/mUOL/uvUO\neQ/DPt/AMKqv5uZXG7UvWxm6FMdcW9pswFN5T2q1MX/03RMlzRlw1stZgQKBgAK0\nrmEMBJJzJSdffktUSL0x5SVS+tkmxUcLKvIrpv9wbHUxSG/ANS3akXwbmY2vVLlZ\ngsjVq0Yelx1ozpKx6utMOVlGgTAwxftI2uJduS39+YLflhikMDy1sUbzGNkJ1qRQ\n5F6W/CJkSYiH1DoClwsx0cjV8O6IOGOzWx/xaZcNAoGAI0qrwArr5yoTveuW0pxX\ngTtjpSOk3Nb8Dme8OOnzU6VTiNIc1N9qfdpqQP/AgV4ADjhXKRUMk/QpY+yE2w8P\n9NIBTMqtm4ogFIzNL4PTHF9f69aNMdDXPczs7bP5ctTknSXOP4Tc66v0qNFKi5/P\n+PzrduYTOaUtAPTTA7dts4w=\n-----END PRIVATE KEY-----\n",
  "client_email": "yourdietapp@yourdietapp.iam.gserviceaccount.com",
  "client_id": "107243664872745496617",
  "auth_uri": "https://accounts.google.com/o/oauth2/auth",
  "token_uri": "https://oauth2.googleapis.com/token",
  "auth_provider_x509_cert_url": "https://www.googleapis.com/oauth2/v1/certs",
  "client_x509_cert_url": "https://www.googleapis.com/robot/v1/metadata/x509/yourdietapp%40yourdietapp.iam.gserviceaccount.com"
}
  ''';
  static final _spreadSheetId = '1d61UkwYOLJw2fS_OEI64KAaoDHFEReya6cIUgAf9ZL8';
  static final _gsheets = GSheets(_credentials);
  static Worksheet? _userSheet;

  static Future init() async{
    try {
      final spreadsheet = await _gsheets.spreadsheet(_spreadSheetId);
      _userSheet = await _getWorkSheet(spreadsheet, title: 'Users');

      final firstRow = UserFields.getFields();
      _userSheet!.values.insertRow(1, firstRow);
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
    if(_userSheet == null) return 0;

    final lastRow = await _userSheet!.values.lastRow();
    return lastRow == null ? 0 : int.tryParse(lastRow.first) ?? 0;
  }

  static Future<List<User>> getAll() async{
    if(_userSheet == null) return <User>[];

    final users = await _userSheet!.values.map.allRows();
    return users == null ? <User>[] : users.map(User.fromJson).toList();
  }

  static Future<User?> getById(String id) async {
    if(_userSheet == null) return null;

    final json = await _userSheet!.values.map.rowByKey(id, fromColumn: 1);
    return json == null ? null : User.fromJson(json);
  }

  static Future insert(List<Map<String, dynamic>> rowList) async {
    if(_userSheet == null) return;

    _userSheet!.values.map.appendRows(rowList);
  }

  static Future<bool> update(String id, Map<String, dynamic> user) async {
    if(_userSheet == null) return false;
    
    return _userSheet!.values.map.insertRowByKey(id, user);
  }
}