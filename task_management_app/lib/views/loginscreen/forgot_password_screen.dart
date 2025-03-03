import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:go_router/go_router.dart';
import 'login_screen.dart';

class ForgotPasswordScreen extends StatefulWidget {
  @override
  _ForgotPasswordScreenState createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final TextEditingController emailController = TextEditingController();
  final List<TextEditingController> otpControllers = List.generate(5, (index) => TextEditingController());
  final List<FocusNode> otpFocusNodes = List.generate(5, (index) => FocusNode());
  final TextEditingController newPasswordController = TextEditingController();

  bool isOtpSent = false;
  bool isOtpVerified = false;
  bool isPasswordVisible = false;

  bool isValidEmail(String email) {
    return RegExp(r"^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$").hasMatch(email);
  }

  bool isPasswordValid() {
    return newPasswordController.text.length >= 8;
  }

  void sendOtp() {
    if (emailController.text.isEmpty || !isValidEmail(emailController.text)) {
      Fluttertoast.showToast(
        msg: "Enter a valid email",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.red,
        textColor: Colors.white,
      );
      return;
    }

    setState(() {
      isOtpSent = true;
    });

    // Fluttertoast.showToast(
    //   msg: "OTP sent to registered email ID",
    //   toastLength: Toast.LENGTH_SHORT,
    //   gravity: ToastGravity.TOP,
    //   backgroundColor: Colors.teal,
    //   textColor: Colors.white,
    // );
  }

  void submitOtp() {
    String otp = otpControllers.map((controller) => controller.text).join();
    if (otp.length < 5) {
      // Fluttertoast.showToast(
      //   msg: "Enter complete OTP",
      //   toastLength: Toast.LENGTH_SHORT,
      //   gravity: ToastGravity.BOTTOM,
      //   backgroundColor: Colors.red,
      //   textColor: Colors.white,
      // );
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Password reset successful, you can login again!'),
          behavior: SnackBarBehavior.floating,
          margin: EdgeInsets.only(top: 10, left: 16, right: 16),
        ),
      );
      return;
    }

    setState(() {
      isOtpVerified = true;
    });
  }

  bool isOtpComplete() {
    return otpControllers.every((controller) => controller.text.isNotEmpty);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          Expanded(
            child: Container(
              color: Colors.teal,
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Forgot Password",
                      style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white),
                    ),
                    SizedBox(height: 10),
                    Text(
                      "Can't Remember Password? Enter your email below for OTP confirmation",
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.white70),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.all(32.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Forgot Password",
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.teal),
                  ),
                  SizedBox(height: 20),
                  if (!isOtpSent)
                    TextField(
                      controller: emailController,
                      decoration: InputDecoration(
                        labelText: "Email",
                        border: OutlineInputBorder(),
                        prefixIcon: Icon(Icons.email_outlined),
                        errorText: emailController.text.isNotEmpty && !isValidEmail(emailController.text) ? "Invalid email format" : null,
                      ),
                      keyboardType: TextInputType.emailAddress,
                      onChanged: (_) => setState(() {}),
                    ),
                  if (isOtpSent && !isOtpVerified) ...[
                    Text("Enter OTP", style: TextStyle(fontWeight: FontWeight.bold)),
                    SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(5, (index) {
                        return Padding(
                          padding: EdgeInsets.symmetric(horizontal: 5),
                          child: SizedBox(
                            width: 45,
                            child: TextField(
                              controller: otpControllers[index],
                              focusNode: otpFocusNodes[index],
                              textAlign: TextAlign.center,
                              keyboardType: TextInputType.number,
                              maxLength: 1,
                              decoration: InputDecoration(
                                border: OutlineInputBorder(),
                                counterText: "",
                              ),
                              onChanged: (value) {
                                if (value.isNotEmpty && RegExp(r'^[0-9]$').hasMatch(value)) {
                                  if (index < 4) {
                                    FocusScope.of(context).requestFocus(otpFocusNodes[index + 1]);
                                  }
                                } else {
                                  otpControllers[index].clear();
                                }
                                setState(() {});
                              },
                            ),
                          ),
                        );
                      }),
                    ),
                  ],
                  if (isOtpVerified) ...[
                    SizedBox(height: 10),
                    TextField(
                      controller: newPasswordController,
                      obscureText: !isPasswordVisible,
                      decoration: InputDecoration(
                        labelText: "New Password",
                        border: OutlineInputBorder(),
                        prefixIcon: Icon(Icons.lock_outline),
                        suffixIcon: IconButton(
                          icon: Icon(isPasswordVisible ? Icons.visibility : Icons.visibility_off),
                          onPressed: () {
                            setState(() {
                              isPasswordVisible = !isPasswordVisible;
                            });
                          },
                        ),
                        errorText: newPasswordController.text.isNotEmpty && !isPasswordValid() ? "Password must be at least 8 characters" : null,
                      ),
                      onChanged: (_) => setState(() {}),
                    ),
                  ],
                  SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: (emailController.text.isEmpty && !isOtpSent)
                        ? null
                        : (!isOtpSent)
                            ? sendOtp
                            : (!isOtpVerified && isOtpComplete())
                                ? submitOtp
                                : (isOtpVerified && isPasswordValid())
                                    ? () {
                                        // Fluttertoast.showToast(
                                        //   msg: "Password reset successful, you can login again",
                                        //   toastLength: Toast.LENGTH_LONG,
                                        //   gravity: ToastGravity.TOP,
                                        //   backgroundColor: Colors.teal,
                                        //   textColor: Colors.white,
                                        // );
                                        ScaffoldMessenger.of(context).showSnackBar(
                                          const SnackBar(
                                            content: Text('Password reset successful, you can login again!'),
                                            behavior: SnackBarBehavior.floating,
                                            margin: EdgeInsets.only(top: 10, left: 16, right: 16),
                                          ),
                                        );
                                        // Navigator.pushReplacement(
                                        //   context,
                                        //   MaterialPageRoute(builder: (context) => LoginScreen()),
                                        // );
                                        context.go('/login');
                                      }
                                    : null,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: (!isOtpSent || (isOtpSent && isOtpComplete() && isPasswordValid())) ? Colors.teal : Colors.teal,
                    ),
                    child: Text(
                      isOtpSent ? (isOtpVerified ? "RESET PASSWORD" : "SUBMIT OTP") : "SEND OTP",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  SizedBox(height: 10),
                  TextButton(
                    onPressed: () => Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => LoginScreen()),
                    ),
                    child: Text("Back to Login"),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
