
class Medicine {
    final String drugNumber;
    final String manufacturer;
    final String manufacturedIn;
    final String mfgDate;
    final String expDate;
    final String dose;
    final String composition;
    final String name;
    final String bn;
    final String isSoldOut;
    final String mrp;
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
    factory Medicine.fromJson(Map<String, dynamic> json){
      return Medicine(
         drugNumber: json['drugNumber'],
         manufacturer: json['manufacturer'],
         manufacturedIn: json['manufacturedIn'],
         mfgDate: json['mfgDate'],
         expDate: json['expDate'],
         dose: json['dose'],
         composition: json['composition'],
         name: json['name'],
         bn: json['bn'],
         isSoldOut: json['isSoldOut'],
         mrp: json['mrp'],
         );
    }

}