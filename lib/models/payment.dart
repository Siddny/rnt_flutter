class Payments {
  int id;
  String tenant;
  int amountReceived;
  String datePaid;
  String monthPaidFor;
  String comments;

  Payments(
      this.id,
      this.tenant,
      this.amountReceived,
      this.datePaid,
      this.monthPaidFor,
      this.comments
      );
}

class NewPayment{
  String houseName;
}