String? validateFirstName(String? value) {
  if (value!.isEmpty) {
    return "First name is required";
  } else {
    return null;
  }
}

String? validateLastName(String? value) {
  if (value!.isEmpty) {
    return "Last Name is required";
  } else {
    return null;
  }
}

String? validateMobile(String? value) {
  String pattern = r'(^\+?[0-9]*$)';
  RegExp regExp = RegExp(pattern);
  if (value!.isEmpty) {
    return "Phone number is required";
  } else {
    if (!regExp.hasMatch(value)) {
      return "Mobile number must a digit";
    } else if (value.length < 11 || value.length > 11) {
      return "Not a valid phone number";
    } else {
      return null;
    }
  }
}

String? validatePasword(String? value) {
  if (value!.length < 6) {
    return "Password must have atleast 5 character";
  } else {
    return null;
  }
}

String? validateConfirmPassword(String? value, String? confirmPassword) {
  if (value != confirmPassword) {
    return "password does not match";
  } else if (confirmPassword!.isEmpty) {
    return "Confirm password required";
  } else {
    return null;
  }
}

String? validateEmail(String? value) {
  String pattern =
      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
  RegExp regex = RegExp(pattern);

  if (value!.isEmpty) {
    return "Email is required";
  } else if (!regex.hasMatch(pattern)) {
    return "Enter a valid email address";
  } else {
    return null;
  }
}
