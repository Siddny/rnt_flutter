class Payment {
  int id;
  final tenant;
  int amountReceived;
  String datePaid;
  String monthPaidFor;
  String comments;

  Payment(
      this.id,
      this.tenant,
      this.amountReceived,
      this.datePaid,
      this.monthPaidFor,
      this.comments
      );
}

class NewPayment{
  int tenant;
  int amountReceived;
  String datePaid;
  String monthPaidFor;
  String comments;
}