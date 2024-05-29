class User {
  String? id;
  String name;
  String email;
  String gender;
  String type;

  User({
    this.id,
    required this.name,
    required this.email,
    required this.gender,
    required this.type,
  });

  factory User.fromJson(Map<String, dynamic> data) {
    return User(
        id: data['id'],
        name: data['name'],
        email: data['email'],
        gender: data['gender'],
        type: data['type']);
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'gender': gender,
      'type': type,
    };
  }
}

class Tutor extends User {
  String bio;
  String education;
  String experience;

  Tutor({
    super.id,
    required super.name,
    required super.email,
    required super.gender,
    required super.type,
    required this.bio,
    required this.education,
    required this.experience,
  });

  factory Tutor.fromJson(Map<String, dynamic> data) {
    return Tutor(
      id: data['id'],
      name: data['name'],
      email: data['email'],
      gender: data['gender'],
      type: data['type'],
      bio: data['bio'],
      education: data['education'],
      experience: data['experience'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'gender': gender,
      'type': type,
      'bio': bio,
      'education': education,
      'experience': experience,
    };
  }
}

class Student extends User {
  String bio;
  String grade;
  int age;
  String strengths;
  String weaknesses;
  double budget;

  Student({
    super.id,
    required super.name,
    required super.email,
    required super.gender,
    required super.type,
    required this.bio,
    required this.grade,
    required this.age,
    required this.strengths,
    required this.weaknesses,
    required this.budget,
  });

  factory Student.fromJson(Map<String, dynamic> data) {
    return Student(
      id: data['id'],
      name: data['name'],
      email: data['email'],
      gender: data['gender'],
      type: data['type'],
      bio: data['bio'],
      grade: data['grade'],
      age: data['age'],
      strengths: data['strengths'],
      weaknesses: data['weaknesses'],
      budget: data['budget'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'gender': gender,
      'type': type,
      'bio': bio,
      'grade': grade,
      'age': age,
      'strengths': strengths,
      'weaknesses': weaknesses,
      'budget': budget,
    };
  }
}
