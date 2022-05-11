
// ignore_for_file: non_constant_identifier_names


class Servicee {

  String? service_title = '', service_des = '', service_area = '' ,service_price = '0',deadline = '10',created_by = '',service_id = '';
  List<dynamic>? titleAsList ;

  Servicee({
    this.service_title,
    this.service_des,
    this.service_area,
    this.service_price,
    this.deadline,
    this.titleAsList,
    this.created_by,
    this.service_id,
});

  Servicee.fromDoc(Map<String, dynamic> doc) {
    service_title = doc['service_title'];
    service_des = doc['service_des'];
    service_area = doc['service_area'];
    service_price = doc['service_price'];
    deadline = doc['deadline'];
    titleAsList = doc['titleAsList'];
    created_by = doc['created_by'];
    service_id = doc['service_id'];

  }
}