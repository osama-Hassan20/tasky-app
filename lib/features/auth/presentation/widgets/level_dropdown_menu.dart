
import 'package:flutter/material.dart';

Widget levelDropdownMenu({
  required void Function(String?)? onChanged
})=>Padding(
  padding: const EdgeInsets.symmetric(horizontal: 10.0),
  child: SizedBox(
    width: 100,
    child: DropdownMenuItem(
      alignment: Alignment.centerRight,
      child: DropdownButton(
        underline: const SizedBox(),
        items: const [
          DropdownMenuItem(
            value: 'fresh',
            child: Text('fresh '),
          ),
          DropdownMenuItem(
            value: 'junior',
            child: Text('junior '),
          ),
          DropdownMenuItem(
            value: 'midLevel',
            child: Text('midLevel '),
          ),
          DropdownMenuItem(
            value: 'senior',
            child: Text('senior '),
          ),
        ],
        onChanged: onChanged,
      ),
    ),
  ),
);