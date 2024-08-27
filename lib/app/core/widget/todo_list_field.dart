import 'package:flutter/material.dart';

class TodoListField extends StatelessWidget {
  final String label;
  final IconButton? suffixIconButton;
  final bool obscureText;
  final ValueNotifier<bool> obscureTextVN;
  final TextEditingController? controller;
  final FormFieldValidator<String>? validator;
  final FocusNode? focusNode;

  TodoListField({
    super.key,
    required this.label,
    this.obscureText = false,
    this.suffixIconButton,
    this.controller,
    this.validator,
    this.focusNode,
  })  : assert(obscureText ? suffixIconButton == null : true,
            "obscureText não pode ser enviado em conjunto com sufixIconButton"),
        obscureTextVN = ValueNotifier(obscureText);

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: obscureTextVN,
      builder: (_, obscureTextVNValue, child) {
        return TextFormField(
          controller: controller,
          validator: validator,
          focusNode: focusNode,
          decoration: InputDecoration(
            labelText: label,
            labelStyle: const TextStyle(fontSize: 15),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(color: Colors.red),
            ),
            isDense: true,
            suffixIcon: suffixIconButton ??
                (obscureText
                    ? IconButton(
                        onPressed: () {
                          obscureTextVN.value = !obscureTextVN.value;
                        },
                        icon: Icon(!obscureTextVNValue
                            ? Icons.visibility_off
                            : Icons.remove_red_eye),
                      )
                    : null),
          ),
          obscureText: obscureTextVNValue,
        );
      },
    );
  }
}
