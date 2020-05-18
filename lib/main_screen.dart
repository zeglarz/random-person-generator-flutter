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

String firstName;
String lastName;
String title;
String thumbnail;
bool loading = true;
String dob;
int age;
String phone;
String cell;
String email;
Map street;
String city;
String state;
String country;
String postcode;

class _MainScreenState extends State<MainScreen> {
  @override
  void initState() {
    super.initState();
    fetchData();
  }

  void fetchData() async {
    setState(() => loading = true);
    var data = await network.getData();
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
    setState(() => loading = false);
  }

  var scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: Colors.black87,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            !loading
                ? PhotoAvatar(NetworkImage(thumbnail))
                : PhotoAvatar(AssetImage('images/no-img.png')),
            ContactTile(
              scaffoldKey: scaffoldKey,
              content: '$firstName $lastName',
              icon: Icons.person,
              loading: loading,
            ),
            ContactTile(
              scaffoldKey: scaffoldKey,
              content: '$age yo',
              icon: Icons.book,
              loading: loading,
            ),
            Text(
              'Born: ${DateFormat("dd MMMM yyyy").format(DateTime.parse(dob))}',
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold),
            ),
            Text(
              'Phone: $cell',
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold),
            ),
            Text(
              'email: $email',
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold),
            ),
            Text(
              'street: ${street['number']} ${street['name']}',
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold),
            ),
            Text(
              'postcode: $postcode',
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold),
            ),
            Text(
              'city: $city',
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold),
            ),
            Text(
              'country: $country',
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold),
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
