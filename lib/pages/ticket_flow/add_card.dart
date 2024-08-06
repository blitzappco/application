import 'package:flutter/material.dart';
import 'dart:ui';

class AddCardPage extends StatefulWidget {
  const AddCardPage({super.key});

  @override
  State<AddCardPage> createState() => _AddCardPageState();
}

class _AddCardPageState extends State<AddCardPage> with WidgetsBindingObserver {
  final _formKey = GlobalKey<FormState>();
  bool _isBlurred = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    setState(() {
      _isBlurred = state == AppLifecycleState.paused;
    });
  }

  Widget _buildTextField(String labelText, {TextInputType? keyboardType}) {
    return TextFormField(
      style: TextStyle(fontFamily: "SFProRounded", fontSize: 18),
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
          borderSide: BorderSide(
            width: 0,
            style: BorderStyle.none,
          ),
        ),
        filled: true,
        fillColor: Colors.grey[300], // Change to the appropriate color
        labelText: labelText,
        labelStyle: TextStyle(
          fontFamily: "SFProRounded",
          fontWeight: FontWeight.w500,
        ),
      ),
      keyboardType: keyboardType,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          SingleChildScrollView(
            child: SafeArea(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Container(
                          decoration: BoxDecoration(
                              shape: BoxShape.circle, color: Colors.grey[300]),
                          child: GestureDetector(
                            onTap: () {
                              Navigator.pop(context);
                            },
                            child: Padding(
                              padding: EdgeInsets.all(3.0),
                              child: Icon(
                                Icons.close,
                                color: Colors.grey[800],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    const Center(
                      child: Text(
                        "Adaugă o metodă de plată",
                        style: TextStyle(
                            fontFamily: "SFProRounded",
                            fontSize: 25,
                            fontWeight: FontWeight.w700),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          height: 30,
                          width: 50,
                          decoration: const BoxDecoration(
                              image: DecorationImage(
                                  image: AssetImage(
                                      "assets/images/visa-color_large.png"))),
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        Container(
                          height: 30,
                          width: 50,
                          decoration: const BoxDecoration(
                              image: DecorationImage(
                                  image: AssetImage(
                                      "assets/images/mastercard-color_large.png"))),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 50,
                    ),
                    Form(
                      key: _formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _buildTextField('Nume de pe card'),
                          const SizedBox(height: 10),
                          _buildTextField('Numarul cardului',
                              keyboardType: TextInputType.number),
                          const SizedBox(height: 10),
                          Row(
                            children: [
                              Expanded(
                                child: _buildTextField('Data expirare',
                                    keyboardType: TextInputType.datetime),
                              ),
                              const SizedBox(width: 10),
                              Expanded(
                                child: _buildTextField(
                                  'CVV',
                                  keyboardType: TextInputType.number,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 10),
                          _buildTextField('Adresa'),
                          const SizedBox(height: 10),
                          Text(
                            "Adăugarea unei metode de plată asigură stocarea în siguranță a detaliilor cardului în contul Blitz.",
                            style: TextStyle(
                                color: Colors.grey[600],
                                fontSize: 14,
                                fontFamily: "SFProRounded"),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          if (_isBlurred)
            Positioned.fill(
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
                child: Container(
                  color: Colors.black.withOpacity(0.3),
                ),
              ),
            ),
        ],
      ),
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 25),
          child: GestureDetector(
            onTap: () {
              if (_formKey.currentState!.validate()) {
                // Process data
              }
            },
            child: Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(9),
                  color: Color.fromARGB(255, 94, 8, 199)),
              child: Padding(
                padding: const EdgeInsets.all(13.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Adauga card",
                      style: TextStyle(
                          fontFamily: "SFProRounded",
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
