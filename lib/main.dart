import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: ReservationPage(),
    );
  }
}

class ReservationPage extends StatefulWidget {
  @override
  _ReservationPageState createState() => _ReservationPageState();
}

class _ReservationPageState extends State<ReservationPage> {
  TextEditingController _nameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _museoController = TextEditingController();
  TextEditingController _localitaController = TextEditingController();

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  void _generateQRCode() {
    if (_formKey.currentState!.validate()) {
      String name = _nameController.text.trim();
      String email = _emailController.text.trim();
      String museo = _museoController.text.trim();
      String localita = _localitaController.text.trim();

      String reservationData =
          'Name: $name\nEmail: $email\nMuseo: $museo\nLocalita: $localita';
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Dettagli della prenotazione'),
            content: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 200.0,
                  height: 200.0,
                  child: QrImageView(
                    data: reservationData,
                    version: QrVersions.auto,
                    size: 200.0,
                  ),
                ),
                SizedBox(height: 16.0),
                Text('Scansiona il codice QR'),
              ],
            ),
            actions: <Widget>[
              TextButton(
                child: Text('OK'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      ).then((value) {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('Informazioni della prenotazione'),
              content: Text(reservationData),
              actions: <Widget>[
                TextButton(
                  child: Text('OK'),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ],
            );
          },
        );
      });
    }
  }

  void _buyTicket() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Acquista un biglietto'),
          content: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextFormField(
                  controller: _nameController,
                  decoration: InputDecoration(
                    labelText: 'Nome',
                  ),
                  keyboardType: TextInputType.text,
                  textCapitalization: TextCapitalization.words,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Inserisci un nome valido';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 8.0),
                TextFormField(
                  controller: _emailController,
                  decoration: InputDecoration(
                    labelText: 'Email',
                  ),
                  keyboardType: TextInputType.emailAddress,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Inserisci una email valida';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 8.0),
                TextFormField(
                  controller: _museoController,
                  decoration: InputDecoration(
                    labelText: 'Museo',
                  ),
                  keyboardType: TextInputType.text,
                  textCapitalization: TextCapitalization.words,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Inserisci un museo valido';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 8.0),
                TextFormField(
                  controller: _localitaController,
                  decoration: InputDecoration(
                    labelText: 'Località',
                  ),
                  keyboardType: TextInputType.text,
                  textCapitalization: TextCapitalization.words,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Inserisci una località valida';
                    }
                    return null;
                  },
                ),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Acquista'),
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  _generateQRCode();
                  Navigator.of(context).pop();
                }
              },
            ),
            TextButton(
              child: Text('Annulla'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _museoController.dispose();
    _localitaController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Text('Museo'),
                SizedBox(width: 8.0),
                Text('Prenotazione'),
              ],
            ),
            Row(
              children: [
                TextButton(
                  onPressed: () {
                    // TODO: Navigate to the museum screen
                  },
                  child: Text('Museo'),
                ),
                TextButton(
                  onPressed: () {
                    // TODO: Navigate to the home screen
                  },
                  child: Text('Home'),
                ),
              ],
            ),
          ],
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Expanded(
              child: Container(),
            ),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: _generateQRCode,
                    child: Text('Genera il codice QR'),
                  ),
                ),
                SizedBox(width: 16.0),
                Expanded(
                  child: ElevatedButton(
                    onPressed: _buyTicket,
                    child: Text('Acquista un biglietto'),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
