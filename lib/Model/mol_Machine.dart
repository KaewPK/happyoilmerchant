// Create an LocationMachine class that contains the data from http://app.wealthvending.co.th:9011/api/Machine/LocationMachine. It includes a factory constructor that creates an Album from JSON.
// Converting JSON by hand is only one option. For more information
// Example [
//            {
//                "Id": "1",
//                "MachineName": "Machine1",
//                "Status": "Disable",
//                "LocationName": "wealth",
//                "StatusThai": "ขัดข้อง"
//            },
//          ]

class LocationMachine {
  String id, name, status, statusThai, locationName;

  LocationMachine(
      {this.id, this.name, this.status, this.statusThai, this.locationName});

  LocationMachine.fromJson(Map<String, dynamic> json) {
    id = json['Id'];
    name = json['MachineName'];
    locationName = json['LocationName'];
    status = json['Status'];
    statusThai = json['StatusThai'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Id'] = this.id;
    data['MachineName'] = this.name;
    data['LocationName'] = this.locationName;
    data['Status'] = this.status;
    data['StatusThai'] = this.statusThai;
    return data;
  }
}
