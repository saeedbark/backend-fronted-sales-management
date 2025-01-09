class RegisterModel {
  final String name;
  final String email;
  final String password;
  final String phone; // Add phone field

  RegisterModel({
    required this.name,
    required this.email,
    required this.password,
    required this.phone, // Add phone field
  });

  // Convert JSON to RegisterModel
  factory RegisterModel.fromJson(Map<String, dynamic> json) {
    return RegisterModel(
      name: json['name'],
      email: json['email'],
      password: json['password'],
      phone: json['phone'], // Add phone field
    );
  }

  // Convert RegisterModel to JSON
  Map<String, dynamic> toJson() => {
    "name": name,
    "email": email,
    "password": password,
    "phone": phone, // Add phone field
  };
}