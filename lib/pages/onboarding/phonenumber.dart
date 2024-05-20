import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import './otp.dart';
import '../../pages/onboarding/onboarding.dart';
import '../../components/onboarding/textfield.dart';
import '../../providers/account_provider.dart';

class PhoneNumber extends StatefulWidget {
  const PhoneNumber({super.key});

  @override
  State<PhoneNumber> createState() => _PhoneNumberState();
}

class _PhoneNumberState extends State<PhoneNumber> {
  TextEditingController phoneNumberController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Consumer<AccountProvider>(builder: (context, auth, _) {
      return Scaffold(
        body: SafeArea(
          child: Expanded(
            child: Padding(
              padding: const EdgeInsets.all(30.0),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 50),
                    child: Row(
                      children: [
                        GestureDetector(
                            onTap: () {
                              Navigator.pop(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const Onboarding()),
                              );
                            },
                            child: const Icon(Icons.arrow_back_ios_new)),
                        const Padding(
                          padding: EdgeInsets.only(left: 30.0),
                          child: Text(
                            'Introdu numărul de telefon',
                            style: TextStyle(
                                fontSize: 17,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'UberMoveBold'),
                          ),
                        )
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 20),
                    child: TextFieldBox(
                      controller: phoneNumberController,
                    ),
                  ),
                  const Row(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Iți vom trimite un SMS pentru',
                            style: TextStyle(
                                fontSize: 17, fontFamily: 'UberMoveMedium'),
                          ),
                          Text(
                            'a verifica numărul tău.',
                            style: TextStyle(
                                fontSize: 17, fontFamily: 'UberMoveMedium'),
                          ),
                        ],
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        Column(
                          children: [
                            Text(auth.errorMessage,
                                style: const TextStyle(
                                    fontSize: 17,
                                    fontFamily: 'UberMoveBold',
                                    color: Colors.red)),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const Spacer(),
                  GestureDetector(
                    onTap: () async {
                      String phoneNumber = "+4${phoneNumberController.text}";

                      if (phoneNumberController.text.length != 10) {
                        auth.setError("Număr de telefon incorect.");
                      } else {
                        await auth.onboarding(phoneNumber);

                        if (auth.errorMessage == '') {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const OTPPage()),
                          );
                        }
                      }
                    },
                    child: Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: const Color(0XFF2E01C8),
                        borderRadius: BorderRadius.circular(27),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(top: 15, bottom: 15),
                        child: Center(
                          child: !auth.loading
                              ? const Text('Continua',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 22,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: 'UberMoveBold',
                                  ))
                              : const CircularProgressIndicator(
                                  color: Colors.white,
                                  strokeWidth: 2,
                                ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    });
  }
}
