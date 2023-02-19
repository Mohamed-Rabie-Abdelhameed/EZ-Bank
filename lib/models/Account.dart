class Account {
  final String? id;
  final String name;
  final String email;
  final String password;
  final DateTime dob;
  final double balance;
  final int accountNumber;

  Account(
      {
      this.id,
      required this.name,
      required this.email,
      required this.password,
      required this.dob,
      this.balance = 0,
      required this.accountNumber});

      toJson() {
        return {
          'name': name,
          'email': email,
          'dob': dob,
          'balance': balance,
          'accountNumber': accountNumber,
        };
      }
}


