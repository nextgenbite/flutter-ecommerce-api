import 'package:flutter/material.dart';

import 'login_screen.dart';

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  bool _isLoading = false;
  final _formKey = GlobalKey<FormState>();
  // ignore: prefer_typing_uninitialized_variables
  var email;
  // ignore: prefer_typing_uninitialized_variables
  var password;
  // ignore: prefer_typing_uninitialized_variables
  var fname;
  // ignore: prefer_typing_uninitialized_variables
  var lname;
  // ignore: prefer_typing_uninitialized_variables
  var phone;
  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(
        color: Colors.teal,
        child: Stack(
          children: <Widget>[
            Positioned(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Card(
                      elevation: 4.0,
                      color: Colors.white,
                      margin: EdgeInsets.only(left: 20, right: 20),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Form(
                          key: _formKey,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              TextFormField(
                                style: TextStyle(color: Color(0xFF000000)),
                                cursorColor: Color(0xFF9b9b9b),
                                keyboardType: TextInputType.text,
                                decoration: InputDecoration(
                                  prefixIcon: Icon(
                                    Icons.email,
                                    color: Colors.grey,
                                  ),
                                  hintText: "Email",
                                  hintStyle: TextStyle(
                                    color: Color(0xFF9b9b9b),
                                    fontSize: 15,
                                    fontWeight: FontWeight.normal,
                                  ),
                                ),
                                validator: (emailValue) {
                                  if (emailValue!.isEmpty) {
                                    return 'Please enter email';
                                  }
                                  email = emailValue;
                                  return null;
                                },
                              ),
                              TextFormField(
                                style: TextStyle(color: Color(0xFF000000)),
                                cursorColor: Color(0xFF9b9b9b),
                                keyboardType: TextInputType.text,
                                decoration: InputDecoration(
                                  prefixIcon: Icon(
                                    Icons.insert_emoticon,
                                    color: Colors.grey,
                                  ),
                                  hintText: "First Name",
                                  hintStyle: TextStyle(
                                    color: Color(0xFF9b9b9b),
                                    fontSize: 15,
                                    fontWeight: FontWeight.normal,
                                  ),
                                ),
                                validator: (firstname) {
                                  if (firstname!.isEmpty) {
                                    return 'Please enter your first name';
                                  }
                                  fname = firstname;
                                  return null;
                                },
                              ),
                              TextFormField(
                                style: TextStyle(color: Color(0xFF000000)),
                                cursorColor: Color(0xFF9b9b9b),
                                keyboardType: TextInputType.text,
                                decoration: InputDecoration(
                                  prefixIcon: Icon(
                                    Icons.insert_emoticon,
                                    color: Colors.grey,
                                  ),
                                  hintText: "Last Name",
                                  hintStyle: TextStyle(
                                    color: Color(0xFF9b9b9b),
                                    fontSize: 15,
                                    fontWeight: FontWeight.normal,
                                  ),
                                ),
                                validator: (lastname) {
                                  if (lastname!.isEmpty) {
                                    return 'Please enter your last name';
                                  }
                                  lname = lastname;
                                  return null;
                                },
                              ),
                              TextFormField(
                                style: TextStyle(color: Color(0xFF000000)),
                                cursorColor: Color(0xFF9b9b9b),
                                keyboardType: TextInputType.text,
                                decoration: InputDecoration(
                                  prefixIcon: Icon(
                                    Icons.phone,
                                    color: Colors.grey,
                                  ),
                                  hintText: "Phone",
                                  hintStyle: TextStyle(
                                    color: Color(0xFF9b9b9b),
                                    fontSize: 15,
                                    fontWeight: FontWeight.normal,
                                  ),
                                ),
                                validator: (phonenumber) {
                                  if (phonenumber!.isEmpty) {
                                    return 'Please enter phone number';
                                  }
                                  phone = phonenumber;
                                  return null;
                                },
                              ),
                              TextFormField(
                                style: TextStyle(color: Color(0xFF000000)),
                                cursorColor: Color(0xFF9b9b9b),
                                keyboardType: TextInputType.text,
                                obscureText: true,
                                decoration: InputDecoration(
                                  prefixIcon: Icon(
                                    Icons.vpn_key,
                                    color: Colors.grey,
                                  ),
                                  hintText: "Password",
                                  hintStyle: TextStyle(
                                    color: Color(0xFF9b9b9b),
                                    fontSize: 15,
                                    fontWeight: FontWeight.normal,
                                  ),
                                ),
                                validator: (passwordValue) {
                                  if (passwordValue!.isEmpty) {
                                    return 'Please enter some text';
                                  }
                                  password = passwordValue;
                                  return null;
                                },
                              ),
                              Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: ElevatedButton(
                                  onPressed: () {
                                    if (_formKey.currentState!.validate()) {
                                      _register();
                                    }
                                  },
                                  child: Padding(
                                    padding: EdgeInsets.only(
                                      top: 8,
                                      bottom: 8,
                                      left: 10,
                                      right: 10,
                                    ),
                                    child: Text(
                                      _isLoading
                                          ? 'Proccessing...'
                                          : 'Register',
                                      textDirection: TextDirection.ltr,
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 15.0,
                                        decoration: TextDecoration.none,
                                        fontWeight: FontWeight.normal,
                                      ),
                                    ),
                                  ),
                                ),
                                // FlatButton(
                                //   child: Padding(
                                //     padding: EdgeInsets.only(
                                //         top: 8, bottom: 8, left: 10, right: 10),
                                //     child: Text(
                                //       _isLoading? 'Proccessing...' : 'Register',
                                //       textDirection: TextDirection.ltr,
                                //       style: TextStyle(
                                //         color: Colors.white,
                                //         fontSize: 15.0,
                                //         decoration: TextDecoration.none,
                                //         fontWeight: FontWeight.normal,
                                //       ),
                                //     ),
                                //   ),
                                //   color: Colors.teal,
                                //   disabledColor: Colors.grey,
                                //   shape: new RoundedRectangleBorder(
                                //       borderRadius:
                                //       new BorderRadius.circular(20.0)),
                                //   onPressed: () {
                                //     if (_formKey.currentState.validate()) {
                                //       _register();
                                //     }
                                //   },
                                // ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),

                    Padding(
                      padding: const EdgeInsets.only(top: 20),
                      child: InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => LoginScreen(),
                            ),
                          );
                        },
                        child: Text(
                          'Already Have an Account',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 15.0,
                            decoration: TextDecoration.none,
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _register() async {
    setState(() {
      _isLoading = true;
    });

    // var res = await AuthService().authData(data, '/register');
    // var body = json.decode(res.body);
    // if (body['success']) {
    //   SharedPreferences localStorage = await SharedPreferences.getInstance();
    //   localStorage.setString('token', json.encode(body['token']));
    //   localStorage.setString('user', json.encode(body['user']));
    //   Navigator.push(context, MaterialPageRoute(builder: (context) => HomeScreen()));
    // }

    setState(() {
      _isLoading = false;
    });
  }
}
