import 'package:flutter/material.dart';
import 'package:preferenciasusuarioapp/src/share_prefs/preferencias_usuario.dart';
import 'package:preferenciasusuarioapp/src/widgets/menu_widget.dart';
//import 'package:shared_preferences/shared_preferences.dart';

class SettingsPage extends StatefulWidget {
  static final String routeName = 'settings';

  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  bool _colorSecundario=false;
  int _genero;
  String _nombre = 'Pedro';

  TextEditingController _textController;
  final prefs = new PreferenciasUsuario();
  @override
  void initState() {
    //TODO: implement initState
    super.initState();
    prefs.ultimaPagina=SettingsPage.routeName;
    _genero=prefs.genero;
    _colorSecundario=prefs.colorSecundario;
    //cargaPref();
    _textController = new TextEditingController(text: prefs.nombreUsuario);
  }
  /*cargaPref() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _genero=prefs.getInt('genero');
    setState(() {
      
    });
  }*/
  _setSelectedRadio(int valor){
    
    //prefs.setInt('genero', valor);
    prefs.genero=valor;
    _genero=valor;
    setState(() {
      
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Ajustes'),
        backgroundColor: (prefs.colorSecundario) ? Colors.teal:Colors.blue,
      ),
      drawer: MenuWidget(),
      body: ListView(
        children: <Widget>[
          Container(
            padding: EdgeInsets.all(5.0),
            child: Text('Settings',style: TextStyle(fontSize: 45.0,fontWeight: FontWeight.bold),),
          ),
          Divider(),
          SwitchListTile(
            value: _colorSecundario,
            title: Text('Color secundario'),
            onChanged: (value){
              _colorSecundario=value;
              setState(() {
                prefs.colorSecundario=value;
              });
            },
          ),
          RadioListTile(
            value: 1,
            title: Text('Masculino'),
            groupValue: _genero,
            onChanged: _setSelectedRadio,
          ),
          RadioListTile(
            value: 2,
            title: Text('Femenino'),
            groupValue: _genero,
            onChanged: _setSelectedRadio,
          ),
          Divider(),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 20.0),
            child: TextField(
              controller: _textController,
              decoration: InputDecoration(
                labelText: 'Nombre',
                helperText: 'Nombre de la persona usando el telefono',

              ),
              onChanged: (value){
                prefs.nombreUsuario=value;
              },
            ),
          )
        ],
      ),
    );
  }
}