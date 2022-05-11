// ignore_for_file: non_constant_identifier_names

class Request {
  String?
  service_created_by = '',
      service_id = '',
      customer_name = '',
      customer_email = '',
      mob = '',
      service_area = '',
      customer_offer = '0',
      deadline = '',
      request_id = '';
  bool request_status = false;

  Request({
    this.service_created_by,
    this.service_id,
    this.customer_name,
    this.customer_email,
    this.mob,
    this.service_area,
    this.customer_offer,
    this.deadline,
    this.request_status = false,
    this.request_id ,
  });

  // to convert firestore doc to Request model
  Request.fromDoc(Map<String, dynamic> doc) {
    service_created_by = doc['service_created_by'];
    service_id = doc['service_id'];
    customer_name = doc['customer_name'];
    customer_email = doc['customer_email'];
    mob = doc['mob'];
    service_area = doc['service_area'];
    customer_offer = doc['customer_offer'];
    deadline = doc['deadline'];
    request_status = doc['request_status'];
    request_id = doc['request_id'];
  }
}
