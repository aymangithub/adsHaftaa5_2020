import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:haftaa/provider/provider.dart';
import 'package:haftaa/ui/BottomNavigationBar.dart';
import 'package:haftaa/user/user.dart';
import 'package:haftaa/validation/validators.dart';

class PhoneAuth extends StatefulWidget {
  @override
  _PhoneAuthState createState() => _PhoneAuthState();
}

class _PhoneAuthState extends State<PhoneAuth> {
  var textPhoneController = TextEditingController();
  var textCodeController = TextEditingController();
  var forceResendingToken;
  var verificationId;
  bool codeSent = false;

  submit(BuildContext context) {
    if (textPhoneController.text == null ||
        textPhoneController.text.trim().isEmpty) {
      setState(() {
        errorMessage = 'أدخل رقم الجوال من فضلك';
      });
      return;
    }
    if (!codeSent)
      verifyPhoneNO(context);
    else
      signIn(context);
  }

  signIn(BuildContext context) async {
    if (textCodeController.text == null ||
        textCodeController.text.trim() == '') {
      setState(() {
        errorMessage = 'أدخل الكود';
      });

      return;
    }
    try {
      final AuthResult authResult = await Provider.of(context)
          .auth
          .signInWithPhoneNumber(textCodeController.text);
      await Provider.of(context).auth.refreshUserData();
      final User currentUser = await Provider.of(context).auth.currentUser();
      assert(authResult.user.uid == currentUser.id);

      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
            builder: (BuildContext context) => bottomNavigationBar()),
        ModalRoute.withName('/'),
      );
    } catch (e) {
      handleError(e);
    }
  }

  handleError(PlatformException error) {
    print(error);
    switch (error.code) {
      case 'ERROR_INVALID_VERIFICATION_CODE':
        setState(() {
          errorMessage = 'Invalid Code';
        });

        break;
      default:
        setState(() {
          errorMessage = error.message;
        });

        break;
    }
  }

  Future<void> verifyPhoneNO(BuildContext context) async {

    try{
      setState(() {
        errorMessage = '';
      });
      await Provider.of(context)
          .auth
          .verifyPhoneNumber(
        phone: textPhoneController.text,
        verificationCompleted: (authCredential) async {
          //rdirect to home page
          final AuthResult authResult = await Provider.of(context)
              .auth
              .signInWithCredential(authCredential).catchError((onError){
            var ss;
          });
          await Provider.of(context).auth.refreshUserData();
          final User currentUser =
          await Provider.of(context).auth.currentUser();
          assert(authResult.user.uid == currentUser.id);

          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
                builder: (BuildContext context) => bottomNavigationBar()),
            ModalRoute.withName('/'),
          );
        },
        verificationFailed: (authException) {
          setState(() {
            errorMessage = authException.message;
          });
        },
        codeSent: (_verificationId, [_forceResendingToken]) {
          setState(() {
            codeSent = true;
          });
        },
        codeAutoRetrievalTimeout: (verificationId) {},
      )
          .catchError((onError) {
        var ss;
      });
    }catch(error){

      var error;

    }


  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  String errorMessage = '';
  @override
  Widget build(BuildContext context) {
    var phoneTextbox = Padding(
      padding: EdgeInsets.symmetric(horizontal: 30.0),
      child: Container(
        height: 60.0,
        alignment: AlignmentDirectional.center,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(14.0),
            color: Colors.white,
            boxShadow: [BoxShadow(blurRadius: 10.0, color: Colors.black12)]),
        padding:
            EdgeInsets.only(left: 20.0, right: 30.0, top: 0.0, bottom: 0.0),
        child: Theme(
          data: ThemeData(
            hintColor: Colors.transparent,
          ),
          child: TextFormField(
            validator: Validators.notEmptyText,
            controller: textPhoneController,
            //obscureText: password,
            decoration: InputDecoration(
                border: InputBorder.none,
                labelText: 'رقم الجوال',
                icon: Icon(
                  Icons.phone_iphone,
                  color: Colors.black38,
                ),
                labelStyle: TextStyle(
                    fontSize: 15.0,
                    fontFamily: 'Sans',
                    letterSpacing: 0.3,
                    color: Colors.black38,
                    fontWeight: FontWeight.w600)),
            keyboardType: TextInputType.phone,
          ),
        ),
      ),
    );
    var codeTextbox = Padding(
      padding: EdgeInsets.symmetric(horizontal: 30.0),
      child: Container(
        height: 60.0,
        alignment: AlignmentDirectional.center,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(14.0),
            color: Colors.white,
            boxShadow: [BoxShadow(blurRadius: 10.0, color: Colors.black12)]),
        padding:
            EdgeInsets.only(left: 20.0, right: 30.0, top: 0.0, bottom: 0.0),
        child: Theme(
          data: ThemeData(
            hintColor: Colors.transparent,
          ),
          child: TextFormField(
            validator: Validators.notEmptyText,
            controller: textCodeController,
            //obscureText: password,
            decoration: InputDecoration(
                border: InputBorder.none,
                labelText: 'الكود',
                icon: Icon(
                  Icons.cloud_done,
                  color: Colors.black38,
                ),
                labelStyle: TextStyle(
                    fontSize: 15.0,
                    fontFamily: 'Sans',
                    letterSpacing: 0.3,
                    color: Colors.black38,
                    fontWeight: FontWeight.w600)),
            keyboardType: TextInputType.phone,
          ),
        ),
      ),
    );

    return Column(
      children: <Widget>[
        !codeSent ? phoneTextbox : Container(),
        Padding(
          padding: EdgeInsets.only(top: 10),
        ),
        codeSent ? codeTextbox : Container(),
        Text(
          errorMessage,
          style: TextStyle(
              fontWeight: FontWeight.w600,
              color: Colors.white,
              letterSpacing: 0.2,
              fontFamily: 'Sans',
              fontSize: 17.0),
        ),
        InkWell(
          onTap: () => submit(context),
          child: Padding(
            padding: EdgeInsets.all(30.0),
            child: Container(
              height: 55.0,
              width: 600.0,
              child: Text(
                'التالي',
                style: TextStyle(
                    color: Colors.white,
                    letterSpacing: 0.2,
                    fontFamily: "Sans",
                    fontSize: 18.0,
                    fontWeight: FontWeight.w800),
              ),
              alignment: FractionalOffset.center,
              decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(color: Colors.black38, blurRadius: 15.0)
                  ],
                  borderRadius: BorderRadius.circular(30.0),
                  gradient: LinearGradient(
                      colors: <Color>[Color(0xFF121940), Color(0xFF6E48AA)])),
            ),
          ),
        )
      ],
    );
  }
}
