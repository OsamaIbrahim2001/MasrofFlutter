// ignore_for_file: file_names

class Masrof {
  final int? id;
  final String operationDate;
  final double value;
  final String operationType;
  final String paymentType;
  final String reason;

  Masrof({
    this.id,
    required this.operationDate,
    required this.value,
    required this.operationType,
    required this.paymentType,
    required this.reason,
  });

  // Convert MasrofModel to Map
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'operationDate': operationDate,
      'value': value,
      'operationType': operationType,
      'paymentType': paymentType,
      'reason': reason,
    };
  }

  // Create MasrofModel from Map
  factory Masrof.fromMap(Map<String, dynamic> map) {
    return Masrof(
      id: map['id'],
      operationDate: map['operationDate'],
      value: map['value'],
      operationType: map['operationType'],
      paymentType: map['paymentType'],
      reason: map['reason'],
    );
  }
}
