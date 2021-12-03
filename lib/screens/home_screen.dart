import 'package:alfit_app/models/token.dart';
import 'package:alfit_app/screens/login_screen.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  final Token token;

  HomeScreen({required this.token});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('AlFit'),
      ),
      body: _getBody(),
      drawer: widget.token.user.userType == 0 
      ? _getTrainerMenu() 
      : _getUserMenu(),
    );
  }

 Widget _getBody() {
   return Container(
     margin: EdgeInsets.all(30),
     child: Column(
       mainAxisAlignment: MainAxisAlignment.center,
       children: [
         ClipRRect(
           borderRadius: BorderRadius.circular(100),
           child: FadeInImage(
              placeholder: AssetImage('assets/alifit-logo.png'), 
              image: NetworkImage(widget.token.user.imageFullPath),
              height: 250,
              fit: BoxFit.cover
            ),
         ),
        SizedBox(height: 30),
        Center(
          child: Text('Que gusto saludarte ${widget.token.user.fullName}',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold
            ),
          ), 
        ),
       ] 
     ),
   );
 }

 Widget _getTrainerMenu() {
   return Drawer(
     child: ListView(
       padding: EdgeInsets.zero,
       children: <Widget>[
         DrawerHeader(
           child: Image(
             image: AssetImage('assets/alifit-logo.png'),
           )
         ),
         ListTile(
           leading: Icon(Icons.fitness_center_outlined),
           title: const Text('Ejercicios'),
           onTap: (){},
         ),
         ListTile(
           leading: Icon(Icons.assignment_ind_outlined),
           title: const Text('Tipos de Documentos'),
           onTap: (){},
         ),
         ListTile(
           leading: Icon(Icons.restaurant_menu_outlined),
           title: const Text('Información Nutricional'),
           onTap: (){},
         ),
         ListTile(
           leading: Icon(Icons.directions_run_outlined),
           title: const Text(' Test Performance'),
           onTap: (){},
         ),
         ListTile(
           leading: Icon(Icons.monitor_weight_outlined),
           title: const Text('Medidas'),
           onTap: (){},
         ),
         ListTile(
           leading: Icon(Icons.people_outline_outlined),
           title: const Text('Usuarios'),
           onTap: (){},
         ),
         Divider(
           color: Colors.pinkAccent,
           height: 2,
         ),
         ListTile(
           leading: Icon(Icons.manage_accounts_outlined,),
           title: const Text('Editar Perfil'),
           onTap: (){},
         ),
         ListTile(
           leading: Icon(Icons.exit_to_app_outlined,),
           title: const Text('Cerrar Sesión'),
           onTap: (){
            Navigator.pushReplacement(
              context, 
              MaterialPageRoute(
                builder: (context) => LoginScreen()
              )
            );
           },
         ),
       ],
     ),
   );
 }

 Widget _getUserMenu() {
   return Drawer(
     child: ListView(
       padding: EdgeInsets.zero,
       children: <Widget>[
         DrawerHeader(
           child: Image(
             image: AssetImage('assets/alifit-logo.png'),
           )
         ),
         ListTile(
           leading: Icon(Icons.format_list_bulleted),
           title: const Text('Registros de Entrenamiento'),
           onTap: (){},
         ),
         Divider(
           color: Colors.pinkAccent,
           height: 4,
         ),
         ListTile(
           leading: Icon(Icons.manage_accounts_outlined,),
           title: const Text('Editar Perfil'),
           onTap: (){},
         ),
         ListTile(
           leading: Icon(Icons.exit_to_app_outlined,),
           title: const Text('Cerrar Sesión'),
           onTap: (){
            Navigator.pushReplacement(
              context, 
              MaterialPageRoute(
                builder: (context) => LoginScreen()
              )
            );
           },
         ),
       ],
     ),
   );
 }
}