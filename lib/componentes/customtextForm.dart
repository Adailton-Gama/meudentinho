import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class CustomTextForm extends StatefulWidget {
  final bool isSecret;
  final String label;
  final IconData icon;
  final TextInputType keyType;
  final List<TextInputFormatter>? maskType;
  final TextEditingController controller;
  const CustomTextForm({
    Key? key,
    required this.icon,
    required this.label,
    this.isSecret = false,
    this.maskType,
    this.keyType = TextInputType.name,
    required this.controller,
  }) : super(key: key);

  @override
  State<CustomTextForm> createState() => _CustomTextFormState();
}

class _CustomTextFormState extends State<CustomTextForm> {
  bool isObscure = false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    isObscure = widget.isSecret;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15),
      child: Form(
        child: TextFormField(
          autovalidateMode: AutovalidateMode.onUserInteraction,
          controller: widget.controller,
          keyboardType: widget.keyType,
          inputFormatters: widget.maskType,
          textInputAction: TextInputAction.next,
          obscureText: isObscure,
          validator: (value) {
            if (widget.label == 'E-mail') {
              if (value == null ||
                  value.isEmpty ||
                  value.contains(' ') == true ||
                  value.contains('@') == false ||
                  value.contains('.com') == false) {
                widget.controller.text.replaceAll(' ', '');
                return 'Favor Corrigir o e-mail';
              }
            } else if (widget.label == 'Senha') {
              if (value != null && value.length < 6) {
                return 'Senha menor que 6 Caracteres!';
              }
            } else if (widget.label == 'Nome Completo') {
              if (value != null && value.length < 10) {
                return 'Por Favor Digitar o nome completo!';
              }
            } else if (widget.label == 'Nascimento') {
              if (value != null && value.length < 10) {
                return 'Por Favor Digitar a Data Completa!';
              }
            } else if (widget.label == 'Celular') {
              if (value != null && value.length < 15) {
                return 'Por Favor Digitar o telefone corretamente!';
              }
            } else if (widget.label == 'CPF') {
              if (value != null && value.length < 14) {
                return 'Por Favor Digitar o nome completo!';
              }
            } else if (widget.label == 'Data de Nascimento') {
              if (value != null && value.length < 10) {
                return 'Por Favor data de nascimento completa!';
              }
            } else if (widget.label == 'Endereço') {
              if (value != null && value.length < 15) {
                return 'Favor Digitar endereço completo!';
              }
            }
          },
          decoration: InputDecoration(
            suffixIcon: widget.isSecret
                ? IconButton(
                    onPressed: () {
                      setState(() {
                        isObscure = !isObscure;
                      });
                    },
                    icon: isObscure
                        ? Icon(Icons.visibility)
                        : Icon(Icons.visibility_off),
                  )
                : null,
            label: Text(widget.label),
            prefixIcon: Icon(widget.icon),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
            ),
          ),
        ),
      ),
    );
  }
}
