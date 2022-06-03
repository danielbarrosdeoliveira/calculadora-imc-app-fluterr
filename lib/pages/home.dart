import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final TextEditingController heightController = TextEditingController();
  final TextEditingController weightControler = TextEditingController();

  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  Map<String, String?>? error;

  String infoText =
      "Por favor, preencha seu peso e altura, e clique em calcular...";

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.grey[100],
        body: Padding(
          padding: const EdgeInsets.only(top: 20, left: 16, right: 16),
          child: Form(
            key: formKey,
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      'Calcule seu IMC',
                      style: GoogleFonts.roboto(
                        color: Colors.black,
                        fontSize: 20,
                      ),
                    ),
                    OutlinedButton(
                      onPressed: handleResetFields,
                      child: const Text('Limpar'),
                    )
                  ],
                ),
                const SizedBox(
                  height: 16,
                ),
                const Icon(
                  Icons.accessibility_new_rounded,
                  size: 80,
                ),
                const SizedBox(
                  height: 16,
                ),
                TextFormField(
                  controller: weightControler,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Peso (Kg)',
                    hintText: 'Ex: 78.9',
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Preencha seu peso!";
                    }
                  },
                ),
                const SizedBox(
                  height: 24,
                ),
                TextFormField(
                    controller: heightController,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Altura (cm)',
                      hintText: 'Ex: Para 1.80 coloque 180',
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Preencha sua altura!";
                      }
                    }),
                const SizedBox(
                  height: 20,
                ),
                ElevatedButton(
                  onPressed: handleCalculateIMC,
                  child: const Text('Calcular'),
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size.fromHeight(50),
                  ),
                ),
                const SizedBox(
                  height: 32,
                ),
                Text(
                  infoText,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.grey[500],
                    height: 1.5,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void handleCalculateIMC() {
    if (formKey.currentState!.validate()) {
      double weight = double.parse(weightControler.text);
      double height = double.parse(heightController.text) / 100;

      double result = weight / (height * height);

      String resultFormated = result.toStringAsFixed(0);

      if (result < 16) {
        setState(() {
          infoText = 'Seu IMC é $resultFormated, MAGREZA EXTREMA';
        });
      } else if (result > 16 && result < 17) {
        setState(() {
          infoText = 'Seu IMC é $resultFormated, MAGREZA MODERADA';
        });
      } else if (result > 17 && result < 18.5) {
        setState(() {
          infoText = 'Seu IMC é $resultFormated, MAGREZA LEVE';
        });
      } else if (result > 18.5 && result < 25) {
        setState(() {
          infoText = 'Seu IMC é $resultFormated, SAUDÁVEL';
        });
      } else if (result > 25 && result < 30) {
        setState(() {
          infoText = 'Seu IMC é $resultFormated, SOBREPESO';
        });
      } else if (result > 30 && result < 35) {
        setState(() {
          infoText = 'Seu IMC é $resultFormated, OBESIDADE GRAU I';
        });
      } else if (result > 35 && result < 40) {
        setState(() {
          infoText = 'Seu IMC é $resultFormated, OBESIDADE GRAU II';
        });
      } else if (result >= 40) {
        setState(() {
          infoText = 'Seu IMC é $resultFormated, OBESIDADE GRAU III';
        });
      }
    }
  }

  void handleResetFields() {
    weightControler.text = "";
    heightController.text = "";

    setState(() {
      infoText =
          "Por favor, preencha seu peso e altura, e clique em calcular...";
    });
  }
}
