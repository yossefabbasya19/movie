import 'Data.dart';

class MovieDetailsDm {
  MovieDetailsDm({
      this.status, 
      this.statusMessage, 
      this.data, 
  });

  MovieDetailsDm.fromJson(dynamic json) {
    status = json['status'];
    statusMessage = json['status_message'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }
  String? status;
  String? statusMessage;
  Data? data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = status;
    map['status_message'] = statusMessage;
    if (data != null) {
      map['data'] = data?.toJson();
    }
    return map;
  }

}