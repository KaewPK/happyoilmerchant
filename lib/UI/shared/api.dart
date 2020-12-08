import 'package:happyoilmerchant/Model/mol_DailyMachine.dart';
import 'package:happyoilmerchant/Model/mol_Machine.dart';
import 'package:happyoilmerchant/Model/mol_SelectMachineOilPrice.dart';
import 'package:happyoilmerchant/Model/mol_ShowMachine.dart';
import 'package:happyoilmerchant/Model/mol_ShowMachineRemain.dart';
import 'package:happyoilmerchant/UI/const.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

// Class Api Get and Post data to Appication
class Api {
  static String _senddate;
  static DateFormat dateFormat = DateFormat("yyyy-MM-dd"); // Format date
  static String urlServer = "http://app.wealthvending.co.th:9011"; // url server

  // Api Get Sum AmountNet
  static apiSumValue() async {
    var url = urlServer + '/api/AccountInvoice/SumAmountNet';
    var response = await http.get(url);
    if (response.statusCode == 200) {
      var jsonResponse = convert.jsonDecode(response.body);
      var totalBalance = jsonResponse[0]['SumValue'];
      if (totalBalance != Const.sumValue) {
        Const.sumValue = totalBalance;
      }
    } else {
      print('SumValue Request failed : ${response.statusCode}.');
    }
  }

  // Api Get Name Machine
  static Future<List<ShowMachine>> apiShowMachine() async {
    var url = urlServer + '/api/Machine/ShowMachine';
    var response = await http.get(url);
    if (response.statusCode == 200) {
      var jsonResponse = convert.jsonDecode(response.body);
      Const.showMachine.clear();
      for (var jsonResponse in jsonResponse) {
        Const.showMachine.add(ShowMachine.fromJson(jsonResponse));
      }
      //print("in for : ${Const.showMachine.length}");
    } else {
      print('ShowMachine Request failed : ${response.statusCode}.');
    }
  }

  // Api Get Status Machine
  static Future<List<LocationMachine>> apiLocationMachine() async {
    var url = urlServer + '/api/Machine/LocationMachine';
    var response = await http.get(url);
    if (response.statusCode == 200) {
      var jsonResponse = convert.jsonDecode(response.body);
      Const.locationMachine.clear();
      for (var jsonResponse in jsonResponse) {
        Const.locationMachine.add(LocationMachine.fromJson(jsonResponse));
      }
      //print("in for : ${Const.locationMachine.length}");
    } else {
      print('LocationMachine Request failed : ${response.statusCode}.');
    }
  }

  // Api Get Check Sale of Machine
  static Future<List<ShowMachineRemain>> apiShowMachineRemain() async {
    var url = urlServer + '/api/Machine/ShowMachineRemain';
    var response = await http.get(url);
    if (response.statusCode == 200) {
      var jsonResponse = convert.jsonDecode(response.body);
      Const.showMachineRemain.clear();
      //ßprint(jsonResponse);
      for (var jsonResponse in jsonResponse) {
        Const.showMachineRemain.add(ShowMachineRemain.fromJson(jsonResponse));
      }
      //print("in for : ${Const.showMachineRemain.length}");
    } else {
      print('ShowMachineRemain Request failed : ${response.statusCode}.');
    }
  }

  // Api Post Check Sale on Date
  static Future<List<ShowDailyMachine>> apiShowDailyMachine() async {
    _senddate = dateFormat.format(DateTime.now());
    var url = urlServer + '/api/Logdaily/DailyMachine';
    var response = await http.post(url, body: {'date': _senddate});
    if (response.statusCode == 200) {
      var jsonResponse = convert.jsonDecode(response.body);
      Const.showDailyMachine.clear();
      for (var jsonResponse in jsonResponse) {
        Const.showDailyMachine.add(ShowDailyMachine.fromJson(jsonResponse));
      }
      //print("in for : ${Const.showDailyMachine.length}");
    } else {
      print('ShowDailyMachine Request failed : ${response.statusCode}.');
    }
  }

  // Api Get Machine on Detail
  static Future<List<SelectMachineOilPrice>> apiSelectMachineOilPrice() async {
    var url = urlServer + '/api/Machine/SelectMachineOilPrice';
    var response = await http.get(url);
    if (response.statusCode == 200) {
      var jsonResponse = convert.jsonDecode(response.body);
      Const.selectMachineOilPrice.clear();
      for (var jsonResponse in jsonResponse) {
        Const.selectMachineOilPrice
            .add(SelectMachineOilPrice.fromJson(jsonResponse));
      }
      //print("in for : ${Const.selectMachineOilPrice.length}");
    } else {
      print('SelectMachineOilPrice Request failed : ${response.statusCode}.');
    }
  }

  // Api Post Notification Stock
  static apiNotiStock(String token) async {
    var url = urlServer + '/api/Notification/NotiStock';
    var response = await http.post(url, body: {'token': token});
    if (response.statusCode == 200) {
      var jsonResponse = convert.jsonDecode(response.body);
      print(jsonResponse);
    } else {
      print('NotiStock Request failed : ${response.statusCode}.');
    }
  }

  // Api Post Notification Balance
  static apiNotiBalance(String token) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var stationId = prefs.getString('StationId');
    Map data = {'token': token, 'stationid': stationId};
    //print(data);
    var url = urlServer + '/api/Notification/NotiBalance';
    var response = await http.post(url, body: data);
    if (response.statusCode == 200) {
      var jsonResponse = convert.jsonDecode(response.body);
      print(jsonResponse);
    } else {
      print('NotiBalance Request failed : ${response.statusCode}.');
    }
  }

  // Api Post Notification OilOrderComplete
  static apiNotiOilOrderComplete(String token) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var stationId = prefs.getString('StationId');
    Map data = {'token': token, 'stationid': stationId};
    //print(data);
    var url = urlServer + '/api/Notification/NotiOilOrderComplete';
    var response = await http.post(url, body: data);
    if (response.statusCode == 200) {
      var jsonResponse = convert.jsonDecode(response.body);
      print(jsonResponse);
    } else {
      print('NotiOilOrderComplete Request failed : ${response.statusCode}.');
    }
  }
}
