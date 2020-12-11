import 'dart:convert';

List<Medicine> medicineFromJson(String str) => List<Medicine>.from(json.decode(str).map((x) => Medicine.fromJson(x)));

String medicineToJson(List<Medicine> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Medicine {
    Medicine({
        this.drugNumber,
        this.manufacturer,
        this.manufacturedIn,
        this.mfgDate,
        this.expDate,
        this.dose,
        this.composition,
        this.name,
        this.bn,
        this.isSoldOut,
        this.mrp,
    });

    String drugNumber;
    String manufacturer;
    String manufacturedIn;
    String mfgDate;
    String expDate;
    String dose;
    String composition;
    String name;
    String bn;
    String isSoldOut;
    String mrp;

    factory Medicine.fromJson(Map<String, dynamic> json) => Medicine(
        drugNumber: json["drugNumber"],
        manufacturer: json["manufacturer"],
        manufacturedIn: json["manufacturedIn"],
        mfgDate: json["mfgDate"],
        expDate: json["expDate"],
        dose: json["dose"],
        composition: json["composition"],
        name: json["name"],
        bn: json["bn"],
        isSoldOut: json["isSoldOut"],
        mrp: json["mrp"],
    );

    Map<String, dynamic> toJson() => {
        "drugNumber": drugNumber,
        "manufacturer": manufacturer,
        "manufacturedIn": manufacturedIn,
        "mfgDate": mfgDate,
        "expDate": expDate,
        "dose": dose,
        "composition": composition,
        "name": name,
        "bn": bn,
        "isSoldOut": isSoldOut,
        "mrp": mrp,
    };
}
