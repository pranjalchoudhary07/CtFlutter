import 'package:flutter/material.dart';
import 'package:clevertap_plugin/clevertap_plugin.dart';

void main() {
  runApp(const MyApp());
  CleverTapPlugin.initializeInbox();
  CleverTapPlugin.createNotificationChannel(
      "P01", "First Push", "This is my first push channel try", 3, true);
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'CT Flutter',
      theme: ThemeData(
          primarySwatch: Colors.pink,
          visualDensity: VisualDensity.adaptivePlatformDensity,
          scaffoldBackgroundColor: Color(0xffffecff)),
      home: const MyHomePage(title: 'CleverTap Flutter App'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  void onUser() {
    var stuff = ["bags", "shoes"];
    var profile = {
      'Name': 'Captain America',
      'Identity': '100',
      'Email': 'captain@america.com',
      'Phone': '+14155134',
      'props': 'property1',
      'DOB': '07-07-2000',
      'gender': 'Male',
      'stuff': stuff
    };
    var lat = 19.07;
    var long = 72.87;
    CleverTapPlugin.setLocation(lat, long);
    CleverTapPlugin.onUserLogin(profile);
  }

  void event() {
    //CleverTapPlugin.recordEvent("Product Viewed",{});

    var eventData = {
      // Key:    Value
      'first': 'partridge',
      'second': 'turtledoves'
    };
    CleverTapPlugin.recordEvent("Flutter Event", eventData);
  }

  void chargedEvent() {
    var item1 = {
      // Key:    Value
      'name': 'thing1',
      'amount': '100'
    };
    var item2 = {
      // Key:    Value  
      'name': 'thing2',
      'amount': '100'
    };
    var items = [item1, item2];
    var chargeDetails = {
      // Key:    Value
      'total': '200',
      'payment': 'cash'
    };
    CleverTapPlugin.recordChargedEvent(chargeDetails, items);
  }

  void inboxDidInitialize() {
    this.setState(() {
      print("inboxDidInitialize called");
      var styleConfig = {
        'noMessageTextColor': '#ff6600',
        'noMessageText': 'No message(s) to show.',
        'navBarTitle': 'App Inbox'
      };
      CleverTapPlugin.showInbox(styleConfig);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 255, 215, 255),
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            // Text(
            //   "On User Login!",
            //   style: Theme.of(context).textTheme.headlineSmall,
            // ),
            ElevatedButton(
              child: Text(
                "On User Login",
                style: TextStyle(fontSize: 20),
              ),
              onPressed: onUser,
            ),
            ElevatedButton(
              child: Text(
                "Record Event",
                style: TextStyle(fontSize: 20),
              ),
              onPressed: event,
            ),
            ElevatedButton(
              child: Text(
                "Charged Event",
                style: TextStyle(fontSize: 20),
              ),
              onPressed: chargedEvent,
            ),
            ElevatedButton(
              child: Text(
                "App Inbox",
                style: TextStyle(fontSize: 20),
              ),
              onPressed: inboxDidInitialize,
            ),
          ],
        ),
      ),
    );
  }
}
