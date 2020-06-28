import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:sweetfood/modal/api.dart';
import 'package:sweetfood/modal/ordersModel.dart';
import 'package:http/http.dart' as http;

class AdminOrders extends StatefulWidget {
  @override
  _AdminOrdersState createState() => _AdminOrdersState();
}

class _AdminOrdersState extends State<AdminOrders> {
  var loading = false;
  final list = new List<OrdersModel>();
  final GlobalKey<RefreshIndicatorState> _refresh =
      GlobalKey<RefreshIndicatorState>();

  Future<void> _lihatData() async {
    list.clear();
    setState(() {
      loading = true;
    });
    final response = await http.get(BaseUrl.lihatOrders);
    if (response.contentLength == 2) {
    } else {
      final data = jsonDecode(response.body);
      data.forEach((api) {
        final ab = new OrdersModel(
            api['id'],
            api['namaBarang'],
            api['jumlahPesanan'],
            api['createdDate'],
            api['alamat'],
            api['phoneNo'],
            api['reqOrder'],
            api['nama']);
        list.add(ab);
      });
      setState(() {
        loading = false;
      });
    }
  }

  dialogDelete(String id) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            content: ListView(
              shrinkWrap: true,
              children: <Widget>[
                Text("Are you sure to delete this product?"),
                SizedBox(
                  height: 10.0,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                     new RaisedButton(
                      color: Colors.green[300],
                      onPressed: (){
                        Navigator.pop(context);
                      },
                      child: Text("No")
                    ),
                    SizedBox(
                      width: 16.0,
                    ),
                    new RaisedButton(
                      color: Colors.red[400],
                      onPressed: (){
                        _delete(id);
                      },
                      child: Text("Yas")
                    ),
                  ],
                ),
              ],
            ),
          );
        });
  }

  _delete(String id) async {
    final response =
        await http.post(BaseUrl.deleteOrders, body: {"idOrders": id});

    final data = jsonDecode(response.body);
    int value = data['value'];
    String pesan = data['message'];

    if (value == 1) {
      Navigator.pop(context);
      setState(() {
        _lihatData();
      });
    } else {
      print(pesan);
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _lihatData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        elevation: 0.1,
        backgroundColor: Colors.purple,
        title: Text('ORDERS'),
        actions: <Widget>[
          new IconButton(
              icon: Icon(Icons.search, color: Colors.white), onPressed: () {})
        ],
      ),
      body: RefreshIndicator(
        onRefresh: _lihatData,
        key: _refresh,
        child: loading
            ? Center(child: CircularProgressIndicator())
            : ListView.builder(
                itemCount: list.length,
                itemBuilder: (context, i) {
                  final x = list[i];
                  return Container(
                    padding: EdgeInsets.all(10.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Expanded(
                          child: Card(
                            color: Colors.pink[200],
                            elevation: 10.0,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  "Orders : " + x.namaBarang,
                                  style: TextStyle(
                                      fontSize: 18.0,
                                      fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  "Much Orders :" + x.jumlahPesanan,
                                  style: TextStyle(
                                      fontSize: 15.0,
                                      fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  "Date : " + x.createdDate,
                                  style: TextStyle(
                                      fontSize: 15.0,
                                      fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  "Address : " + x.alamat,
                                  style: TextStyle(
                                      fontSize: 15.0,
                                      fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  "Phone Nomor : " + x.phoneNo,
                                  style: TextStyle(
                                      fontSize: 15.0,
                                      fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  "Order Name : " + x.nama,
                                  style: TextStyle(
                                      fontSize: 15.0,
                                      fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  "Request Order :" + x.reqOrder,
                                  style: TextStyle(
                                      fontSize: 15.0,
                                      fontWeight: FontWeight.bold),
                                ),
                                IconButton(
                                  icon: Icon(Icons.delete),
                                  onPressed: () {
                                    dialogDelete(x.id);
                                  },
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
      ),
    );
  }
}
