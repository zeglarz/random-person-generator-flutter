import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:randompersongenerator/services/network.dart';

import 'comonents/contact_tile.dart';
import 'comonents/photo_avatar.dart';
import 'constants.dart';

NetworkHelper network = NetworkHelper(randomAPI);

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

ScrollController _scrollController = ScrollController();

String firstName = '';
String lastName = '';
String title = '';
String thumbnail = '';
bool loading = true;
String dob = '${DateTime.now()}';
int age = 0;
String phone = '';
String cell = '';
String email = '';
Map street = {};
String city = '';
String state = '';
String country = '';
String postcode = '';

class _MainScreenState extends State<MainScreen> {
  @override
  void initState() {
    super.initState();
    fetchData();
  }

  void fetchData() async {
    setState(() => loading = true);
    var data = await network.getData(countryList: [], gender: '');
    var randomPerson = data['results'][0];

    // Name Data
    var nameData = randomPerson['name'];
    firstName = nameData['first'];
    lastName = nameData['last'];
    title = nameData['title'];
    // Images
    var pictures = randomPerson['picture'];
    thumbnail = pictures['large'];

    // DOB
    var dateOfBirth = randomPerson['dob'];
    dob = dateOfBirth['date'];
    age = dateOfBirth['age'];

    // Contact
    phone = randomPerson['phone'];
    cell = randomPerson['cell'];
    email = randomPerson['email'];

    // Location
    var location = randomPerson['location'];
    street = location['street'];
    city = location['city'];
    country = location['country'];
    postcode = location['postcode'].toString();

    print(street);
    print('$title $firstName $lastName');
    print(randomPerson);
    _scrollController.animateTo(
      0.0,
      curve: Curves.easeOut,
      duration: const Duration(milliseconds: 300),
    );
    setState(() => loading = false);
  }

  var scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(190.0), // here the desired height

        child: AppBar(
            backgroundColor: Colors.transparent,
            flexibleSpace: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: <Color>[Colors.lightBlueAccent, Colors.orange],
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  SizedBox(
                    height: 20,
                  ),
                  !loading
                      ? PhotoAvatar(thumbnail, scaffoldKey)
                      : PhotoAvatar(
                          'images/no-img.png',
                          scaffoldKey,
                        ),
                ],
              ),
            )),
      ),
      body: SafeArea(
        child: ListView(
          controller: _scrollController,
          reverse: false,
          children: <Widget>[
            ContactTile(
              scaffoldKey: scaffoldKey,
              content: '$firstName $lastName',
              fontSize: 22,
              icon: Icons.person,
              loading: loading,
            ),
            ContactTile(
              scaffoldKey: scaffoldKey,
              content:
                  ' ${DateFormat("dd MMMM yyyy").format(DateTime.parse(dob))} ($age)',
              icon: Icons.cake,
              loading: loading,
            ),
            ContactTile(
              scaffoldKey: scaffoldKey,
              content: '$cell',
              icon: Icons.phone,
              loading: loading,
            ),
            ContactTile(
              scaffoldKey: scaffoldKey,
              content: '$email',
              icon: Icons.email,
              loading: loading,
              fontSize: 12,
            ),
            ContactTile(
              scaffoldKey: scaffoldKey,
              content: '${street['number']} ${street['name']}',
              icon: Icons.my_location,
              loading: loading,
            ),
            ContactTile(
              scaffoldKey: scaffoldKey,
              content: '$postcode',
              icon: Icons.markunread_mailbox,
              loading: loading,
            ),
            ContactTile(
              scaffoldKey: scaffoldKey,
              content: '$city',
              icon: Icons.location_city,
              loading: loading,
            ),
            ContactTile(
              scaffoldKey: scaffoldKey,
              content: '$country',
              icon: Icons.flag,
              loading: loading,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.refresh),
        onPressed: fetchData,
      ),
    );
  }
}
