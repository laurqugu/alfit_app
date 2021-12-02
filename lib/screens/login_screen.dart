import 'dart:convert';
import 'package:alfit_app/components/loader_component.dart';
import 'package:alfit_app/models/token.dart';
import 'package:alfit_app/screens/home_screen.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'package:alfit_app/helpers/constans.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({ Key? key }) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  String _email = 'laura@yopmail.com';
  String _emailError = '';
  bool _emailShowError = false;

  String _password = '123456';
  String _passwordError = '';
  bool _passwordShowError = false;

  bool _rememberme = true;
  bool _passwordShow = false;

  bool _showLoader = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              _showLogo(),
              SizedBox(height: 20,),
              _showEmail(),
              _showPassword(),
              _showRememberme(),
              _showButtons()
            ],
          ),
          _showLoader ? LoaderComponent(text: 'Cargando...') : Container(),
        ],
      )      
    );
  }

  Widget _showLogo() {
    return Image(
      image: AssetImage('assets/alifit-logo.png'),
      width: 170,
    );
  }

  Widget _showEmail() {
    return Container(
      padding: EdgeInsets.all(10),
      child: TextField(
        autofocus: true,
        keyboardType: TextInputType.emailAddress,
        decoration: InputDecoration(
          hintText: 'Ingresar correo electrónico',
          labelText: 'Correo electrónico',
          errorText: _emailShowError ?  _emailError : null,
          prefixIcon:  Icon(Icons.alternate_email),
          suffixIcon: Icon(Icons.email),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10) 
          ),
        ),
        onChanged: (value) {
          _email = value;
        },
      ),
    );
  }

  Widget _showPassword() {
    return Container(
      padding: EdgeInsets.all(10),
      child: TextField(
        obscureText: !_passwordShow,
        decoration: InputDecoration(
          prefixIcon: Icon(Icons.lock),
          suffixIcon: IconButton(
            icon: _passwordShow ? Icon(Icons.visibility) : Icon(Icons.visibility_off),
            onPressed: () {
              setState(() {
                _passwordShow = !_passwordShow;
              });
            },
          ), 
          hintText: 'Ingresar contraseña',
          labelText: 'Contraseña',
          errorText: _passwordShowError ? _passwordError : null,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10) 
          ),
        ),
        onChanged: (value) {
          _password = value;
        },
      ),
    );
  }

  Widget _showRememberme() {
    return CheckboxListTile(
      title: Text('Recordarme'),
      value: _rememberme, 
      onChanged: (value) {
        setState(() {
          _rememberme = value!;
        });
      },
    );
  }

 Widget _showButtons() {
   return Container(
     margin: EdgeInsets.only(left: 10, right: 10),
     child: Row(
       mainAxisAlignment: MainAxisAlignment.spaceAround,
       children:<Widget> [
         Expanded(
           child: ElevatedButton(
             child: Text('Ingresar'),
             style: ButtonStyle(
               backgroundColor: MaterialStateProperty.resolveWith<Color>(
                 (Set<MaterialState> states){
                   return Color(0xFFff64af);
                 }
               ),
             ),
             onPressed: () => _login(),
           ),
         ),
         SizedBox(width: 20,),
         Expanded(
           child: ElevatedButton(
             style: ButtonStyle(
               backgroundColor: MaterialStateProperty.resolveWith<Color>(
                 (Set<MaterialState> states){
                   return Color(0xFF32c2c8);
                 }
               ),
             ),
             child: Text('Registrarme'),
             onPressed: () {},
           ),
         ),
       ],
      ),
   );
 }

 void _login() async{
   setState(() {
     _passwordShow = false;
   });

   if (!_validateFields()) {
     return;
   }

   setState(() {
     _showLoader = true;
   });

   Map<String, dynamic> request = {
     'userName': _email,
     'password': _password
   };

   var url = Uri.parse('${Constans.apiUrl}/api/Account/CreateToken');
   var response = await http.post(
     url,
     headers:{
       'content-type': 'application/json',
       'accept': 'application/json',
     },
     body: jsonEncode(request)
   );

   setState(() {
     _showLoader = false;
   });

   if(response.statusCode >= 400){
     setState(() {
       _passwordShowError = true;
       _passwordError = "Correo y/o contraseña incorrectos.";
     });
     return;
   }

   var body = response.body;
   var decodedJson = jsonDecode(body);
   var token = Token.fromJson(decodedJson);
   Navigator.pushReplacement(
     context, 
     MaterialPageRoute(
       builder: (context) => HomeScreen(token: token,)
     )
   );
 }

  bool _validateFields() {
     bool isValid = true;

    if (_email.isEmpty) {
      isValid = false;
      _emailShowError = true;
      _emailError = 'Debes ingresar tu correo.';
    } else if (!EmailValidator.validate(_email)) {
      isValid = false;
      _emailShowError = true;
      _emailError = 'Debes ingresar un correo válido.';
    } else {
      _emailShowError = false;
    }

    if (_password.isEmpty) {
      isValid = false;
      _passwordShowError = true;
      _passwordError = 'Debes ingresar tu contraseña.';
    } else if (_password.length < 6) {
      isValid = false;
      _passwordShowError = true;
      _passwordError = 'Debes ingresar una contraseña de al menos 6 carácteres.';
    } else {
      _passwordShowError = false;
    }

    setState(() { });
    return isValid;
  }
}
