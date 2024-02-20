import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class Encrypt extends StatefulWidget {
  const Encrypt({Key? key}) : super(key: key);

  @override
  _EncryptState createState() => _EncryptState();
}

String _encryptResult = '';
String _decryptResult = '';

class _EncryptState extends State<Encrypt> {
  final TextEditingController _inputController = TextEditingController();
  final FlutterSecureStorage _secureStorage = FlutterSecureStorage();

  Future<void> _saveToSecureStorage() async {
    final String inputValue = _inputController.text;

    if (inputValue.isNotEmpty) {
      // Encrypt and save the value to secure storage
      await _secureStorage.write(key: 'example_key', value: inputValue);
      _inputController.clear();
      _showSuccessMessage('Value saved successfully!');
    } else {
      _showErrorMessage('Please enter a value.');
    }
  }

  void _showSuccessMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.green,
      ),
    );
  }

  void _showErrorMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.red,
      ),
    );
  }

  void handleEncrypt() async {
    _saveToSecureStorage();
    try {
      print(await _secureStorage.read(key: 'secret'));
      setState(() {
        _encryptResult = 'Hàm encrypt được gọi!!!';
      });
    } catch (err) {
      setState(() {
        _encryptResult = 'Bị lỗi rồi !!!';
      });
    }
  }

  void handleDecrypt() async {
    try {
      setState(() {
        _decryptResult = 'Hàm decrypt được gọi!!!';
      });
    } catch (err) {
      setState(() {
        _decryptResult = 'Bị lỗi rồi !!!';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Encrypt AES'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          const Icon(Icons.key, size: 16.0),
          const Text('App decrypt AES in sharepreferences'),
          TextField(
            controller: _inputController,
            decoration: InputDecoration(labelText: 'Enter a value'),
          ),
          ElevatedButton(
            onPressed: handleEncrypt,
            child: const Text('Encrypt'),
          ),
          const SizedBox(height: 20),
          Text(_encryptResult),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: handleDecrypt,
            child: const Text('Decrypt'),
          ),
          Text(_decryptResult),
        ],
      )),
      backgroundColor: Colors.blueGrey.shade200,
    );
  }
}
