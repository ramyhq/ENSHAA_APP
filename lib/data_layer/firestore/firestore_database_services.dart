// ignore_for_file: non_constant_identifier_names

import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../Models/Request_model.dart';
import '../Models/Service_model.dart';

class DatabaseServices {
  final String? uid; // we will pass uid with Constructor as we will use it much
  DatabaseServices({this.uid});

  // FireStore collections references
  final CollectionReference Services_collection =
      FirebaseFirestore.instance.collection('Services');
  final CollectionReference Requests_Data_collection =
      FirebaseFirestore.instance.collection('Requests_Data');
  final CollectionReference Users_Data_collection =
      FirebaseFirestore.instance.collection('Users_Data');

  /// ### Users Section ###

  Future updateUserData(
    String? email,
    String? password,
    String? role,
  ) async {
    return await Users_Data_collection.doc(uid).set({
      'email': email,
      'password': password,
      'role': role,
    });
  }

  /// ### Services Section ###

  // add Service to Service collection
  Future AddServiceData({
    String? service_title,
    String? service_des,
    String? service_area,
    String? service_price,
    String? deadline,
    String? created_by,
    String? service_id,
    List<String>? titleAsList,
  }) async {
    return await Services_collection.doc(service_id).set({
      'service_title': service_title,
      'service_des': service_des,
      'service_area': service_area,
      'service_price': service_price,
      'deadline': deadline,
      'created_by': created_by,
      'service_id': service_id,
      'titleAsList': titleAsList
    });
  }

  // update Service in Service collection
  Future UpdateServiceData({
    String? service_title,
    String? service_des,
    String? service_area,
    String? service_price,
    String? deadline,
    String? created_by,
    String? service_id,
    List<String>? titleAsList,
  }) async {
    return await Services_collection.doc(service_id).update({
      'service_title': service_title,
      'service_des': service_des,
      'service_area': service_area,
      'service_price': service_price,
      'deadline': deadline,
      'created_by': created_by,
      'service_id': service_id,
      'titleAsList': titleAsList
    });
  }

  // delete Service from Service collection
  Future DeleteServiceData({
    String? service_id,
  }) async {
    return await Services_collection.doc(service_id).delete();
  }


  //  get one service // for later
  // Future getServiceById(String service_id) async {
  //   return await Services_collection.doc(service_id).get().then((snapshot) {
  //     return _ServiceDataFromSnapshot(snapshot);
  //   });
  // }



  // Service from DocumentSnapshot 
  // to convert DocumentSnapshot to service data (from DocumentSnapshot)
  Servicee? _ServiceDataFromDocumentSnapshot(DocumentSnapshot snapshot) {
    return Servicee(
      service_title: snapshot['service_title'],
      service_des: snapshot['service_des'],
      service_area: snapshot['service_area'],
      service_price: snapshot['service_price'],
      deadline: snapshot['deadline'],
      titleAsList: snapshot['titleAsList'],
      created_by: snapshot['created_by'],
      service_id: snapshot['service_id'],
      //mob: snapshot.get('mob') ,
      //signUPDate: snapshot['signUPDate'].toDate(),
    );
  }

  // Service list from QuerySnapshot for company home page Stream Provider
  List<Servicee>? _ServiceDataListFromSnapshot(QuerySnapshot? snapshot) {
    return snapshot!.docs.map((doc) {
      return Servicee(
        service_title: doc.get('service_title') ?? '',
        service_des: doc.get('service_des') ?? '',
        service_area: doc.get('service_area') ?? '',
        service_price: doc.get('service_price') ?? '',
        deadline: doc.get('deadline') ?? '',
        created_by: doc.get('created_by') ?? '',
        service_id: doc.get('service_id') ?? '',
        titleAsList: doc.get('titleAsList') ?? '',
      );
    }).toList();
  }

  

  // for testing Service list from QuerySnapshot for company home page Stream Provider
  List<Servicee>? _ServiceDataListFromSnapshot2(QuerySnapshot? snapshot) {
    return snapshot!.docs.map((doc) {
      return Servicee(
        service_title: doc.get('service_title') ?? '',
        service_des: doc.get('service_des') ?? '',
        service_area: doc.get('service_area') ?? '',
        service_price: doc.get('service_price') ?? '',
        deadline: doc.get('deadline') ?? '',
        created_by: doc.get('created_by') ?? '',
        service_id: doc.get('service_id') ?? '',
        titleAsList: doc.get('titleAsList') ?? [],
      );
    }).toList();
  }

  /// # Service Streams #
  // Stream<Service?> get ServiceDataFromDBU {
  //   return Services_collection.doc(uid).snapshots().map((service) =>
  //       _ServiceDataFromSnapshot(service));
  // }
  // Stream<Service?> ServiceDataFromDB(ServiceUid) {
  //   return  Services_collection.doc(ServiceUid).snapshots().map((doc) => Service.fromDoc(doc.data() as Map<String, dynamic>));
  // }
  // get stream of Services_collection and return List of Service Model #2
  Stream<List<Servicee>?> get ServicesDataList => Services_collection.snapshots()
      .map((service) => _ServiceDataListFromSnapshot(service));

  //for Filtering and search (Full search )
  // Stream<List<Service>?> ServicesDataList2(filterBy)  {
  //   return Services_collection.where('deadline',whereIn: [filterBy]).snapshots().map((service) => _ServiceDataListFromSnapshot2(service));
  // }
  //for Filtering and search level 2
  Stream<List<Servicee>?> ServicesDataList2(String filterBy) {
    return Services_collection.where("titleAsList",
            arrayContainsAny: [filterBy])
        .snapshots()
        .map((service) => _ServiceDataListFromSnapshot2(service));
  }

  // stream on one service
  // get one service
  Stream<Servicee?> getServiceById(String service_id,) {
    return Services_collection.doc(service_id).snapshots().map((snap){
      return _ServiceDataFromDocumentSnapshot(snap);
    } );
  }


  /// ### Request Section ###

  // add/update Request to Request collection
  Future updateRequestData({
    String? service_created_by,
    String? service_id,
    String? customer_name,
    String? customer_email,
    String? mob,
    String? service_area,
    String? customer_offer,
    String? deadline,
    bool? request_status,
    String? request_id,
  }) async {
    return await Requests_Data_collection.doc(request_id).set({
      'service_created_by': service_created_by,
      'service_id': service_id,
      'customer_name': customer_name,
      'customer_email': customer_email,
      'mob': mob,
      'service_area': service_area,
      'customer_offer': customer_offer,
      'deadline': deadline,
      'request_status': request_status,
      'request_id': request_id,
    });
  }

  // update Request Status in Request collection
  Future updateRequestStatus({
    String? request_id,
    bool? request_status,
  }) async {
    return await Requests_Data_collection.doc(request_id).update({
      'request_status': request_status,
    });

  }

  // delete Request from Service collection
  Future DeleteRequestData({
    String? request_id,
  }) async {
    return await Requests_Data_collection.doc(request_id).delete();
  }


  // to convert snapshot to Request data (from DocumentSnapshot)
  Request? _RequestDataFromSnapshot(DocumentSnapshot snapshot) {
    return Request(
      service_created_by: snapshot['service_created_by'],
      service_id: snapshot['service_id'],
      customer_name: snapshot['customer_name'],
      customer_email: snapshot['customer_email'],
      mob: snapshot['mob'],
      service_area: snapshot['service_area'],
      customer_offer: snapshot['customer_offer'],
      deadline: snapshot['deadline'],
      request_status: snapshot['request_status'],
      request_id: snapshot['request_id'],
      //mob: snapshot.get('mob') ,
      //signUPData: snapshot['signUPData'].toDate(),
    );
  }

  // Service list from snapshot for my Request page Stream Provider
  List<Request>? _RequestDataListFromSnapshot(QuerySnapshot? snapshot) {
    return snapshot!.docs.map((doc) {
      return Request(
          service_created_by: doc.get('service_created_by') ?? '',
          service_id: doc.get('service_id') ?? '',
          customer_name: doc.get('customer_name') ?? '',
          customer_email: doc.get('customer_email') ?? '',
          mob: doc.get('mob') ?? '',
          service_area: doc.get('service_area') ?? '',
          customer_offer: doc.get('customer_offer') ?? '',
          deadline: doc.get('deadline') ?? '',
          request_status: doc.get('request_status') ?? '',
          request_id: doc.get('request_id') ?? '');
    }).toList();
  }

  /// # Request Streams #

  // this is a stream of "every" doc in Requests collection
  Stream<List<Request>?> get RequestsDataList =>
      Requests_Data_collection.snapshots()
          .map((request) => _RequestDataListFromSnapshot(request));

  // this is a stream of "filteredBy one user" doc in Requests collection
  Stream<List<Request>?> RequestsDataListOnlyMyUser(String user_email) {
    return Requests_Data_collection.where('customer_email',isEqualTo: user_email)
    .snapshots().map((request) => _RequestDataListFromSnapshot(request));
  }

  Stream<List<Request>?> RequestsDataListForMySerivces(String user_email) {
    return Requests_Data_collection.where('service_created_by',isEqualTo: user_email)
        .snapshots().map((request) => _RequestDataListFromSnapshot(request));
  }

}
