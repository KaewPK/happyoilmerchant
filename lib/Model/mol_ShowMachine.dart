// Create an ShowMachine class that contains the data from http://app.wealthvending.co.th:9011/api/Machine/ShowMachine. It includes a factory constructor that creates an Album from JSON.
// Converting JSON by hand is only one option. For more information
// Example [
//            {
//                "Id": "1",
//                "Name": "Machine1"
//            },
//          ]

class ShowMachine {
  String id, name;

  ShowMachine({this.id, this.name});

  ShowMachine.fromJson(Map<String, dynamic> json) {
    id = json['Id'];
    name = json['Name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Id'] = this.id;
    data['Name'] = this.name;
    return data;
  }
}
