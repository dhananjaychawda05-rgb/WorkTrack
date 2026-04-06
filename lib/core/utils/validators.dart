class Validators {
  static String? validateEmail(String? value) {
    value = value?.trim();

    if (value == null || value.isEmpty) {
      return 'Please enter your email address';
    }

    final generalEmailRegex = RegExp(
      r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?)*$"
    );

    if (!generalEmailRegex.hasMatch(value)) {
      return 'Please enter a valid email address';
    }

    return null;
  }

  static String? validatePassword(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Please enter your password';
    }
    if (value.length < 8 || value.length > 32) {
      return 'Password must be between 8 to 32 characters';
    }
    if (!RegExp(r'[A-Z]').hasMatch(value)) {
      return 'Password must contain at least one uppercase letter';
    }
    if (!RegExp(r'[a-z]').hasMatch(value)) {
      return 'Password must contain at least one lowercase letter';
    }
    if (!RegExp(r'[0-9]').hasMatch(value)) {
      return 'Password must contain at least one number';
    }
    if (!RegExp(r'[!@#\$&*~`%^_+=\[\]{}();:,.<>/?|\\-]').hasMatch(value)) {
      return 'Password must contain at least one special character';
    }
    return null;
  }

  static String? validateConfirmPassword(
      {required String? value, required String? password}) {
    if (value == null || value.trim().isEmpty) {
      return 'Please confirm your password';
    }
    if (value != password) {
      return 'Passwords do not match';
    }
    return null;
  }

  static String? validateNotEmpty(String? value,
      {String? message, String? fieldName}) {
    if (value == null || value.trim().isEmpty) {
      if (message != null) {
        return message;
      }
      return 'Please enter your ${fieldName ?? 'value'}';
    }
    return null;
  }

  static String? validateUserName(String? value, {bool isExist = false}) {
    if (value == null || value.trim().isEmpty) {
      return 'Please enter your user name';
    }

    final userId = value.trim();

    if (userId.length < 4 || userId.length > 20) {
      return 'User name must be between 4 to 20 characters';
    }

    final regex = RegExp(r'^[a-zA-Z0-9_.]+$');
    if (!regex.hasMatch(userId)) {
      return 'User name can contain only letters, numbers, "_" and "."';
    }

    if (userId.startsWith('_') ||
        userId.startsWith('.') ||
        userId.endsWith('_') ||
        userId.endsWith('.')) {
      return 'User name cannot start or end with "_" or "."';
    }

    if (isExist) {
      return 'This username is already taken';
    }

    return null;
  }

  static String? validateNumberOnly(String? value,
      {String fieldName = "field", String? message}) {
    value = value?.trim();

    if (value == null || value.isEmpty) {
      if (message != null) {
        return message;
      }
      return 'Please enter your $fieldName';
    }

    final numberRegex = RegExp(r'^[0-9]+$');
    if (!numberRegex.hasMatch(value)) {
      return 'Please enter only numbers';
    }

    return null;
  }

  static String? validateFullName(String? value,
      {String fieldName = "full name"}) {
    value = value?.trim();

    // Check for empty input
    if (value == null || value.isEmpty) {
      return 'Please enter your $fieldName';
    }

    // Check for minimum length
    if (value.length < 3) {
      return 'Please enter a valid $fieldName';
    }

    // Allow alphabets (both cases) and spaces only — no digits or symbols
    final regex = RegExp(r'^[a-zA-Z]+(?: [a-zA-Z]+)*$');
    if (!regex.hasMatch(value)) {
      return 'Field $fieldName can only contain letters and spaces.';
    }

    // Check if there are at least two words
    if (!value.contains(' ')) {
      return 'Please enter full name (first and last name).';
    }

    return null;
  }

  static String? validatePhoneNumber(String? value,
      {String fieldName = "Phone Number"}) {
    value = value?.trim();

    // Check for empty input
    if (value == null || value.isEmpty) {
      return 'Please enter your $fieldName';
    }

    // Basic numeric validation
    final numericRegex = RegExp(r'^[0-9]+$');
    if (!numericRegex.hasMatch(value)) {
      return '$fieldName can only contain digits.';
    }

    // Length check (common for international numbers)
    if (value.length < 7 || value.length > 15) {
      return 'Please enter a valid $fieldName between 7 and 15 digits.';
    }

    return null;
  }

}
