import 'package:flutter/material.dart';

void main() {
  runApp(const Kalkulator());
}

class Kalkulator extends StatelessWidget {
  const Kalkulator({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: TampilanKalkulator(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class TampilanKalkulator extends StatefulWidget {
  const TampilanKalkulator({super.key});

  @override
  State<TampilanKalkulator> createState() => _TampilanKalkulatorState();
}

class _TampilanKalkulatorState extends State<TampilanKalkulator> {
  final _bbController = TextEditingController();
  final _tbController = TextEditingController();

  double? scoreBMI;
  String kategori = "Masukkan datanya terlebih dahulu";
  String gender = "Laki-laki";

  void hitungBMI() {
    double berat = double.tryParse(_bbController.text) ?? 0;
    double tinggi = double.tryParse(_tbController.text) ?? 0;

    setState(() {
      if (berat > 0 && tinggi > 0) {
        double bmi = berat / ((tinggi / 100) * (tinggi / 100));
        scoreBMI = bmi;

        if (gender == "Laki-laki") {
          if (bmi < 18.5) {
            kategori = "Kurus";
          } else if (bmi < 23) {
            kategori = "Normal";
          } else if (bmi < 27.5) {
            kategori = "Gemuk";
          } else {
            kategori = "Obesitas";
          }
        } else {
          // untuk perempuan
          if (bmi < 17.5) {
            kategori = "Kurus";
          } else if (bmi < 22) {
            kategori = "Normal";
          } else if (bmi < 27) {
            kategori = "Gemuk";
          } else {
            kategori = "Obesitas";
          }
        }
      } else {
        scoreBMI = null;
        kategori = "Input tidak valid";
      }
    });
  }

  void reset() {
    setState(() {
      _bbController.clear();
      _tbController.clear();
      scoreBMI = null;
      kategori = "Masukkan datanya terlebih dahulu";
      gender = "Laki-laki";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.orange[50],
      appBar: AppBar(
        title: const Text(
          "Kalkulator BMI",
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
        backgroundColor: const Color.fromARGB(255, 200, 94, 142),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 10),
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: const [
                    BoxShadow(
                        color: Colors.black26, blurRadius: 6, offset: Offset(0, 2))
                  ],
                ),
                child: Column(
                  children: [
                    TextField(
                      controller: _bbController,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        labelText: "Berat Badan (kg)",
                        prefixIcon: Icon(Icons.monitor_weight),
                        border: OutlineInputBorder(),
                      ),
                    ),
                    const SizedBox(height: 15),
                    TextField(
                      controller: _tbController,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        labelText: "Tinggi Badan (cm)",
                        prefixIcon: Icon(Icons.height),
                        border: OutlineInputBorder(),
                      ),
                    ),
                    const SizedBox(height: 15),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text("Jenis Kelamin: "),
                        DropdownButton<String>(
                          value: gender,
                          items: const [
                            DropdownMenuItem(
                                value: "Laki-laki", child: Text("Laki-laki")),
                            DropdownMenuItem(
                                value: "Perempuan", child: Text("Perempuan")),
                          ],
                          onChanged: (value) {
                            setState(() {
                              gender = value!;
                            });
                          },
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        ElevatedButton.icon(
                          onPressed: hitungBMI,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color.fromARGB(255, 219, 165, 149),
                          ),
                          icon: const Icon(Icons.calculate),
                          label: const Text("Hitung BMI"),
                        ),
                        ElevatedButton.icon(
                          onPressed: reset,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color.fromARGB(255, 147, 200, 227),
                          ),
                          icon: const Icon(Icons.refresh),
                          label: const Text("Reset"),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 30),
              Container(
                height: 180,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 227, 76, 76),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        scoreBMI?.toStringAsFixed(1) ?? '--',
                        style: const TextStyle(
                            fontSize: 40, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        kategori,
                        style: const TextStyle(
                            fontSize: 20, fontWeight: FontWeight.w600),
                      ),
                      const SizedBox(height: 5),
                      Text(
                        "($gender)",
                        style: const TextStyle(fontSize: 16),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}