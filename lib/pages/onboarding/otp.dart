import 'package:flutter/material.dart';
import 'package:otp_text_field/otp_text_field.dart';
import 'package:provider/provider.dart';
import 'package:otp_text_field/otp_field.dart';
import 'package:otp_text_field/style.dart';
import '../../pages/onboarding/namepage.dart';
import '../../pages/onboarding/phonenumber.dart';
import '../../providers/account_provider.dart';
import '../../utils/vars.dart';
import '../homescreen.dart';

class OTPPage extends StatefulWidget {
  const OTPPage({super.key});

  @override
  State<OTPPage> createState() => _OTPPageState();
}

class _OTPPageState extends State<OTPPage> {
  double opacity = 0;
  OtpFieldController otpText = OtpFieldController();
  void updateOpacity(double newOpacity) {
    setState(() {
      opacity = newOpacity;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<AccountProvider>(builder: (context, auth, _) {
      return Scaffold(
        body: Column(
          children: [
            Expanded(
              child: SafeArea(
                child: Padding(
                  padding: const EdgeInsets.all(30.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(bottom: 50.0),
                        child: Row(
                          children: [
                            GestureDetector(
                                onTap: () {
                                  Navigator.pop(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const PhoneNumber()),
                                  );
                                },
                                child: const Icon(Icons.arrow_back_ios_new)),
                            const Padding(
                              padding: EdgeInsets.only(left: 30.0),
                              child: Text(
                                'Verifică codul',
                                style: TextStyle(
                                    fontSize: 17,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: 'UberMoveBold'),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const Text(
                        'Am trimis un cod la',
                        style: TextStyle(
                            color: Color(0xFF6E6E6E),
                            fontSize: 17,
                            fontFamily: 'UberMoveMedium'),
                      ),
                      Text(
                        auth.phoneNumber,
                        style: const TextStyle(
                            color: blitzPurple,
                            fontSize: 17,
                            fontFamily: 'UberMoveMedium'),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 25.0),
                        child: OTPTextField(
                          controller: otpText,
                          length: 4,
                          width: MediaQuery.of(context).size.width,
                          fieldWidth: 40,
                          style: const TextStyle(fontSize: 17),
                          textFieldAlignment: MainAxisAlignment.spaceBetween,
                          fieldStyle: FieldStyle.box,
                          onCompleted: (code) async {
                            await auth.verifyCode(code);

                            otpText.clear();

                            if (auth.errorMessage == '') {
                              if (auth.newClient) {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => const NamePage()),
                                );
                              } else {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => const Homescreen()),
                                );
                              }
                            }
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 10.0),
                        child: Text(
                          auth.errorMessage,
                          style: const TextStyle(
                              fontSize: 17,
                              color: Colors.red,
                              fontFamily: 'UberMoveMedium'),
                        ),
                      ),
                      if (auth.loading)
                        const Padding(
                            padding: EdgeInsets.symmetric(),
                            child: SizedBox(
                                width: 30,
                                height: 30,
                                child: CircularProgressIndicator(
                                    color: Color(0XFF2E01C8), strokeWidth: 2)))
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      );
    });
  }
}
