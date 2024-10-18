import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:main_project/MONEY/payment.dart';
import '../main.dart';
class login_model3 {
  // final String order_id;
  final String name;
  // final String bank;
  final String amount;
  // final String account_no;
  final String Phone;
  login_model3({
    // required this.order_id,
    required this.name,
    // required this.bank,
    required this.amount,
    // required this.account_no,
    required this.Phone
  });
}
class admin_view_payments extends StatefulWidget {
  @override
  _admin_view_paymentsState createState() => _admin_view_paymentsState();
}
class _admin_view_paymentsState extends State<admin_view_payments> {
  Future<List<login_model3>> getRequest() async {
    String url = "http://$ip/mainflutterdata/admin/admin_view_payments.php";
    final response = await http.get(Uri.parse(url));
    var responseData = json.decode(response.body);
    print("*********");
    print(responseData);
    List<login_model3> users = [];
    for (var singleUser in responseData) {
      login_model3 user = login_model3(
        // order_id:singleUser ['order_id'].toString(),
        name:singleUser ['name'].toString(),
        // bank:singleUser ['bank'].toString(),
        amount: singleUser["amount"].toString(),
        // account_no: singleUser["account_no"].toString(),
        Phone: singleUser["Phone"].toString(),
      );
      users.add(user);
    }
    return users;
  }
  @override
  // @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text("PAYMENTS", style: TextStyle(fontSize: 30, color: Colors.lightGreenAccent)),
        ),
        body: Container(
          padding: EdgeInsets.all(16.0),
          child: FutureBuilder<List<login_model3>>(
            future: getRequest(),
            builder: (BuildContext ctx, AsyncSnapshot<List<login_model3>> snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return Center(child: Text("Error: ${snapshot.error}"));
              } else {
                // Calculate the total amount here
                double totalAmount = snapshot.data!.fold(0, (sum, item) {
                  return sum + (double.tryParse(item.amount) ?? 0.0);
                });

                return Column(
                  children: [
                    DataTable(
                      columns: const <DataColumn>[
                        DataColumn(label: Text('Name',style: TextStyle(color: Colors.red,fontSize: 18),)),
                        DataColumn(label: Text('Phone',style: TextStyle(color: Colors.red,fontSize: 18),)),
                        DataColumn(label: Text('Amount',style: TextStyle(color: Colors.red,fontSize: 18),)),
                      ],
                      rows: List<DataRow>.from(snapshot.data!.map((data) {
                        return DataRow(
                          cells: <DataCell>[
                            DataCell(Text(data.name)),
                            DataCell(Text(data.Phone)),
                            DataCell(Text(data.amount)),
                          ],
                        );
                      })),
                    ),
                    SizedBox(height: 26),
                    Text(
                      "Total Amount: \₹${totalAmount.toStringAsFixed(2)}",
                      style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold,color: Colors.red),
                    ),
                  ],
                );
              }
            },
          ),
        ),
      ),
    );
  }

}