import 'package:flutter/material.dart';

class AuthFields extends StatefulWidget {
  final String hintText;
  final TextInputType keyboardType;
  final TextInputAction textInputAction;
  final IconData prefixIcon;
  final String caption;
  final TextEditingController controller;

  const AuthFields({
    Key? key,
    required this.hintText,
    required this.keyboardType,
    required this.textInputAction,
    required this.prefixIcon,
    required this.caption,
    required this.controller,
  }) : super(key: key);

  @override
  _AuthFieldsState createState() => _AuthFieldsState();
}

class _AuthFieldsState extends State<AuthFields> {
  bool _isPasswordVisible = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (widget.caption.isNotEmpty)
            Padding(
              padding: const EdgeInsets.only(top: 4.0),
              child: Text(
                widget.caption,
                style: const TextStyle(
                  fontSize: 14,
                  color: Colors.black,
                ),
              ),
            ),
          const SizedBox(
            height: 5,
          ),
          TextField(
            style: const TextStyle(color: Colors.black),
            controller: widget.controller,
            decoration: InputDecoration(
// contentPadding: EdgeInsets.only(left: 16,top: 12,right: 20,bottom: 60),
              hintText: widget.hintText,
              hintStyle: const TextStyle(color: Colors.grey),
              prefixIcon: Icon(
                widget.prefixIcon,
                color: Colors.grey,
              ),
              suffixIcon: widget.keyboardType == TextInputType.visiblePassword
                  ? IconButton(
                      splashRadius: 1,
                      icon: Icon(
                        _isPasswordVisible
                            ? Icons.visibility
                            : Icons.visibility_off,
                        color: Colors.grey,
                      ),
                      onPressed: () {
                        setState(() {
                          _isPasswordVisible = !_isPasswordVisible;
                        });
                      },
                    )
                  : null,
              enabledBorder: OutlineInputBorder(
                borderSide: const BorderSide(color: Colors.grey, width: 1),
                borderRadius: BorderRadius.circular(16),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: const BorderSide(color: Colors.grey, width: 1),
                borderRadius: BorderRadius.circular(16),
              ),
              errorBorder: OutlineInputBorder(
                borderSide: const BorderSide(color: Colors.red, width: 1),
                borderRadius: BorderRadius.circular(16),
              ),
              border: OutlineInputBorder(
                borderSide: const BorderSide(color: Colors.grey, width: 1),
                borderRadius: BorderRadius.circular(16),
              ),
// filled: true,
// fillColor: Colors.black12,
            ),
            keyboardType: widget.keyboardType,
            textInputAction: widget.textInputAction,
            obscureText: widget.keyboardType == TextInputType.visiblePassword
                ? !_isPasswordVisible
                : false,
          ),
        ],
      ),
    );
  }
}
