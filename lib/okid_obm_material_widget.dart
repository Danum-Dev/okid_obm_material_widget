// ignore_for_file: must_be_immutable
library okid_obm_material_widget;

import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;

import 'commons/utils/currency_formater.dart';
import 'constants/constants.dart';
import 'models/timezone_response.dart';

// OBM FORM WIDGET
class ObmForm extends StatelessWidget {
  ObmForm({
    Key? key,
    this.controller,
    this.focusTo,
    this.focusNode,
    this.keyboardType,
    this.obscureText,
    this.suffixIcon,
    this.prefixIcon,
    this.textInputAction,
    this.validator,
    this.onChanged,
    this.labelText,
    this.hintText,
    this.autoFocus,
    this.maxLines,
    this.isCurrency,
    this.prefixText,
    this.enabled,
    this.lengthLimit,
  }) : super(key: key);
  TextEditingController? controller;
  FocusNode? focusTo;
  FocusNode? focusNode;
  TextInputType? keyboardType;
  bool? obscureText;
  Widget? suffixIcon;
  Widget? prefixIcon;
  TextInputAction? textInputAction;
  FormFieldValidator<String>? validator;
  ValueChanged<String>? onChanged;
  String? labelText;
  String? hintText;
  bool? autoFocus;
  int? maxLines;
  bool? isCurrency;
  String? prefixText;
  bool? enabled;
  int? lengthLimit;

  @override
  Widget build(BuildContext context) {
    isCurrency ??= false;
    return obscureText == null
        ? TextFormField(
            maxLengthEnforcement: MaxLengthEnforcement.enforced,
            maxLines: maxLines,
            maxLength: lengthLimit,
            focusNode: focusNode,
            controller: controller,
            keyboardType: keyboardType ?? TextInputType.text,
            validator: validator,
            autofocus: autoFocus ?? false,
            enabled: enabled ??= true,
            decoration: InputDecoration(
              counterText: '',
              fillColor: Colors.grey[100],
              filled: enabled == false ? true : false,
              floatingLabelBehavior: FloatingLabelBehavior.always,
              contentPadding: const EdgeInsets.symmetric(
                vertical: 10.0,
                horizontal: 20.0,
              ),
              labelText: labelText ?? 'Form',
              labelStyle: const TextStyle(
                color: fontColor,
                fontSize: 16.0,
                fontWeight: FontWeight.w400,
              ),
              hintText: hintText ?? 'Form',
              hintStyle: const TextStyle(
                color: Color(0xFF828282),
                fontSize: 16.0,
                fontWeight: FontWeight.w400,
                fontStyle: FontStyle.italic,
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
                borderSide: const BorderSide(color: Colors.grey),
              ),
              prefixIcon: prefixIcon,
              suffixIcon: suffixIcon ?? const SizedBox(),
              prefixText: prefixText,
              prefixStyle: const TextStyle(
                color: fontColor,
              ),
            ),
            onChanged: onChanged,
            textInputAction: textInputAction,
            onFieldSubmitted: (v) {
              focusTo != null
                  ? FocusScope.of(context).requestFocus(focusTo)
                  : null;
            },
            inputFormatters: isCurrency!
                ? [
                    FilteringTextInputFormatter.digitsOnly,
                    CurrencyFormatForm(),
                  ]
                : [],
          )
        : TextFormField(
            focusNode: focusNode,
            controller: controller,
            obscureText: obscureText ?? false,
            keyboardType: keyboardType ?? TextInputType.text,
            validator: validator,
            autofocus: autoFocus ?? false,
            decoration: InputDecoration(
              floatingLabelBehavior: FloatingLabelBehavior.always,
              contentPadding: const EdgeInsets.symmetric(
                vertical: 10.0,
                horizontal: 20.0,
              ),
              labelText: labelText ?? 'Form',
              labelStyle: const TextStyle(
                color: fontColor,
                fontSize: 16.0,
                fontWeight: FontWeight.w400,
              ),
              hintText: hintText ?? 'Form',
              hintStyle: const TextStyle(
                color: Color(0xFF828282),
                fontSize: 16.0,
                fontWeight: FontWeight.w400,
                fontStyle: FontStyle.italic,
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
                borderSide: const BorderSide(color: Colors.grey),
              ),
              suffixIcon: suffixIcon ?? const SizedBox(),
              prefixStyle: const TextStyle(color: fontColor),
            ),
            onChanged: onChanged,
            textInputAction: textInputAction,
            onFieldSubmitted: (v) {
              focusTo != null
                  ? FocusScope.of(context).requestFocus(focusTo)
                  : null;
            },
          );
  }
}

// OBM BUTTON WIDGET
class ObmButton extends StatelessWidget {
  const ObmButton({
    Key? key,
    this.buttonLabel,
    this.buttonColor,
    this.labelColor,
    this.labelSize,
    this.press,
    this.paddingButton,
    this.roundedButton,
    this.buttonWidth,
    this.btnBorderColor,
  }) : super(key: key);
  final String? buttonLabel;
  final Color? buttonColor;
  final Color? labelColor;
  final double? labelSize;
  final Function()? press;
  final double? paddingButton;
  final double? roundedButton;
  final double? buttonWidth;
  final Color? btnBorderColor;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: press,
      child: Container(
        width: buttonWidth ?? double.infinity,
        decoration: BoxDecoration(
          color: buttonColor == null ? Colors.white : buttonColor!,
          borderRadius: BorderRadius.all(
            Radius.circular(
              roundedButton == null ? 32.0 : roundedButton!,
            ),
          ),
          border: Border.all(
            color:
                btnBorderColor == null ? Colors.transparent : btnBorderColor!,
          ),
        ),
        child: Padding(
          padding: EdgeInsets.all(
            paddingButton == null ? 15.0 : paddingButton!,
          ),
          child: Text(
            buttonLabel!,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: labelColor == null ? Colors.white : labelColor!,
              fontSize: labelSize ?? 16,
            ),
          ),
        ),
      ),
    );
  }
}

// CHECK INTERNET CONNECTION METHODE
Future<bool> hasNetwork() async {
  try {
    final result = await InternetAddress.lookup('google.com');
    return result.isNotEmpty && result[0].rawAddress.isNotEmpty;
  } on SocketException catch (_) {
    return false;
  }
}

// GET DEVICE IP ADDRESS METHODE
Future<String?> getIpAddress() async {
  try {
    final url = Uri.parse('https://api.ipify.org');
    final response = await http.get(url);
    return response.statusCode == 200 ? response.body : null;
  } catch (error) {
    if (kDebugMode) {
      print(error);
    }
    return null;
  }
}

// GET DEVICE SCREEN SIZE METHODE
class ScreenSize {
  BuildContext context;
  ScreenSize(this.context);

  double get width => MediaQuery.of(context).size.width;
  double get height => MediaQuery.of(context).size.height;
}

// CHARACTER TRIMMER METHODE
Future<String> trim(RegExp inputRegExp, String inputString) async {
  RegExp charExp = inputRegExp;
  Iterable<RegExpMatch> matches = charExp.allMatches(inputString);
  return matches
      .map((e) => e.group(0))
      .toList()
      .toString()
      .replaceAll(',', '')
      .replaceAll(')', '')
      .replaceAll('(', '')
      .replaceAll(']', '')
      .replaceAll('[', '');
}

// GET TIME BY TIMEZONE METHODE
Future<TimezoneResponse?> getTimeZone(String? timeZone) async {
  var url = Uri.parse(
      'https://www.timeapi.io/api/TimeZone/zone?timeZone=${timeZone ?? "Asia/Jakarta"}');
  Map<String, String> headers = {
    'Accept': "jsonContentType",
  };
  try {
    final response = await http.get(url, headers: headers);
    var jsonResponse = jsonDecode(response.body);
    return TimezoneResponse.fromJson(jsonResponse);
  } catch (error) {
    if (kDebugMode) {
      print(error);
    }
    return null;
  }
}

// SCALE ROUTE ANIMATION
class ScaleRoute extends PageRouteBuilder {
  final Widget? page;
  ScaleRoute({this.page})
      : super(
          pageBuilder: (
            BuildContext context,
            Animation<double> animation,
            Animation<double> secondaryAnimation,
          ) =>
              page!,
          transitionsBuilder: (
            BuildContext context,
            Animation<double> animation,
            Animation<double> secondaryAnimation,
            Widget child,
          ) =>
              ScaleTransition(
            scale: Tween<double>(
              begin: 0.0,
              end: 1.0,
            ).animate(
              CurvedAnimation(
                parent: animation,
                curve: Curves.fastOutSlowIn,
              ),
            ),
            child: child,
          ),
        );
}

// SLIDE RIGHT ROUTE ANIMATION
class SlideRightRoute extends PageRouteBuilder {
  final Widget? page;
  SlideRightRoute({this.page})
      : super(
          pageBuilder: (
            BuildContext context,
            Animation<double> animation,
            Animation<double> secondaryAnimation,
          ) =>
              page!,
          transitionsBuilder: (
            BuildContext context,
            Animation<double> animation,
            Animation<double> secondaryAnimation,
            Widget child,
          ) =>
              SlideTransition(
            position: Tween<Offset>(
              begin: const Offset(-1, 0),
              end: Offset.zero,
            ).animate(animation),
            child: child,
          ),
        );
}

// ROTATION ROUTE ANIMATION
class RotationRoute extends PageRouteBuilder {
  final Widget? page;
  RotationRoute({this.page})
      : super(
          pageBuilder: (
            BuildContext context,
            Animation<double> animation,
            Animation<double> secondaryAnimation,
          ) =>
              page!,
          transitionDuration: const Duration(seconds: 1),
          transitionsBuilder: (
            BuildContext context,
            Animation<double> animation,
            Animation<double> secondaryAnimation,
            Widget child,
          ) =>
              RotationTransition(
            turns: Tween<double>(
              begin: 0.0,
              end: 1.0,
            ).animate(
              CurvedAnimation(
                parent: animation,
                curve: Curves.linear,
              ),
            ),
            child: child,
          ),
        );
}

// SIZE ROUTE ANIMATION
class SizeRoute extends PageRouteBuilder {
  final Widget? page;
  SizeRoute({this.page})
      : super(
          pageBuilder: (
            BuildContext context,
            Animation<double> animation,
            Animation<double> secondaryAnimation,
          ) =>
              page!,
          transitionsBuilder: (
            BuildContext context,
            Animation<double> animation,
            Animation<double> secondaryAnimation,
            Widget child,
          ) =>
              Align(
            child: SizeTransition(
              sizeFactor: animation,
              child: child,
            ),
          ),
        );
}

// FADE ROUTE ANIMATION
class FadeRoute extends PageRouteBuilder {
  final Widget? page;
  FadeRoute({this.page})
      : super(
          pageBuilder: (
            BuildContext context,
            Animation<double> animation,
            Animation<double> secondaryAnimation,
          ) =>
              page!,
          transitionsBuilder: (
            BuildContext context,
            Animation<double> animation,
            Animation<double> secondaryAnimation,
            Widget child,
          ) =>
              FadeTransition(
            opacity: animation,
            child: child,
          ),
        );
}
