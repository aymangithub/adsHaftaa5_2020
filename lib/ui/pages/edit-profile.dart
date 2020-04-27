import 'package:flutter/material.dart';
import 'package:haftaa/authentication/auth.dart';
import 'package:haftaa/provider/provider.dart';
import 'package:haftaa/user/user-controller.dart';
import 'package:haftaa/user/user.dart';

class EditProfile extends StatefulWidget {
  static String tag = 'add-page';
  User user;
  EditProfile({this.user});
  @override
  _EditProfileState createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  final _formKey = GlobalKey<FormState>();
  final _name = TextEditingController();
  final _cNickName = TextEditingController();
  final _cWork = TextEditingController();
  final _cPhoneNumber = TextEditingController();
  final _cEmail = TextEditingController();
  final _cWebSite = TextEditingController();

  @override
  void initState() {
    setUserValues();
    super.initState();
  }

  setUserValues() {
    _name.text = widget.user.name;
  }

  @override
  Widget build(BuildContext context) {
    Provider.of(context).auth.currentFirebaseUser().then((onValue) {
      _name.text = onValue.displayName;
    });

    TextFormField inputName = TextFormField(
      controller: _name,
      autofocus: true,
      keyboardType: TextInputType.text,
      inputFormatters: [
        //LengthLimitingTextInputFormatter(45),
      ],
      decoration: InputDecoration(
        labelText: 'الاسم',
        icon: Icon(Icons.person),
      ),
      validator: (value) {
        if (value.isEmpty) {
          return 'أدخل الاسم';
        }
        return null;
      },
    );

    TextFormField inputNickName = TextFormField(
      controller: _cNickName,
      keyboardType: TextInputType.text,
      inputFormatters: [
        //LengthLimitingTextInputFormatter(25),
      ],
      decoration: InputDecoration(
        labelText: 'Apelido',
        icon: Icon(Icons.person),
      ),
    );

    TextFormField inputWork = TextFormField(
      controller: _cWork,
      inputFormatters: [
        //LengthLimitingTextInputFormatter(45),
      ],
      keyboardType: TextInputType.text,
      decoration: InputDecoration(
        labelText: 'Trabalho',
        icon: Icon(Icons.work),
      ),
    );

    TextFormField inputEmail = TextFormField(
      controller: _cEmail,
      inputFormatters: [
        //LengthLimitingTextInputFormatter(50),
      ],
      keyboardType: TextInputType.emailAddress,
      decoration: InputDecoration(
        labelText: 'E-mail',
        icon: Icon(Icons.email),
      ),
    );

    TextFormField inputWebSite = TextFormField(
      controller: _cWebSite,
      inputFormatters: [
        //LengthLimitingTextInputFormatter(50),
      ],
      keyboardType: TextInputType.text,
      decoration: InputDecoration(
        labelText: 'Site da Web',
        icon: Icon(Icons.web),
      ),
    );

    final picture = Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Container(
          width: 120.0,
          height: 120.0,
          child: CircleAvatar(
            child: Icon(
              Icons.camera_alt,
            ),
          ),
        ),
      ],
    );

    ListView content = ListView(
      padding: EdgeInsets.all(20),
      children: <Widget>[
        SizedBox(height: 20),
        //picture,
        Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              inputName,
              // inputNickName,
              // inputWork,
              // // inputPhoneNumber,
              // inputEmail,
              // inputWebSite,
            ],
          ),
        ),
      ],
    );

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.close),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        title: Text("بياناتي"),
        actions: <Widget>[
          Container(
            width: 80,
            child: IconButton(
              icon: Text(
                'حفظ',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              onPressed: () async {
                if (_formKey.currentState.validate()) {
                  UserController().updateProfile(
                      await Provider.of(context).auth.currentFirebaseUser(),
                      name: _name.text).then((onValue){
                        Provider.of(context).auth.refreshUserData().then((onValue){
Navigator.pop(context);
                        });
                        
                      });
                }
              },
            ),
          )
        ],
      ),
      body: content,
    );
  }
}
