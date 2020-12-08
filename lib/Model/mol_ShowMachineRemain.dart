// Create an ShowMachineRemain class that contains the data from http://app.wealthvending.co.th:9011/api/Machine/ShowMachineRemain. It includes a factory constructor that creates an Album from JSON.
// Converting JSON by hand is only one option. For more information
// Example [
//            {
//                "Id": "1",
//                "Name": "Machine1",
//                "Capacity": "200",
//                "remaining": "200"
//            },
//          ]

class ShowMachineRemain {
  String id, name, remaining;

  ShowMachineRemain({this.id, this.name, this.remaining});

  ShowMachineRemain.fromJson(Map<String, dynamic> json) {
    id = json['Id'];
    name = json['Name'];
    remaining = json['remaining'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Id'] = this.id;
    data['Name'] = this.name;
    data['remaining'] = this.remaining;
    return data;
  }
}
