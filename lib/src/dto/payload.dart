import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:rave_flutter/src/common/rave_pay_initializer.dart';
import 'package:rave_flutter/src/common/rave_utils.dart';
import 'package:rave_flutter/src/common/strings.dart';
import 'package:rave_flutter/src/models/bank_model.dart';
import 'package:rave_flutter/src/models/sub_account.dart';

class Payload extends Equatable {
  String expiryMonth;
  String pbfPubKey;
  String ip;
  String lastName;
  String firstName;
  String currency;
  String country;
  String amount;
  String email;
  String expiryYear;
  String cvv;
  String deviceFingerprint;
  String cardNo;
  String paymentPlan;
  String network;
  String bvn;
  String voucher;
  bool isPreAuth;
  bool isUsBankCharge;
  String phoneNumber;
  String accountNumber;
  BankModel bank;
  String passCode;
  String txRef;
  Map<String, String> meta;
  List<SubAccount> subAccounts;
  String cardBIN;
  String pin;
  String suggestedAuth;
  String narration;

  Payload.initFrmInitializer(RavePayInitializer i)
      : this.amount = i.amount.toString(),
        this.currency = i.currency,
        this.country = i.country,
        this.email = i.email,
        this.firstName = i.fName,
        this.lastName = i.lName,
        this.txRef = i.txRef,
        this.meta = i.meta,
        this.subAccounts = i.subAccounts,
        this.isPreAuth = i.isPreAuth,
        this.pbfPubKey = i.publicKey;

  Payload(
      {@required this.expiryMonth,
      @required this.pbfPubKey,
      @required this.ip,
      @required this.lastName,
      @required this.firstName,
      @required this.amount,
      @required this.email,
      @required this.expiryYear,
      @required this.cvv,
      @required this.deviceFingerprint,
      @required this.cardNo,
      @required this.paymentPlan,
      @required this.network,
      @required this.bvn,
      @required this.voucher,
      @required this.phoneNumber,
      @required this.accountNumber,
      @required this.passCode,
      this.currency = Strings.ngn,
      this.country = Strings.ng,
      this.isPreAuth = false,
      this.isUsBankCharge = false,
      this.txRef,
      this.cardBIN});

  Map<String, dynamic> toCardJson() {
    var json = <String, dynamic>{
      "narration": narration,
      "expirymonth": expiryMonth,
      "PBFPubKey": pbfPubKey,
      "lastname": lastName,
      "firstname": firstName,
      "currency": currency,
      "country": country,
      "amount": amount,
      "email": email,
      "expiryyear": expiryYear,
      "cvv": cvv,
      "cardno": cardNo,
      "txRef": txRef,
    };

    putIfNotNull(map: json, key: "payment_plan", value: paymentPlan);

    putIfNotNull(
        map: json, key: "charge_type", value: isPreAuth ? "preauth" : null);

    if (meta == null) meta = {};
    meta["sdk"] = "flutter";
    json["meta"] = [
      for (var e in meta.entries) {"metaname": e.key, "metavalue": e.value}
    ];
    putIfNotNull(
        map: json,
        key: "subaccounts",
        value: subAccounts == null || subAccounts.isEmpty
            ? null
            : subAccounts.map((a) => a.toJson()).toList());

    return json;
  }
}
