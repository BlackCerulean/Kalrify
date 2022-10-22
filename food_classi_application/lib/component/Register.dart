import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:food_classi_application/component/Login.dart';
import 'package:food_classi_application/decoration/loginUtillities.dart';
import 'package:food_classi_application/homescreen.dart';

class RegisScreen extends StatefulWidget {
  @override
  _RegisScreenState createState() => _RegisScreenState();
}

class _RegisScreenState extends State<RegisScreen> {
  Widget _buildUserTF() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'Username',
          style: kLabelStyle,
        ),
        SizedBox(height: 10.0),
        Container(
          alignment: Alignment.centerLeft,
          decoration: kBoxDecorationStyle,
          height: 60.0,
          child: TextField(
            keyboardType: TextInputType.name,
            style: TextStyle(
              color: Colors.black,
              fontFamily: 'OpenSans',
            ),
            decoration: InputDecoration(
              border: InputBorder.none,
              contentPadding: EdgeInsets.only(top: 14.0),
              prefixIcon: Icon(
                Icons.person,
                color: Color.fromRGBO(255, 120, 90,1),
              ),
              hintText: 'Enter your Username',
              hintStyle: kHintTextStyle,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildEmailTF() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'Email Address',
          style: kLabelStyle,
        ),
        SizedBox(height: 10.0),
        Container(
          alignment: Alignment.centerLeft,
          decoration: kBoxDecorationStyle,
          height: 60.0,
          child: TextField(
            keyboardType: TextInputType.emailAddress,
            style: TextStyle(
              color: Colors.black,
              fontFamily: 'OpenSans',
            ),
            decoration: InputDecoration(
              border: InputBorder.none,
              contentPadding: EdgeInsets.only(top: 14.0),
              prefixIcon: Icon(
                Icons.email,
                color: Color.fromRGBO(255, 120, 90,1),
              ),
              hintText: 'Enter your Email Address',
              hintStyle: kHintTextStyle,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildPasswordTF() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'Password',
          style: kLabelStyle,
        ),
        SizedBox(height: 10.0),
        Container(
          alignment: Alignment.centerLeft,
          decoration: kBoxDecorationStyle,
          height: 60.0,
          child: TextField(
            obscureText: true,
            style: TextStyle(
              color: Colors.black,
              fontFamily: 'OpenSans',
            ),
            decoration: InputDecoration(
              border: InputBorder.none,
              contentPadding: EdgeInsets.only(top: 14.0),
              prefixIcon: Icon(
                Icons.lock,
                color: Color.fromRGBO(255, 120, 90,1),
              ),
              hintText: 'Enter your Password',
              hintStyle: kHintTextStyle,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildHeightTF() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'Height',
          style: kLabelStyle,
        ),
        SizedBox(height: 10.0),
        Container(
          alignment: Alignment.centerLeft,
          decoration: kBoxDecorationStyle,
          height: 60.0,
          child: TextField(
            keyboardType: TextInputType.emailAddress,
            style: TextStyle(
              color: Colors.black,
              fontFamily: 'OpenSans',
            ),
            decoration: InputDecoration(
              border: InputBorder.none,
              contentPadding: EdgeInsets.only(top: 14.0),
              prefixIcon: Icon(
                Icons.height,
                color: Color.fromRGBO(255, 120, 90,1),
              ),
              hintText: 'Enter your Height',
              hintStyle: kHintTextStyle,
            ),
          ),
        ),
      ],
    );
  }

   Widget _buildWeightTF() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'Weight',
          style: kLabelStyle,
        ),
        SizedBox(height: 10.0),
        Container(
          alignment: Alignment.centerLeft,
          decoration: kBoxDecorationStyle,
          height: 60.0,
          child: TextField(
            keyboardType: TextInputType.emailAddress,
            style: TextStyle(
              color: Colors.black,
              fontFamily: 'OpenSans',
            ),
            decoration: InputDecoration(
              border: InputBorder.none,
              contentPadding: EdgeInsets.only(top: 14.0),
              prefixIcon: Icon(
                Icons.scale,
                color: Color.fromRGBO(255, 120, 90,1),
              ),
              hintText: 'Enter your Weight',
              hintStyle: kHintTextStyle,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildLoginBtn() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 25.0),
      width: double.infinity,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
        elevation: 5.0,
        backgroundColor: Color.fromRGBO(140, 179, 105,1),
        padding: EdgeInsets.all(15.0),
        shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(30.0),
        ),
      ),
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => HomeScreen()),
            );
        },
        child: Text(
          'Sign Up',
          style: TextStyle(
            color: Colors.white,
            letterSpacing: 1.5,
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
            fontFamily: 'OpenSans',
          ),
        ),
      ),
    );
  }


  Widget _buildSignupBtn() {
    return GestureDetector(
      onTap: () => Navigator.of(context).push(MaterialPageRoute(builder: (context) => LoginScreen())),
      child: RichText(
        text: TextSpan(
          children: [
            TextSpan(
              text: 'Already haven an account ',
              style: TextStyle(
                color: Colors.grey,
                fontSize: 18.0,
                fontWeight: FontWeight.w400,
              ),
            ),
            TextSpan(
              text: 'Sign In',
              style: TextStyle(
                color: Colors.grey,
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
              ),

            ),
          ],
        ),
      ),
    );
  }
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.light,
        child: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: Stack(
            children: <Widget>[
              Container(
                height: double.infinity,
                width: double.infinity,
                decoration: BoxDecoration(
                ),
              ),
              Container(
                height: double.infinity,
                child: SingleChildScrollView(
                  physics: AlwaysScrollableScrollPhysics(),
                  padding: EdgeInsets.symmetric(
                    horizontal: 40.0,
                    vertical: 120.0,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        'Sign Up',
                        style: TextStyle(
                          color: Colors.grey,
                          fontFamily: 'OpenSans',
                          fontSize: 30.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 30.0),
                      _buildUserTF(),
                      SizedBox(
                        height: 20.0,
                      ),
                      _buildPasswordTF(),
                       SizedBox(
                        height: 20.0,
                      ),
                      _buildEmailTF(),
                       SizedBox(
                        height: 20.0,
                      ),
                       _buildHeightTF(),
                      SizedBox(
                        height: 20.0,
                      ), 
                      _buildWeightTF(),
                      SizedBox(
                        height: 20.0,
                      ),     
                      _buildLoginBtn(),
                      _buildSignupBtn(),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

