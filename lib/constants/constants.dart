import "package:flutter/material.dart";
import "package:intl/intl.dart";

// GLOBAL COLORS
const primaryColor = Color(0xFFF28F1E);
const secondaryColor = Color(0xFF358138);
const backgroundColor = Color(0xFFFFFFFF);
const fontColor = Color(0xFF222222);
const fontColor2 = Color(0xFF4F4F4F);
const hintColor = Color(0xFF828282);
const orangeColor = Color(0xFFF68833);
const navyColor = Color(0xFF12406A);
const disableButtonColor = Color(0xFFBDBDBD);
const double appBarFontSize = 18.0;
// currency format
var currencyFormatter = NumberFormat.simpleCurrency(locale: "id_ID");
var money = NumberFormat("###,###,###", "id_ID");
// date fotmat
var dateFormat = DateFormat("EEEE, d MMMM yyyy", "id_ID");
var dateFormatApi = DateFormat("yyyy-MM-dd HH:mm:ss");
