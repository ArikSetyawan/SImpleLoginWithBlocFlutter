// To parse this JSON data, do
//
//     final interactionModel = interactionModelFromJson(jsonString);

import 'dart:convert';

InteractionModel interactionModelFromJson(String str) => InteractionModel.fromJson(json.decode(str));

String interactionModelToJson(InteractionModel data) => json.encode(data.toJson());

class InteractionModel {
    InteractionModel({
        required this.interactionId,
        required this.datetimePrint,
        required this.datetimeSql,
        required this.lat,
        required this.lng,
        this.interaction,
        this.visit,
    });

    String interactionId;
    DateTime datetimePrint;
    double datetimeSql;
    String lat;
    String lng;
    Interaction? interaction;
    Visit? visit;

    factory InteractionModel.fromJson(Map<String, dynamic> json) => InteractionModel(
        interactionId: json["InteractionID"],
        datetimePrint: DateTime.parse(json["datetime_print"]),
        datetimeSql: json["datetime_sql"].toDouble(),
        lat: json["lat"],
        lng: json["lng"],
        interaction: Interaction.fromJson(json["Interaction"]),
        visit: Visit.fromJson(json["Visit"]),
    );

    Map<String, dynamic> toJson() => {
        "InteractionID": interactionId,
        "datetime_print": datetimePrint.toIso8601String(),
        "datetime_sql": datetimeSql,
        "lat": lat,
        "lng": lng,
        "Interaction": interaction?.toJson(),
        "Visit": visit?.toJson(),
    };
}

class Interaction {
    Interaction({
        required this.nik,
        required this.email,
        required this.name,
        required this.password,
        required this.phone,
        required this.photo,
        required this.status,
        required this.tagid,
        required this.userId,
    });

    String email;
    int nik;
    String name;
    String password;
    int phone;
    String photo;
    String status;
    String tagid;
    int userId;

    factory Interaction.fromJson(Map<String, dynamic> json) => Interaction(
        email: json["Email"],
        nik: json["NIK"],
        name: json["Name"],
        password: json["Password"],
        phone: json["Phone"],
        photo: json["Photo"],
        status: json["Status"],
        tagid: json["Tagid"],
        userId: json["UserID"],
    );

    Map<String, dynamic> toJson() => {
        "Email": email,
        "NIK": nik,
        "Name": name,
        "Password": password,
        "Phone": phone,
        "Photo": photo,
        "Status": status,
        "Tagid": tagid,
        "UserID": userId,
    };
}

class Visit {
    Visit({
        required this.name,
        required this.lat,
        required this.lng,
        required this.macAddress,
    });

    String name;
    String lat;
    String lng;
    String macAddress;

    factory Visit.fromJson(Map<String, dynamic> json) => Visit(
        name: json["Name"],
        lat: json["lat"],
        lng: json["lng"],
        macAddress: json["mac_address"],
    );

    Map<String, dynamic> toJson() => {
        "Name": name,
        "lat": lat,
        "lng": lng,
        "mac_address": macAddress,
    };
}