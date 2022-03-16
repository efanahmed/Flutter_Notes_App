import 'package:flutter/material.dart';

class ModelClass {
  static nameTextField(
    var _name,
  ) {
    return Container(
      child: TextFormField(
        decoration: InputDecoration(
          border: InputBorder.none,
          prefixIcon: const Icon(
            Icons.person,
            color: Colors.grey,
            //size: 25,
          ),
          label: Text(
            '$_name',
            style: const TextStyle(
              fontSize: 16,
              color: Colors.grey,
            ),
          ),
        ),
      ),
    );
  }

  static submitButton(
    Widget name,
    Function()? onPressed,
  ) {
    return SizedBox(
      height: 50,
      width: double.infinity,
      child: Padding(
        padding: const EdgeInsets.only(left: 10, right: 10),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Colors.blue,
          ),
          child: FlatButton(
              onPressed: onPressed,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              child: name),
        ),
      ),
    );
  }
}