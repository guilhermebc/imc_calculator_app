import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    home: HomeApp(),
  ));
}

class HomeApp extends StatefulWidget {
  @override
  _HomeAppState createState() => _HomeAppState();
}

class _HomeAppState extends State<HomeApp> {

  TextEditingController inputWeightController = TextEditingController();
  TextEditingController inputHeightController = TextEditingController();

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String _infoText = 'Digite seus dados';

  void _resetFields() {
    inputWeightController.text = '';
    inputHeightController.text = '';

    setState(() {
      _infoText = 'Digite seus dados';
      _formKey = GlobalKey<FormState>();
    });
  }

  void _calculate() {
    setState(() {
      double weight = double.parse(inputWeightController.text);
      double height = double.parse(inputHeightController.text) / 100;
      double imc = weight / (height * height);
      print(imc);
      if (imc < 18.6) {
        _infoText = 'Abaixo do peso (${imc.toStringAsPrecision(3)})';
      } else if(imc >= 18.6 && imc < 24.9) {
        _infoText = setInfoResultText('Peso ideal', imc);
      } else if(imc >= 24.9 && imc < 29.9) {
        _infoText = setInfoResultText('Levemente acima do peso', imc);
      } else if(imc >= 29.9 && imc < 34.9) {
        _infoText = setInfoResultText('Obesidade grau I', imc);
      } else if(imc >= 34.9 && imc < 39.9) {
        _infoText = setInfoResultText('Obesidade grau II', imc);
      } else if (imc > 40) {
        _infoText = setInfoResultText('Obesidade grau III', imc);
      }
    });
  }

  String setInfoResultText(text, imc) {
    return '$text - ${imc.toStringAsPrecision(3)}';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("IMC Calculator"),
        centerTitle: true,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: _resetFields,
          )
        ],
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        padding: EdgeInsets.fromLTRB(15.0, 0.0, 15.0, 0.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Icon(Icons.person_outline, color: Colors.blue, size: 120.0),
              TextFormField(
                keyboardType: TextInputType.number,
                decoration: InputDecoration(labelText: "Peso (kg)"),
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 20.0),
                controller: inputWeightController,
                validator: (value) {
                  if(value.isEmpty) {
                    return 'Digite seu peso';
                  }
                }
              ),
              TextFormField(
                keyboardType: TextInputType.number,
                decoration: InputDecoration(labelText: "Altura (cm)"),
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 20.0),
                controller: inputHeightController,
                validator: (value) {
                  if(value.isEmpty) {
                    return 'Digite sua altura';
                  }
                }
              ),
              Padding(
                padding: EdgeInsets.only(top: 20.0, bottom: 20.0),
                child: Container(
                  height: 50.0,
                  child: RaisedButton(
                    onPressed: () {
                      if(_formKey.currentState.validate()) {
                        _calculate();
                      }
                    },
                    child: Text('Calcular', style: TextStyle(fontSize: 21.0)),
                    color: Colors.blue,
                    textColor: Colors.white,
                  ),
                ),
              ),
              Text(
                _infoText ,
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.black, fontSize: 22.0),
              )
            ],
          ),
        )
      )
    );
  }
}
