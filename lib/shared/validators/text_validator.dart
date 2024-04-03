class Validators {
  String? isEmpty(String? value) {
    if (value == null || value.isEmpty) {
      return 'Campo obrigatorio';
    }
    return null;
  }

  String? email(String email) {
    if (RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(email)) {
      return null;
    } else {
      return 'Esse e-mail não e valido';
    }
  }

  String? validatePassword(
    String value,
  ) {
    if (value.length < 6) {
      return 'A senha deve conter mais que 6 caracteres';
    }

    if (!RegExp('^(?=.*?[A-Z])').hasMatch(value)) {
      return 'Deve conter pelo menos um caractere maiúsculo';
    }
    if (!RegExp('^(?=.*?[a-z])').hasMatch(value)) {
      return 'Deve conter pelo menos um caractere minúsculo';
    }
    if (!RegExp('^(?=.*?[0-9])').hasMatch(value)) {
      return 'Deve conter pelo menos um número';
    }
    if (!RegExp(r'^(?=.*?[!@#\$&*~])').hasMatch(value)) {
      return 'Deve conter pelo menos um caractere especial';
    }

    return null;
  }
}
