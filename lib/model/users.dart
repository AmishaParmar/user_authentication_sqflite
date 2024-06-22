
class Users {
    final int? userId;
    final String userName;
    final String? userEmail;
    final String userPassword;

    Users({
         this.userId,
         required this.userName,
         this.userEmail,
        required this.userPassword,
    });

    factory Users.fromMap(Map<String, dynamic> json) => Users(
        userId: json["userId"],
        userName: json["userName"],
        userEmail: json["userEmail"],
        userPassword: json["userPassword"],
    );

    Map<String, dynamic> toMap() => {
        "userId": userId,
        "userName": userName,
        "userEmail": userEmail,
        "userPassword": userPassword,
    };
}
