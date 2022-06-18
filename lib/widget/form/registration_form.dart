import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:intl/intl.dart' as intl;
import 'package:test_val/dto/user_registration_dto.dart';
import 'package:test_val/service/dio_service.dart';

class RegistrationForm extends StatefulWidget {
  const RegistrationForm({Key? key}) : super(key: key);

  @override
  State<RegistrationForm> createState() => _RegistrationFormState();
}

class _RegistrationFormState extends State<RegistrationForm> {
  final GlobalKey<FormBuilderState> _formKey = GlobalKey();
  final GlobalKey<FormBuilderFieldState> _emailFieldKey = GlobalKey();
  final GlobalKey<FormBuilderFieldState> _firstNameFieldKey = GlobalKey();
  final GlobalKey<FormBuilderFieldState> _lastNameFieldKey = GlobalKey();
  final GlobalKey<FormBuilderFieldState> _passwordFieldKey = GlobalKey();
  final GlobalKey<FormBuilderFieldState> _dateOfBirthFieldKey = GlobalKey();
  final GlobalKey<FormBuilderFieldState> _acceptTermsKey = GlobalKey();
  bool _formError = false;
  bool _passwordObscured = true;

  @override
  Widget build(BuildContext context) {
    return FormBuilder(
      key: _formKey,
      child: Container(
        color: Color.fromRGBO(255, 255, 255, 0.05),
        //height: MediaQuery.of(context).size.height-MediaQuery.of(context).padding.top-MediaQuery.of(context).padding.bottom,
        //width: MediaQuery.of(context).size.width-MediaQuery.of(context).padding.left-MediaQuery.of(context).padding.right,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              margin: EdgeInsets.symmetric(vertical: 20, horizontal: 20.0),
              child: Text(
                "Please enter your personal info",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 17.0,
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
                    labelStyle:
                        TextStyle(color: Colors.white, fontFamily: "FiraCode")),
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
                name: "firstName",
                key: _firstNameFieldKey,
                style: TextStyle(color: Colors.white),
                decoration: InputDecoration(
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
                    labelText: "First name",
                    labelStyle:
                        TextStyle(color: Colors.white, fontFamily: "FiraCode")),
                validator: FormBuilderValidators.required(),
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
                name: "lastName",
                key: _lastNameFieldKey,
                style: TextStyle(color: Colors.white),
                decoration: InputDecoration(
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
                    labelText: "Last name",
                    labelStyle:
                        TextStyle(color: Colors.white, fontFamily: "FiraCode")),
                validator: FormBuilderValidators.required(),
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
                obscureText: _passwordObscured,
                style: TextStyle(color: Colors.white),
                decoration: InputDecoration(
                    suffixIcon: IconButton(
                      icon: _passwordObscured
                          ? Icon(Icons.visibility_off)
                          : Icon(Icons.visibility),
                      onPressed: () {
                        setState(() {
                          _passwordObscured = !_passwordObscured;
                        });
                      },
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
                    labelStyle:
                        TextStyle(color: Colors.white, fontFamily: "FiraCode")),
                validator: FormBuilderValidators.required(),
                autovalidateMode: AutovalidateMode.onUserInteraction,
              ),
            ),
            Container(
              decoration: BoxDecoration(
                  color: Color.fromRGBO(95, 135, 161, 0.6),
                  borderRadius: BorderRadius.circular(10)),
              padding: EdgeInsets.all(10),
              margin: EdgeInsets.symmetric(vertical: 10, horizontal: 20.0),
              child: FormBuilderDateTimePicker(
                name: "dateOfBirth",
                key: _dateOfBirthFieldKey,
                inputType: InputType.date,
                format: intl.DateFormat("yyyy-MM-dd"),
                style: TextStyle(color: Colors.white),
                decoration: InputDecoration(
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
                    labelText: "Date of birth",
                    labelStyle:
                        TextStyle(color: Colors.white, fontFamily: "FiraCode")),
                validator: FormBuilderValidators.required(),
                autovalidateMode: AutovalidateMode.onUserInteraction,
              ),
            ),
            Container(
              decoration: BoxDecoration(
                  color: Color.fromRGBO(95, 135, 161, 0.6),
                  borderRadius: BorderRadius.circular(10)),
              padding: EdgeInsets.all(10),
              margin: EdgeInsets.symmetric(vertical: 10, horizontal: 20.0),
              child: Theme(
                data: ThemeData(
                    checkboxTheme: CheckboxThemeData(
                        side: BorderSide(
                            color: Color.fromRGBO(140, 201, 238, 0.6),
                            width: 2.0,
                            style: BorderStyle.solid))),
                child: FormBuilderCheckbox(
                  name: 'accept_terms',
                  key: _acceptTermsKey,
                  initialValue: false,
                  title: RichText(
                    text: const TextSpan(
                      children: [
                        TextSpan(
                          text: 'I have read and agree to the ',
                          style: TextStyle(
                              color: Colors.white,
                              fontFamily: "FiraCode",
                              fontWeight: FontWeight.bold),
                        ),
                        TextSpan(
                          text: 'Terms and Conditions',
                          style: TextStyle(
                              color: Color.fromRGBO(140, 201, 238, 1.0),
                              fontFamily: "FiraCode",
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                  activeColor: Color.fromRGBO(140, 201, 238, 0.6),
                  checkColor: Color.fromRGBO(140, 201, 238, 1.0),
                  validator: FormBuilderValidators.equal(
                    true,
                    errorText:
                        'You must accept terms and conditions to continue',
                  ),
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                ),
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
                      UserRegistrationDto userRegistrationDto =
                          UserRegistrationDto(
                              email: _emailFieldKey.currentState!.value,
                              firstName: _firstNameFieldKey.currentState!.value,
                              lastName: _lastNameFieldKey.currentState!.value,
                              password: _passwordFieldKey.currentState!.value,
                              birthDate: intl.DateFormat("yyyy-MM-dd").format(
                                  _dateOfBirthFieldKey.currentState!.value));
                      Dio dio = DioService.withoutToken;
                      Response response = await dio.post("/signup",
                          data: userRegistrationDto.toJson());
                      if (201 == response.statusCode) {
                        showGeneralDialog(
                          context: context,
                          barrierColor: Colors.black12.withOpacity(0.6),
                          barrierDismissible: false,
                          transitionDuration: Duration(milliseconds: 400),
                          pageBuilder: (_, __, ___) {
                            return Scaffold(
                              backgroundColor: Colors.transparent,
                              body: SafeArea(
                                child: Column(
                                  children: <Widget>[
                                    Expanded(
                                      child: Container(
                                        color:
                                            Color.fromRGBO(95, 135, 161, 0.6),
                                        width: double.infinity,
                                        child: Column(
                                          children: [
                                            Expanded(
                                                child: FittedBox(
                                              fit: BoxFit.fill,
                                              child: Icon(
                                                Icons.check_circle_outline,
                                                color: Color.fromRGBO(
                                                    140, 201, 238, 0.6),
                                              ),
                                            )),
                                            Expanded(
                                              child: Container(
                                                margin: EdgeInsets.symmetric(
                                                    vertical: 10),
                                                child: Text(
                                                  "SUCCESS",
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 20,
                                                      fontFamily: "FiraCode",
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      child: Container(
                                        width: double.infinity,
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 20),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          children: [
                                            Text(
                                              "Congratulations, your account\nhas been successfully craeted",
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 20,
                                                  fontFamily: "FiraCode",
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            SizedBox(
                                              width: double.infinity,
                                              child: ElevatedButton(
                                                style: ElevatedButton.styleFrom(
                                                  padding: EdgeInsets.symmetric(
                                                      vertical: 15.0),
                                                  primary: Color.fromRGBO(
                                                      95,
                                                      135,
                                                      161,
                                                      0.6), //Color.fromRGBO(120, 184, 224, 0.9),
                                                ),
                                                onPressed: () =>
                                                    Navigator.pop(context),
                                                child: Text(
                                                  "Continue",
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 20,
                                                      fontFamily: "FiraCode",
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        );
                      }
                    }
                  },
                  icon: Icon(
                    Icons.login,
                    color: Colors.white,
                  ),
                  label: Text(
                    "Sign up",
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
