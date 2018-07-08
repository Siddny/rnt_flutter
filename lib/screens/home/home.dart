import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('Home'),
      ),
      body: new Center(
        child: new GridView.count(
          primary: false,
          padding: const EdgeInsets.all(20.0),
          crossAxisSpacing: 10.0,
          crossAxisCount: 2,
          children: <Widget>[
            new Card(
              child: new RaisedButton(
                color: Colors.white,
                child: new Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    const Icon(
                      Icons.supervisor_account,
                      size: 100.0,
                      color: Colors.grey,
                    ),
                    new Container(height: 10.0),
                    const Text('Tenants'),
                  ],
                ),
                onPressed: () {
                  Navigator.pushNamed(context, '/tenants');
                },
              ),
            ),
            new Card(
              child: new RaisedButton(
                color: Colors.white,
                child: new Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    const Icon(
                      Icons.home,
                      size: 100.0,
                      color: Colors.grey,
                    ),
                    new Container(height: 10.0),
                    const Text('Houses'),
                  ],
                ),
                onPressed: () {
                  Navigator.pushNamed(context, '/houses');
                },
              ),
            ),
            new Card(
              child: new RaisedButton(
                color: Colors.white,
                child: new Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    const Icon(
                      Icons.payment,
                      size: 100.0,
                      color: Colors.grey,
                    ),
                    new Container(height: 10.0),
                    const Text('Payments'),
                  ],
                ),
                onPressed: () {
                  Navigator.pushNamed(context, '/payments');
                },
              ),
            ),
            new Card(
              child: new Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  const Icon(
                    Icons.report,
                    size: 100.0,
                    color: Colors.grey,
                  ),
                  new Container(height: 10.0),
                  const Text('Reports'),
                ],
              ),
            ),
            new Card(
              child: new RaisedButton(
                color: Colors.white,
                child: new Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    const Icon(
                      Icons.home,
                      size: 100.0,
                      color: Colors.grey,
                    ),
                    new Container(height: 10.0),
                    const Text('Buildings'),
                  ],
                ),
                onPressed: () {
                  Navigator.pushNamed(context, '/buildings');
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
