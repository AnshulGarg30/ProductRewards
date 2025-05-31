String? validateRequired(String? value) {
  if (value == null || value.isEmpty) return 'This field is required';
  return null;
}

String? validateEmail(String? value) {
  if (value == null || value.isEmpty) return 'Email is required';
  final emailRegex = RegExp(r'^[^@]+@[^@]+\.[^@]+');
  if (!emailRegex.hasMatch(value)) return 'Enter a valid email';
  return null;
}

String? validatePassword(String? value) {
  if (value == null || value.isEmpty) return 'Password is required';
  if (value.length < 6) return 'Password must be at least 6 characters';
  return null;
}

String? validatePhoneNumber(String? value) {
  if (value == null || value.isEmpty) return 'Phone number is required';

  final RegExp regex = RegExp(r'^\+?\d{10,15}$');
  if (!regex.hasMatch(value)) return 'Enter a valid phone number';

  return null;
}

