import 'package:cloud_firestore/cloud_firestore.dart';

extension CustomTimestamp on Timestamp {
  String filledZeros(int value, {int zeros = 2}) {
    return '${value.toString().padLeft(zeros, '0')}';
  }

  String getDateFormated() {
    return '${filledZeros(this.toDate().day)}/${filledZeros(this.toDate().month)}/${filledZeros(this.toDate().year)} ${filledZeros(this.toDate().hour)}:${filledZeros(this.toDate().minute)}';
  }
  String getHourFormated() {
    return '${filledZeros(this.toDate().hour)}:${filledZeros(this.toDate().minute)}';
  }
}
