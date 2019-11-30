import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

final bd=Firestore.instance;

void main() => runApp(MaterialApp(
  debugShowCheckedModeBanner: false,
  theme: ThemeData(primarySwatch: Colors.green),
  home: Principal(),
)
);

class Principal extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return
      DefaultTabController(
        length: 4,
        child: 
        Scaffold(
          appBar:
           AppBar(
             backgroundColor: Color.fromARGB(255, 7, 94, 84),
             title: Text('WhatsApp'),
             actions: <Widget>[
               IconButton(
                 icon: Icon(Icons.search),
                onPressed: (){
                  print('Quieres Buscar Algo?');
                },
                   ),
              IconButton(
                icon: Icon(Icons.more_vert),
                onPressed: (){
                  print('Este es el Menu');
                },
              )
             ],
             bottom: 
              TabBar(
                tabs: <Widget>[
                  Tab(child: Icon(Icons.camera_alt)),
                  Tab(child: Text('Chats')),
                  Tab(child: Text('Estados')),
                  Tab(child: Text('Llamadas')),
                ],
              ),
           ),
           body: 
            TabBarView( children: <Widget>[
              Center(child: Text('Tomar Foto')),
              ListView(
                    children: <Widget>[
                      Card(
                        elevation: 0.0,
                        margin: EdgeInsets.all(1),
                        child: ListTile(
                        leading: Image.asset('images/1.png', width: 60,),
                        title: Text('Todos'),
                        subtitle: Text('Tarea Final'),
                        trailing: Text('6:28 p. m.', textAlign: TextAlign.right, style: TextStyle(fontSize: 12.0, color: Colors.grey),),
                        onTap: (){
                          Navigator.push(context,
                          MaterialPageRoute(builder: (context) => Chat()),
                         );
                        },
                       ),
                      )
                    ],
                  ),
              Center(child: Text('Toxico si revisas mucho')),
              Center(child: Text('Nadie me llama :v')),

              ],
            ),
            floatingActionButton: FloatingActionButton(
      child: Icon(Icons.message),
      onPressed: (){
         Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => Contactos()),
         );
       },
      ),
     ),
   );    
  }
}

class Contactos extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text("Contactos"),
        backgroundColor: Color.fromARGB(255, 7, 94, 84),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.search),
                onPressed: (){
                  print('Quieres Buscar Algo?');
                },
                   ),
              IconButton(
                icon: Icon(Icons.more_vert),
                onPressed: (){
                  print('Este es el Menu');
                },
              )  
        ],
      ),
      body: Center(
        child: Text('No tienes Contactos *n*')
      ),
    );
  }
}

class Chat extends StatelessWidget{

final txtMensaje = TextEditingController();
String sms;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text('Todos'),
        backgroundColor: Color.fromARGB(255, 7, 94, 84),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.videocam),
            onPressed: (){
              print('Hacer Videollamada');
            },
          ),
          IconButton(
            icon: Icon(Icons.phone),
                onPressed: (){
                  print('Quieres Buscar Algo?');
                },
                   ),
              IconButton(
                icon: Icon(Icons.more_vert),
                onPressed: (){
                  print('Este es el Menu');
                },
              )  
        ],
      ),

      body:

      StreamBuilder(
        stream: Firestore.instance.collection('whats').snapshots(),
        builder: (context, snap){
          return Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: <Widget>[
          Flexible(
            child: 
            ListView.builder(
              padding: EdgeInsets.all(20),
              reverse: false,
              itemBuilder: (context ,index){
               return consulta(index,snap.data.documents[index]);
              },
              itemCount: snap.data.documents.length,
            ),
          ),
          Row(
            children: <Widget>[
              Expanded(
                child:
                TextField(
                      decoration: InputDecoration(
                      labelText: 'Escribe un mensaje',
                      hintText: 'Escribe un mensaje',
                      border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(50)
                    )
                  ),
                      controller:  txtMensaje,
                ),
              ),
              Expanded(
                child: 
                IconButton(
                  icon: Icon(Icons.send),
                  color: Colors.green,
                  onPressed: (){
                 insertar(txtMensaje.text);
                  },
                ),
              )
            ],
          )
        ],
      );
     },
    )
   );
  }
}

void insertar (String sms) async{
  await bd.collection("whats").add({'mensaje':sms});
}

Widget consulta (int index ,DocumentSnapshot cons){
return Container(
margin: const EdgeInsets.symmetric(vertical: 8.0),
child: Container(
width: 200.0,
child: Row(
mainAxisAlignment: MainAxisAlignment.end,
children: <Widget>[
Container(
decoration: BoxDecoration(
color: Colors.lightGreen,
borderRadius: BorderRadius.circular(10),
),
child: Column(
children: <Widget>[
Container(
margin: const EdgeInsets.only(
right: 12, left: 12, top: 7, bottom: 5.0),
child: Text(cons.data['mensaje'],
style: TextStyle(
fontSize: 20,
color: Colors.black
),
),
),
],
),
),
Container(
width: 35,
height: 35,
margin: EdgeInsets.only(left: 5),
decoration: BoxDecoration(
shape: BoxShape.circle,
image: DecorationImage(
image: AssetImage("images/1.png"),
fit: BoxFit.fill
)
),
),
],
),
),
);
}









/*
  RaisedButton(
    child: 
    Text('Eliminar'),
    onPressed: (){
      eliminar();
    },
  ),
  RaisedButton(
    child: 
    Text('Se actualizo'),
    onPressed: (){
      actualizar();
    },
  )
    ],
  ),

void eliminar () async{
  await bd.collection("whats").document('direccion').delete();
}

void actualizar () async{
  await bd.collection("whats").document('direccion').updateData({'mensaje':'se actualizo el mensaje'});
}

*/