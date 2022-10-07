class TransactionModel {
  late final int? id;
  late final String title;
  late final String description;
  late final int amount;
  late final String type;

  TransactionModel(
      {this.id,
      required this.title,
      required this.description,
      required this.amount,
      required this.type});

  TransactionModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    description = json['description'];
    amount = json['amount'];
    type = json['type'];
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'amount': amount,
      'type': type,
    };
  }
}
