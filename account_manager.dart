import 'package:shared_preferences/shared_preferences.dart';
import 'package:textfx/src/data/model/profile_model.dart';
import 'package:textfx/src/utils/JsonHelper.dart';

import 'data/model/payment_plan_model.dart';

class AccountManager {
  final String userModelKey = "userModelKey";
  final String tokenKey = "tokenKey";
  SharedPreferences prefs;
  static final AccountManager _instance = new AccountManager._internal();

  ///memory cache
  String token;
  ProfileModel profile;
  ProfileSetting setting;

  ///method to have singleton account manager object
  AccountManager._internal();

  factory AccountManager() {
    return _instance;
  }

  ///initialization for asynchronously getting sharedpreferences
  initSharedPreferences() async {
    prefs = await SharedPreferences.getInstance();
    return prefs;
  }

  ///methods for store and retrieve primitives from sharedpreferences
  setObjOnSharedPreferences(String key, String serializedObj) {
    var result = prefs.setString(key, serializedObj);
    return result;
  }

  getObjFromSharedPreferences(String key) {
    var result = prefs.getString(key);
    return result;
  }

  /// methods for user getter and setter
  saveProfile(ProfileModel profileModel) {
    this.profile = profileModel;
    setObjOnSharedPreferences(
        userModelKey, JsonHelper.objectToJsonString(profileModel));
  }

  saveSetting(ProfileSetting setting) {
    this.setting = setting;
    setObjOnSharedPreferences(
        userModelKey, JsonHelper.objectToJsonString(setting));
  }

  ProfileModel getProfile() {
    String serializedObj = getObjFromSharedPreferences(userModelKey);
    if (profile != null) {
      return profile;
    } else {
      return ProfileModel.fromJson(
          JsonHelper.getObjectMapFromJsonString(serializedObj));
    }
  }

  /// methods for token getter and setter
  String getToken() {
    if (token != null) {
      return token;
    } else {
      return getObjFromSharedPreferences(tokenKey);
    }
  }

  saveToken(String token) {
    this.token = token;
    setObjOnSharedPreferences(tokenKey, token);
  }

  bool isPremiumAccount() {
    if (profile != null && profile.isPremium != null) return profile.isPremium;
    return false;
  }

  PaymentPlanModel getPaymentPlan() {
    if (profile != null) return profile.paymentPlan;
    return null;
  }

  setPremiumAccount(bool isPremium) {
    if (profile != null) {
      profile.isPremium = isPremium;
    }
  }

  setPaymentPlan(PaymentPlanModel paymentPlan) {
    if (profile != null) {
      profile.paymentPlan = paymentPlan;
    }
  }

  canShowSubscribe() {
    return setting != null ? (setting.payment ?? true) : true;
  }

  void logout() {
    profile = null;
    prefs.clear();
    token = null;
  }
}
