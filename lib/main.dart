import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Calculadora Tarea - Ismael Vargas',
      debugShowCheckedModeBanner: false,
      home: PantallaCalculadora(),
    );
  }
}

class PantallaCalculadora extends StatefulWidget {
  const PantallaCalculadora({super.key});

  @override
  PantallaCalculadoraState createState() => PantallaCalculadoraState();
}

class PantallaCalculadoraState extends State<PantallaCalculadora> {
  double _resultado = 0;
  String _operacion = '';
  String _input = '';
  String _inputAnterior = ''; 

  void agregarNumero(String numero) {
    setState(() {
      _input += numero;
    });
  }

  void setOperacion(String operacion) {
    setState(() {
      _operacion = operacion;
      _resultado = double.tryParse(_input) ?? 0;
      _inputAnterior = _input;  
      _input = '';
    });
  }

  void calcularResultado() {
    double numero = double.tryParse(_input) ?? 0;
    setState(() {
      switch (_operacion) {
        case '+':
          _resultado += numero;
          break;
        case '-':
          _resultado -= numero;
          break;
        case '*':
          _resultado *= numero;
          break;
        case '/':
          _resultado = numero != 0 ? _resultado / numero : 0;
          break;
        default:
          break;
      }
      _input = _resultado.toString();
      _inputAnterior = '';  
      _operacion = '';
    });
  }

  void reiniciar() {
    setState(() {
      _resultado = 0;
      _input = '';
      _inputAnterior = '';
      _operacion = '';
    });
  }

  Widget botonCalculadora(String texto, Color color, VoidCallback onPressed) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: color,
        shape: const CircleBorder(),
        padding: const EdgeInsets.all(20),
      ),
      child: Text(
        texto,
        style: const TextStyle(fontSize: 24, color: Colors.white),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.orange.shade100,
      appBar: AppBar(
        title: const Text('Tarea Calculadora: Ismael Vargas'),
        titleTextStyle: const TextStyle(color: Colors.white, fontSize: 25),
        backgroundColor: Colors.orange.shade700,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Align(
              alignment: Alignment.centerRight,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    _inputAnterior, 
                    style: const TextStyle(fontSize: 24, color: Colors.grey),
                  ),
                  Text(
                    _input,
                    style: const TextStyle(fontSize: 48, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                botonCalculadora('7', Colors.blueAccent, () => agregarNumero('7')),
                botonCalculadora('8', Colors.blueAccent, () => agregarNumero('8')),
                botonCalculadora('9', Colors.blueAccent, () => agregarNumero('9')),
                botonCalculadora('/', Colors.orangeAccent, () => setOperacion('/')),
              ],
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                botonCalculadora('4', Colors.blueAccent, () => agregarNumero('4')),
                botonCalculadora('5', Colors.blueAccent, () => agregarNumero('5')),
                botonCalculadora('6', Colors.blueAccent, () => agregarNumero('6')),
                botonCalculadora('*', Colors.orangeAccent, () => setOperacion('*')),
              ],
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                botonCalculadora('1', Colors.blueAccent, () => agregarNumero('1')),
                botonCalculadora('2', Colors.blueAccent, () => agregarNumero('2')),
                botonCalculadora('3', Colors.blueAccent, () => agregarNumero('3')),
                botonCalculadora('-', Colors.orangeAccent, () => setOperacion('-')),
              ],
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                botonCalculadora('0', Colors.blueAccent, () => agregarNumero('0')),
                botonCalculadora('C', Colors.redAccent, reiniciar),
                botonCalculadora('=', Colors.green, calcularResultado),
                botonCalculadora('+', Colors.orangeAccent, () => setOperacion('+')),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
