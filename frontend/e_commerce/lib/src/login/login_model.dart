

class LoginModel {
  final int id;
  final String name;
  final String email;
  final String phone;
  final String image;
  final double points;
  final double credit;
  final String token;

  LoginModel({
    required this.id,
    required this.name,
    required this.email,
    required this.phone,
    required this.image,
    required this.points,
    required this.credit,
    required this.token,
  });

  factory LoginModel.fromJson(Map<String, dynamic> json) {
    return LoginModel(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      phone: json['phone'],
      image: json['image'],
      points: json['points']?.toDouble() ?? 0.0,
      credit: json['credit']?.toDouble() ?? 0.0,
      token: json['token'],
    );
  }

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "email": email,
    "phone": phone,
    "image": image,
    "points": points,
    "credit": credit,
    "token": token,
  };
}