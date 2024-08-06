import 'package:blitz/pages/new_onboarding/name.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../components/onboarding/textfield.dart';
import '../../providers/account_provider.dart';
import '../../utils/vars.dart';
import '../../pages/onboarding/namepage.dart';
import '../../pages/onboarding/phonenumber.dart';
import '../homescreen.dart';

class OtpPage extends StatefulWidget {
  const OtpPage({super.key});

  @override
  State<OtpPage> createState() => _OtpPageState();
}

class _OtpPageState extends State<OtpPage> {
  TextEditingController otpController = TextEditingController();

  @override
  void initState() {
    super.initState();
    otpController.addListener(_onOtpChanged);
  }

  @override
  void dispose() {
    otpController.removeListener(_onOtpChanged);
    otpController.dispose();
    super.dispose();
  }

  void _onOtpChanged() async {
    final otp = otpController.text;
    if (otp.length == 4) {
      final auth = Provider.of<AccountProvider>(context, listen: false);
      await auth.verifyCode(otp);

      if (auth.errorMessage.isEmpty) {
        if (auth.newClient) {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const NameOnboarding()),
          );
        } else {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const Homescreen()),
          );
        }
      }
    }
  }

  void _continueWithPhoneNumber() {
    // Add the logic for the button tap here, if any.
    // For now, we can just call _onOtpChanged to mimic entering the OTP automatically.
    _onOtpChanged();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<AccountProvider>(builder: (context, auth, _) {
      return Scaffold(
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(30.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 30),
                  child: Row(
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.pop(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const PhoneNumber()),
                          );
                        },
                        child: const Icon(Icons.arrow_back_ios_new),
                      ),
                    ],
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: lightGrey,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Icon(
                      Icons.pin_rounded,
                      size: 30,
                      color: darkGrey,
                    ),
                  ),
                ),
                SizedBox(height: 15),
                Text(
                  "Introdu codul primit",
                  style: const TextStyle(
                    fontSize: 22,
                    fontFamily: 'SFProRounded',
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(height: 5),
                Text(
                  "Ti-am trimis un cod de verificare prin SMS",
                  style: const TextStyle(
                    fontSize: 15,
                    fontFamily: 'SFProRounded',
                    fontWeight: FontWeight.w400,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 10, top: 25),
                  child: TextField(
                    controller: otpController,
                    keyboardType: TextInputType.number,
                    autofillHints: [AutofillHints.oneTimeCode],
                    maxLength: 4,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide.none),
                      filled: true,
                      fillColor: const Color(0xFFE8E8E8),
                      hintText: 'Cod OTP',
                      counterText: '',
                    ),
                    style: const TextStyle(
                      fontSize: 17,
                      fontFamily: 'SFProRounded',
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                Row(
                  children: [
                    Column(
                      children: [
                        Text(
                          auth.errorMessage,
                          style: const TextStyle(
                            fontSize: 17,
                            fontFamily: 'SFProDisplay',
                            fontWeight: FontWeight.w600,
                            color: Colors.red,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        bottomNavigationBar: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 25),
            child: GestureDetector(
              onTap: _continueWithPhoneNumber,
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(9),
                  color: blitzPurple,
                ),
                child: Padding(
                  padding: const EdgeInsets.all(13.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      !auth.loading
                          ? Text(
                              'Continua',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.w600,
                                fontFamily: 'SFProRounded',
                              ),
                            )
                          : const SizedBox(
                              width: 30,
                              height: 30,
                              child: CircularProgressIndicator(
                                color: Colors.white,
                                strokeWidth: 2,
                              ),
                            ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      );
    });
  }
}
