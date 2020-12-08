// Create an SelectMachineOilPrice class that contains the data from http://app.wealthvending.co.th:9011/api/Machine/SelectMachineOilPrice. It includes a factory constructor that creates an Album from JSON.
// Converting JSON by hand is only one option. For more information
// Example [
//            {
//                "MachineId": "5",
//                "MachineName": "WVS004",
//                "OilTypeId": "1",
//                "OilName": "E90",
//                "OilValue": "40",
//                "PricelistDetailId": "1"
//            },
//          ]

class SelectMachineOilPrice {
  String machineName,
      oilName,
      oilValue,
      oilTypeId,
      machineId,
      pricelistDetailId;

  SelectMachineOilPrice(
      {this.machineName,
      this.oilName,
      this.oilValue,
      this.machineId,
      this.oilTypeId,
      this.pricelistDetailId});

  SelectMachineOilPrice.fromJson(Map<String, dynamic> json) {
    machineId = json['MachineId'];
    machineName = json['MachineName'];
    oilTypeId = json['OilTypeId'];
    oilName = json['OilName'];
    oilValue = json['OilValue'];
    pricelistDetailId = json['PricelistDetailId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['MachineId'] = this.machineId;
    data['MachineName'] = this.machineName;
    data['OilTypeId'] = this.oilTypeId;
    data['OilName'] = this.oilName;
    data['OilValue'] = this.oilValue;
    data['PricelistDetailId'] = this.pricelistDetailId;
    return data;
  }
}
