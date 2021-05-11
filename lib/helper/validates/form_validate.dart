import 'package:get/get.dart';

kFieldLengthValidate({required int length, required String field}) {
  String? message;
  if (field != '' && field.length < length)
    message = 'field-at-least-$length-characters'.tr;
  else if (field == '') message = 'please-input-your-field'.tr;
  return message;
}
