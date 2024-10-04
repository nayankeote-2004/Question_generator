import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:test_1/main.dart';

class OtpPage extends StatefulWidget {
  @override
  _OtpPageState createState() => _OtpPageState();
}

class _OtpPageState extends State<OtpPage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  bool _isLoading = false;
  bool _isVerified = false;

  // Check if the email is verified
  Future<void> _checkEmailVerification() async {
    User? user = _auth.currentUser;
    if (user != null) {
      await user.reload(); // Reload the user to update email verification status
      setState(() {
        _isVerified = user.emailVerified;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _checkEmailVerification(); // Check email verification status on page load
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Verify Email'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _isVerified
                ? Icon(Icons.check_circle, color: Colors.green, size: 100)
                : Icon(Icons.error, color: Colors.red, size: 100),
            SizedBox(height: 20),
            Text(
              _isVerified
                  ? 'Your email has been verified!'
                  : 'Please check your email and verify it by clicking on the link.',
              style: TextStyle(fontSize: 18, color: Colors.teal),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _isLoading
                  ? null
                  : () async {
                      setState(() {
                        _isLoading = true;
                      });

                      // Check email verification status
                      await _checkEmailVerification();

                      if (_isVerified) {
                        // If verified, navigate to the home page
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(builder: (context) => HomePage()), // Replace with the next page
                        );
                      } else {
                        // Show error if not verified
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Email is not verified yet.')),
                        );
                      }

                      setState(() {
                        _isLoading = false;
                      });
                    },
              child: _isLoading
                  ? CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                    )
                  : Text(
                      _isVerified ? 'Proceed to Home' : 'Check Verification',
                      style: TextStyle(fontSize: 18),
                    ),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.teal,
                minimumSize: Size(double.infinity, 50),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
            SizedBox(height: 10),
            !_isVerified
                ? ElevatedButton(
                    onPressed: () async {
                      setState(() {
                        _isLoading = true;
                      });
                      User? user = _auth.currentUser;
                      if (user != null && !user.emailVerified) {
                        // Resend email verification
                        await user.sendEmailVerification();
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Verification email sent again.')),
                        );
                      }
                      setState(() {
                        _isLoading = false;
                      });
                    },
                    child: Text(
                      'Resend Verification Email',
                      style: TextStyle(fontSize: 16),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.orange,
                      minimumSize: Size(double.infinity, 50),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  )
                : Container(),
          ],
        ),
      ),
    );
  }
}
