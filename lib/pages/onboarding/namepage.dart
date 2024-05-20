import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../pages/onboarding/otp.dart';
import '../../components/onboarding/textfieldotp.dart';
import '../../providers/account_provider.dart';
import '../../utils/vars.dart';
import '../homescreen.dart';

class NamePage extends StatefulWidget {
  const NamePage({super.key});

  @override
  State<NamePage> createState() => _NamePageState();
}

class _NamePageState extends State<NamePage> {
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();

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
                                        builder: (context) => const OTPPage()),
                                  );
                                },
                                child: const Icon(Icons.arrow_back_ios_new)),
                            const Padding(
                              padding: EdgeInsets.only(left: 30.0),
                              child: Text(
                                'Introdu numele și prenumele',
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
                        'Nume',
                        style: TextStyle(
                            color: darkGrey,
                            fontSize: 17,
                            fontFamily: 'UberMoveMedium'),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 10.0, bottom: 20),
                        child: TextFieldBoxOTP(
                          keyboardType: TextInputType.name,
                          controller: lastNameController,
                        ),
                      ),
                      const Text(
                        'Prenume',
                        style: TextStyle(
                            color: darkGrey,
                            fontSize: 17,
                            fontFamily: 'UberMoveMedium'),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 10.0),
                        child: TextFieldBoxOTP(
                          keyboardType: TextInputType.name,
                          controller: firstNameController,
                        ),
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
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 35.0, left: 30, right: 30),
              child: GestureDetector(
                onTap: () async {
                  // if (firstNameController.text != '' &&
                  //     lastNameController.text != '') {
                  //   await auth.addName(firstNameController.text,
                  //       lastNameController.text, context);
                  // } else {
                  //   auth.setError("");
                  // }

                  if (lastNameController.text == '') {
                    auth.setError("Nu ai introdus un nume.");
                  } else {
                    if (firstNameController.text == '') {
                      auth.setError("Nu ai introdus un prenume");
                    } else {
                      await auth.addName(
                          firstNameController.text, lastNameController.text);

                      if (auth.errorMessage == '') {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const Homescreen()),
                        );
                      }
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
                          ? const Text(
                              'Continuă',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 22,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'UberMoveBold',
                              ),
                            )
                          : const CircularProgressIndicator(
                              color: Colors.white,
                              strokeWidth: 2,
                            ),
                    ),
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
