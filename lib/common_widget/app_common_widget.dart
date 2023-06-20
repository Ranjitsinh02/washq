class AppCommonWidget {
  // Email validation
  bool isEmail(String emailId) {
    String email = emailId.trim();

    // String p = r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+";

    // RegExp regExp = RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
    RegExp emailRegex = RegExp(
      r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$',
      caseSensitive: false,
      multiLine: false,
    );

    if (emailRegex.hasMatch(email)) {
      return true;
    } else {
      return false;
    }

    // return  regExp.hasMatch(em);
  }

  //Password validation
  RegExp passwordValid =
      RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#$&*~]).{8,}$');

  bool validatePassword(String pass) {
    String password = pass.trim();
    if (passwordValid.hasMatch(password)) {
      return true;
    } else {
      return false;
    }
  }

  bool isValidPhoneNumber(String string) {
    // Null or empty string is invalid phone number
    if (string == null || string.isEmpty) {
      return false;
    }

    // You may need to change this pattern to fit your requirement.
    // I just copied the pattern from here: https://regexr.com/3c53v
    const pattern = r'^[+]*[(]{0,1}[0-9]{1,4}[)]{0,1}[-\s\./0-9]*$';
    final regExp = RegExp(pattern);

    if (!regExp.hasMatch(string)) {
      return false;
    }
    return true;
  }
/*
  RegExp mobileExp = RegExp(
      r'^\s*(?:\+?(\d{1,3}))?[-. (]*(\d{3})[-. )]*(\d{3})[-. ]*(\d{4})(?: *x(\d+))?\s*$');

  bool validMobileNumber(String mobileNumber) {
    String mobile = mobileNumber.trim();
    if (mobileExp.hasMatch(mobile)) {
      return true;
    } else {
      return false;
    }
  }*/
}
