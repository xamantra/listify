import 'package:flutter/material.dart';

class CustomTextInput extends StatefulWidget {
  final String? value;
  final TextEditingController? controller;
  final String? hintText;
  final void Function(String)? onChanged;
  final Color? color;

  const CustomTextInput({
    Key? key,
    this.value,
    this.controller,
    this.hintText,
    this.onChanged,
    this.color,
  }) : super(key: key);

  @override
  _TextInputWidgetState createState() => _TextInputWidgetState();
}

class _TextInputWidgetState extends State<CustomTextInput> {
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    var underline = UnderlineInputBorder(borderSide: BorderSide(color: widget.color!));
    return TextFormField(
      key: Key(widget.value ?? ''),
      initialValue: widget.controller != null ? null : widget.value,
      controller: widget.controller,
      onChanged: widget.onChanged ?? (value) {},
      decoration: InputDecoration(
        hintText: widget.hintText ?? '',
        hintStyle: TextStyle(
          fontSize: 14,
          color: widget.color!.withOpacity(0.6),
        ),
        border: underline,
        enabledBorder: underline,
      ),
      style: TextStyle(
        fontSize: 14,
        color: widget.color,
      ),
    );
  }
}
