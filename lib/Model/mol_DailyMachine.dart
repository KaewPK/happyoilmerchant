// Create an ShowDailyMachine class that contains the data from http://app.wealthvending.co.th:9011/api/Logdaily/DailyMachine. It includes a factory constructor that creates an Album from JSON.
// Converting JSON by hand is only one option. For more information
// Example [
//            {
//                "Id": "1",
//                "CreateDate": "2020-08-10 16:10:52",
//                "Value": "25",
//                "MachineId": "2",
//                "MachineName": "WVS001"
//            },
//          ]

class ShowDailyMachine {
  String id, createDate, machineId, machineName;
  int value;

  ShowDailyMachine(
      {this.id, this.createDate, this.value, this.machineId, this.machineName});

  ShowDailyMachine.fromJson(Map<String, dynamic> json) {
    id = json['Id'];
    createDate = json['CreateDate'];
    value = json['Value'];
    machineId = json['MachineId'];
    machineName = json['MachineName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Id'] = this.id;
    data['CreateDate'] = this.createDate;
    data['Value'] = this.value;
    data['MachineId'] = this.machineId;
    data['MachineName'] = this.machineName;
    return data;
  }
}
