import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({ Key? key }) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  String _email = '';
  String _emailError = '';
  bool _emailShowError = false;

  String _password = '';
  String _passwordError = '';
  bool _passwordShowError = false;

  bool _rememberme = true;
  bool _passwordShow = false;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              _showLogo(),
              SizedBox(height: 20,),
              _showEmail(),
              _showPassword(),
              _showRememberme(),
              _showButtons()
            ],
          )
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

 void _login() {
   if (!_validateFields()) {
     return;
   }
 }

  bool _validateFields() {
    bool hasErrors = false;

    if (_email.isEmpty) {
      hasErrors = true;
      _emailShowError = true;
      _emailError = 'Debes ingresar tu correo electrónico';
    }else if(!EmailValidator.validate(_email)){
      hasErrors = true;
      _emailError = 'Debes ingresar un correo válido.'; 
    }else{
      _emailShowError = false;
    }

    if (_password.isEmpty) {
      hasErrors = true;
      _passwordShowError = true;
      _passwordError = 'Debes ingresar tu contraseña.';
    }else if(_password.length < 6){
      hasErrors = true;
      _passwordError = 'Debes ingresar una contraseña de al menos 6 carácteres.'; 
    }else{
      _passwordShowError = false;
    }

    setState(() { });

    return hasErrors;
  }
}
