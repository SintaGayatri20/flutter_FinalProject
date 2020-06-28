import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sweetfood/viewsAdmin/adminOrders.dart';
import 'package:sweetfood/viewsAdmin/home.dart';
import 'package:sweetfood/viewsAdmin/product.dart';
import 'package:sweetfood/viewsAdmin/profile.dart';

class AdminPage extends StatefulWidget {
  final VoidCallback signOut;
  AdminPage(this.signOut);
  @override
  _AdminPageState createState() => _AdminPageState();
}

class _AdminPageState extends State<AdminPage> {
  signOut() {
    setState(() {
      widget.signOut();
    });
  }

  String username = "", nama = "";
  TabController tabController;

  getPref() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      username = preferences.getString("username");
      nama = preferences.getString("nama");
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getPref();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.purple[200],
      appBar: new AppBar(
        backgroundColor: Colors.purple,
        title: new Text("ADMIN PAGE"),
        centerTitle: true,
      ),
      drawer: new Drawer(
        child: new ListView(
          children: <Widget>[
            //HEADER//
            new UserAccountsDrawerHeader(
              accountName: Text('$nama'),
              accountEmail: Text('$username'),
              currentAccountPicture: GestureDetector(
                child: new CircleAvatar(
                  backgroundColor: Colors.grey,
                  child: Icon(Icons.person, color: Colors.white),
                ),
              ),
              decoration: new BoxDecoration(color: Colors.purple),
            ),
            //BODY//
            InkWell(
              onTap: () {Navigator.push(context,
                      MaterialPageRoute(builder: (context) => new Home()));
              },
              child: ListTile(
                title: Text('Grafic'),
                leading: Icon(
                  Icons.insert_chart,
                  color: Colors.purple,
                ),
              ),
            ),

            InkWell(
              onTap: () {
                Navigator.push(context,
                      MaterialPageRoute(builder: (context) => new Product()));
              },
              child: ListTile(
                title: Text('Product'),
                leading: Icon(
                  Icons.fastfood,
                  color: Colors.purple,
                ),
              ),
            ),
            InkWell(
              onTap: () {
                Navigator.push(context,
                      MaterialPageRoute(builder: (context) => new AdminOrders()));
              },
              child: ListTile(
                title: Text('Orders'),
                leading: Icon(
                  Icons.shopping_basket,
                  color: Colors.purple,
                ),
              ),
            ),
            InkWell(
              onTap: () {
                Navigator.push(context,
                      MaterialPageRoute(builder: (context) => new Profile()));
              },
              child: ListTile(
                title: Text('Profile'),
                leading: Icon(
                  Icons.account_circle,
                  color: Colors.purple,
                ),
              ),
            ),

            Divider(),

            InkWell(
              onTap: () {
                signOut();
              },
              child: ListTile(
                title: Text('Log Out'),
                leading: Icon(
                  Icons.backspace,
                  color: Colors.red,
                ),
              ),
            ),
          ],
        ),
      ),

      body: new Column(
        children: <Widget>[
          new SizedBox(
            height: 20.0,
          ),
          new Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              InkWell(
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => new Home()));
                },
                child: new CircleAvatar(
                  backgroundColor: Colors.purple,
                  maxRadius: 70.0,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      new Icon(Icons.equalizer),
                      new SizedBox(
                        height: 10.0,
                      ),
                      new Text("GRAFIC"),
                    ],
                  ),
                ),
              ),
              InkWell(
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => new Product()));
                },
                child: new CircleAvatar(
                  backgroundColor: Colors.purple,
                  maxRadius: 70.0,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      new Icon(Icons.fastfood),
                      new SizedBox(
                        height: 10.0,
                      ),
                      new Text("PRODUCT"),
                    ],
                  ),
                ),
              ),
            ],
          ),
          new SizedBox(
            height: 20.0,
          ),
          new Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              InkWell(
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => new AdminOrders()));
                },
                child: new CircleAvatar(
                  backgroundColor: Colors.purple,
                  maxRadius: 70.0,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      new Icon(Icons.shopping_basket),
                      new SizedBox(
                        height: 10.0,
                      ),
                      new Text("ORDERS"),
                    ],
                  ),
                ),
              ),
              InkWell(
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => new Profile()));
                },
                child: new CircleAvatar(
                  backgroundColor: Colors.purple,
                  maxRadius: 70.0,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      new Icon(Icons.person),
                      new SizedBox(
                        height: 10.0,
                      ),
                      new Text("PROFILE"),
                    ],
                  ),
                ),
              ),
            ],
          ),
          new SizedBox(
            height: 20.0,
          ),
          new Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              InkWell(
                onTap: () {
                  signOut();
                },
                child: new CircleAvatar(
                  backgroundColor: Colors.purple,
                  maxRadius: 70.0,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      new Icon(Icons.exit_to_app),
                      new SizedBox(
                        height: 10.0,
                      ),
                      new Text("LOG OUT"),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),

    );
  }
}
