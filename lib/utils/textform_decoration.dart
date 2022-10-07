import 'package:flutter/material.dart';
import 'package:weatherx/utils/text_styles.dart';

kTextFormDecoration({String labelText, String hint, suffixIcon, prefixIcon}) =>
    InputDecoration(
      fillColor: Colors.grey,
      filled: true,
      focusColor: Colors.grey,
      hoverColor: Colors.grey,
      labelText: labelText,
      hintText: hint,
      suffixIcon: suffixIcon,
      prefixIcon: prefixIcon,
      hintStyle: h5,
      labelStyle: h5,
      contentPadding: EdgeInsets.all(15),
      focusedBorder: new OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: new BorderSide(color: Colors.grey[300], width: 0.7),
      ),
      enabledBorder: new OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: new BorderSide(color: Colors.grey[300], width: 0.7),
      ),
      errorBorder: new OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: new BorderSide(color: Colors.grey[300], width: 0.7),
      ),
      focusedErrorBorder: new OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: new BorderSide(color: Colors.grey[300], width: 0.7),
      ),
      border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: new BorderSide(color: Colors.grey[300], width: 0.7)),
    );
