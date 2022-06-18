import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:test_val/dto/user_login_dto.dart';
import 'package:test_val/screen/second_screen.dart';
import 'package:test_val/service/dio_service.dart';
import 'package:test_val/service/secure_storage_service.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({Key? key}) : super(key: key);

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final GlobalKey<FormBuilderState> _formKey = GlobalKey();
  final GlobalKey<FormBuilderFieldState> _emailFieldKey = GlobalKey();
  final GlobalKey<FormBuilderFieldState> _passwordFieldKey = GlobalKey();
  bool _formError = false;

  @override
  Widget build(BuildContext context) {
    return FormBuilder(
      key: _formKey,
      child: Container(
        color: Color.fromRGBO(255, 255, 255, 0.05),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              margin: EdgeInsets.symmetric(vertical: 20, horizontal: 20.0),
              child: Text(
                "Sign in to store",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 20.0,
                    fontFamily: "FiraCode",
                    fontWeight: FontWeight.bold),
              ),
            ),
            Visibility(
                visible: _formError,
                child: Container(
                  padding: EdgeInsets.all(7),
                  margin: EdgeInsets.symmetric(vertical: 20, horizontal: 20.0),
                  decoration: BoxDecoration(
                    color: Color.fromRGBO(95, 135, 161, 0.6),
                    border: Border.all(
                        color: Color.fromRGBO(243, 98, 98, 1.0),
                        width: 2.0,
                        style: BorderStyle.solid),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Text("Incorrect email or password",
                          style: TextStyle(color: Colors.white, fontSize: 20)),
                      IconButton(
                        icon: Icon(Icons.close,
                            color: Color.fromRGBO(243, 98, 98, 1.0)),
                        onPressed: () {
                          setState(() {
                            _formError = false;
                          });
                        },
                      )
                    ],
                  ),
                )),
            Container(
              decoration: BoxDecoration(
                  color: Color.fromRGBO(95, 135, 161, 0.6),
                  borderRadius: BorderRadius.circular(10)),
              padding: EdgeInsets.all(10),
              margin: EdgeInsets.symmetric(vertical: 10, horizontal: 20.0),
              child: FormBuilderTextField(
                name: "email",
                key: _emailFieldKey,
                style: TextStyle(color: Colors.white),
                decoration: InputDecoration(
                    icon: Icon(
                      Icons.email,
                      color: Colors.white,
                    ),
                    enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                            color: Color.fromRGBO(140, 201, 238, 0.6),
                            width: 2.0,
                            style: BorderStyle.solid)),
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: Color.fromRGBO(140, 201, 238, 0.6),
                            width: 2.0,
                            style: BorderStyle.solid)),
                    errorBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                            color: Color.fromRGBO(243, 98, 98, 1.0),
                            width: 2.0,
                            style: BorderStyle.solid)),
                    focusedErrorBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: Color.fromRGBO(243, 98, 98, 1.0),
                            style: BorderStyle.solid)),
                    labelText: "Email",
                    labelStyle: TextStyle(
                      color: Colors.white,
                      fontFamily: "FiraCode",
                    )),
                validator: FormBuilderValidators.compose([
                  FormBuilderValidators.required(),
                  FormBuilderValidators.email()
                ]),
                autovalidateMode: AutovalidateMode.onUserInteraction,
              ),
            ),
            Container(
              decoration: BoxDecoration(
                  color: Color.fromRGBO(95, 135, 161, 0.6),
                  borderRadius: BorderRadius.circular(10)),
              padding: EdgeInsets.all(10),
              margin: EdgeInsets.symmetric(vertical: 10, horizontal: 20.0),
              child: FormBuilderTextField(
                name: "password",
                key: _passwordFieldKey,
                obscureText: true,
                style: TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  icon: Icon(
                    Icons.password_outlined,
                    color: Colors.white,
                  ),
                  enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                          color: Color.fromRGBO(140, 201, 238, 0.6),
                          width: 2.0,
                          style: BorderStyle.solid)),
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          color: Color.fromRGBO(140, 201, 238, 0.6),
                          width: 2.0,
                          style: BorderStyle.solid)),
                  errorBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                          color: Color.fromRGBO(243, 98, 98, 1.0),
                          width: 2.0,
                          style: BorderStyle.solid)),
                  focusedErrorBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          color: Color.fromRGBO(243, 98, 98, 1.0),
                          style: BorderStyle.solid)),
                  labelText: "Password",
                  labelStyle: TextStyle(
                    color: Colors.white,
                    fontFamily: "FiraCode",
                  ),
                ),
                validator: FormBuilderValidators.required(),
                autovalidateMode: AutovalidateMode.onUserInteraction,
              ),
            ),
            Container(
              width: double.infinity,
              margin: EdgeInsets.symmetric(horizontal: 20.0),
              child: Directionality(
                textDirection: TextDirection.rtl,
                child: ElevatedButton.icon(
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      UserLoginDto userLoginDto = UserLoginDto(
                          email: _emailFieldKey.currentState!.value,
                          password: _passwordFieldKey.currentState!.value);
                      Dio dio = DioService.withoutToken;
                      Response response =
                          await dio.post("/login", data: userLoginDto.toJson());
                      if (200 == response.statusCode) {
                        String role = response.data["ROLE"];
                        String token = response.data["token"];
                        SecureStorageService secureStorageService =
                            SecureStorageService.getInstance;
                        await secureStorageService.set(
                            key: "ROLE", value: role);
                        await secureStorageService.set(
                            key: "token", value: token);
                        if (mounted) {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) {
                              return const SecondScreen(
                                pagesIndex: 0,
                              );
                            }),
                          );
                        }
                      }
                    }
                  },
                  icon: Icon(
                    Icons.login,
                    color: Colors.white,
                  ),
                  label: Text(
                    "Sign in",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontFamily: "FiraCode",
                        fontWeight: FontWeight.bold),
                  ),
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(vertical: 15.0),
                    primary: Color.fromRGBO(95, 135, 161,
                        0.9), //Color.fromRGBO(120, 184, 224, 0.9),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
