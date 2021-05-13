import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:pks_mobile/constants/app_colors.dart';
import 'package:pks_mobile/constants/global_variable.dart';
import 'package:pks_mobile/helper/text-styles/simple_text.dart';
import 'package:pks_mobile/helper/text-styles/title_text.dart';
import 'package:pks_mobile/screens/drawers/subs/settings/personal_info/controller/personal_info_controller.dart';
import 'package:pks_mobile/size_config.dart';
import 'package:pks_mobile/widgets/app_background.dart';
import 'package:pks_mobile/widgets/field_update.dart';
import 'package:pks_mobile/widgets/profile_update.dart';
import 'package:pks_mobile/widgets/update_filed_list.dart';

class PersonalInfo extends GetView<PersonalInfoController> {
  @override
  Widget build(BuildContext context) {
    double defaultSize = SizeConfig.defaultSize!; //default size on this context

    return AppBackground(
      appBar: AppBar(
        centerTitle: true,
        title: TitleText(
          label: 'personal-info',
          color: kPrimaryColor,
        ),
      ),
      widget: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(defaultSize * 2),
          child: Column(
            children: [
              Container(
                decoration: BoxDecoration(
                  color: Colors.white60.withOpacity(.5),
                  borderRadius: BorderRadius.circular(8.0),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black12,
                      offset: Offset(0.0, 15.0),
                      blurRadius: 15.0,
                    ),
                    BoxShadow(
                      color: Colors.black12,
                      offset: Offset(0.0, -10.0),
                      blurRadius: 10.0,
                    )
                  ],
                ),
                child: Padding(
                  padding: EdgeInsets.all(defaultSize * 2),
                  //check before loading the form def null error
                  child: Obx(
                    () => kUserData.value != null
                        ? Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              ProfileUpdate(
                                onPressed: () {
                                  controller.updatePhotoURL();
                                },
                                photoURL: controller.photoURL.value,
                              ),
                              //Display name section
                              SimpleText(
                                label: 'display-name',
                                color: kPrimaryColor,
                                fontWeight: FontWeight.w600,
                              ),
                              ExpansionTile(
                                title: controller.displayName.value != ''
                                    ? SimpleText(
                                        label: controller.displayName.value,
                                        color: kPrimaryColor,
                                      )
                                    : SimpleText(
                                        label: 'empty-name',
                                        color: kPrimaryColor,
                                      ),
                                children: <Widget>[
                                  FieldUpdate(
                                    fromKey: controller.formKeyDisplayName,
                                    validate: ((value) =>
                                        controller.validateLength(
                                            field: value, length: 5)),
                                    textEditingController:
                                        controller.displayNameController,
                                    onSave: ((value) =>
                                        controller.displayName.value = value),
                                    hintText: 'change-to...',
                                    preIconData: Icons.info_outline,
                                    onPressed: () {
                                      controller.checkUpdateDisplayName();
                                    },
                                    sufIconData: Icons.done,
                                  ),
                                ],
                              ),
                              //Bio section
                              SimpleText(
                                label: 'bio',
                                color: kPrimaryColor,
                                fontWeight: FontWeight.w600,
                              ),
                              ExpansionTile(
                                title: controller.bio.value != ''
                                    ? SimpleText(
                                        label: controller.bio.value,
                                        color: kPrimaryColor,
                                      )
                                    : SimpleText(
                                        label: 'empty-bio',
                                        color: kPrimaryColor,
                                      ),
                                children: <Widget>[
                                  FieldUpdate(
                                    fromKey: controller.formKeyBio,
                                    validate: ((value) =>
                                        controller.validateLength(
                                            field: value, length: 5)),
                                    textEditingController:
                                        controller.bioController,
                                    onSave: ((value) =>
                                        controller.bio.value = value),
                                    hintText: 'change-to...',
                                    preIconData: Icons.info_outline,
                                    onPressed: () {
                                      controller.checkUpdateBio();
                                    },
                                    sufIconData: Icons.done,
                                  ),
                                ],
                              ),
                              //Email section
                              SimpleText(
                                label: 'contacts',
                                color: kPrimaryColor,
                                fontWeight: FontWeight.w600,
                              ),
                              UpdateListFields(
                                preIcon: Icons.email_outlined,
                                sufIcon: Icons.add,
                                onPressedAdd: () {
                                  controller.addUpdateEmail(
                                    newEmails: controller.emails,
                                  );
                                },
                                onPressedRemove: (i) {
                                  controller.emails.removeAt(i);
                                  controller.removeEmail(
                                    afterRemove: controller.emails,
                                  );
                                },
                                mapField: 'email',
                                title: 'emails',
                                listItems: controller.emails,
                                formKey: controller.formKeyEmail,
                                validate: ((value) =>
                                    controller.validateEmail(value)),
                                textEditingController:
                                    controller.emailController,
                              ),
                              //Phone number section
                              UpdateListFields(
                                sufIcon: Icons.add,
                                preIcon: Icons.contact_phone,
                                onPressedAdd: () {
                                  controller.addUpdatePhoneNumbers(
                                    newPhoneNumbers: controller.phoneNumbers,
                                  );
                                },
                                onPressedRemove: (i) {
                                  controller.phoneNumbers.removeAt(i);
                                  controller.removePhoneNumber(
                                    afterRemove: controller.phoneNumbers,
                                  );
                                },
                                mapField: 'phoneNumber',
                                title: 'phone-number',
                                listItems: controller.phoneNumbers,
                                formKey: controller.formKeyPhoneNumber,
                                validate: ((value) => controller.validateLength(
                                    field: value, length: 9)),
                                textEditingController:
                                    controller.phoneNumberController,
                              ),
                            ],
                          )
                        : Center(
                            child: CircularProgressIndicator(),
                          ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
