import 'package:flutter/material.dart';
import 'package:randompersongenerator/services/network.dart';

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

class _MainScreenState extends State<MainScreen> {
  @override
  void initState() {
    super.initState();
    fetchData();
  }

  void fetchData() async {
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
    print(street);
    print('$title $firstName $lastName');
    print(randomPerson);
    loading = false;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black87,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            !loading
                ? Center(
                    child: Container(
                      width: 150.0,
                      height: 150.0,
                      padding: EdgeInsets.all(7.0), // borde width
                      decoration: BoxDecoration(
                        color: Color(0xFFFFFFFF), // border color
                        shape: BoxShape.circle,
                      ),
                      child: CircleAvatar(
                          foregroundColor: Colors.white,
                          backgroundColor: Colors.white,
                          radius: 50,
                          backgroundImage: NetworkImage(thumbnail)),
                    ),
                  )
                : Center(
                    child: Container(
                      width: 150.0,
                      height: 150.0,
                      padding: EdgeInsets.all(7.0), // borde width
                      decoration: BoxDecoration(
                        color: Color(0xFFFFFFFF), // border color
                        shape: BoxShape.circle,
                      ),
                      child: CircleAvatar(
                        foregroundColor: Colors.white,
                        backgroundColor: Colors.white,
                        radius: 50,
                        backgroundImage: AssetImage('images/no-img.png'),
                      ),
                    ),
                  ),
            Text(
              '$title $firstName $lastName',
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 30,
                  fontWeight: FontWeight.bold),
            )
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
