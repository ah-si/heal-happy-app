String? isRequired(value) {
  if (value == null || value.isEmpty) {
    return 'Ce champ est requis';
  }
  return null;
}

String? isEmailValid(value) {
  if (value == null || value.trim().isEmpty) {
    return 'Ce champ est requis';
  } else if (!RegExp(
  r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
  .hasMatch(value)) {
    return 'Cet email est invalide';
  }
  return null;
}

String? isPasswordValid(value) {
  if (value == null || value.isEmpty) {
    return 'Ce champ est requis';
  } else if (value.length < 6) {
    return 'Le mot de passe doit faire 6 caractères minimum';
  }
  return null;
}
