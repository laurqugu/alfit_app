import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({ Key? key }) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  String _email = '';
  String _password = '';
  bool _rememberme = true;


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
          suffixIcon: Icon(Icons.email),
          hintText: 'Ingresar correo electrónico',
          labelText: 'Correo electrónico',
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
        obscureText: true,
        decoration: InputDecoration(
          suffixIcon: Icon(Icons.lock),
          hintText: 'Ingresar contraseña',
          labelText: 'Contraseña',
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
             onPressed: () {},
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
}
