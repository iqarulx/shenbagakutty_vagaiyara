import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:intl/intl.dart';
import 'package:shenbagakutty_vagaiyara/view/screens/receipt/src/pdf_view.dart';
import '/constants/constants.dart';
import '/functions/functions.dart';
import '/utils/utils.dart';
import '/view/view.dart';
import '/model/model.dart';
import 'sheets/sheets.dart';

class AddReceipt extends StatefulWidget {
  final List<MemberModel> mList;
  final List<RTypeModel> rList;

  const AddReceipt({super.key, required this.mList, required this.rList});

  @override
  State<AddReceipt> createState() => _AddReceiptState();
}

class _AddReceiptState extends State<AddReceipt> {
  var formKey = GlobalKey<FormState>();

  final TextEditingController _rDate = TextEditingController();
  final TextEditingController _rType = TextEditingController();
  String? selectedRTypeId;
  final TextEditingController _member = TextEditingController();
  String? selectedMemberId;
  final TextEditingController _amount = TextEditingController();
  final TextEditingController _funeralTo = TextEditingController();
  final TextEditingController _nMemberName = TextEditingController();
  final TextEditingController _functionDate = TextEditingController();
  final TextEditingController _countForMudiKanikai = TextEditingController();
  final TextEditingController _countForKadhuKuthu = TextEditingController();
  final TextEditingController _description = TextEditingController();

  List<String> visibleFeilds = [];

  @override
  void initState() {
    _rDate.text = DateFormat('yyyy-MM-dd').format(DateTime.now());
    _rType.addListener(() {
      setState(() {});
    });
    _member.addListener(() {
      setState(() {});
    });
    super.initState();
  }

  _rDatePicker() async {
    final DateTime? picked = await datePicker(context);
    if (picked != null) {
      setState(() {
        _rDate.text = DateFormat('yyyy-MM-dd').format(picked);
      });
    }
    return null;
  }

  _fDatePicker() async {
    final DateTime? picked = await datePicker(context);
    if (picked != null) {
      setState(() {
        _functionDate.text = DateFormat('yyyy-MM-dd').format(picked);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          tooltip: "Back",
          icon: const Icon(Icons.arrow_back_ios_new_rounded),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: const Text("Add Receipt"),
      ),
      body: Form(
        key: formKey,
        child: ListView(
          padding: const EdgeInsets.all(10),
          children: [
            Row(
              children: [
                Expanded(
                  child: FormFields(
                    suffixIcon: const Icon(Iconsax.calendar_1),
                    controller: _rDate,
                    label: "Receipt Date",
                    hintText: "yyyy-MM-dd",
                    onTap: () => _rDatePicker(),
                    readOnly: true,
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: FormFields(
                    label: "Receipt Type (*)",
                    suffixIcon: _rType.text.isEmpty
                        ? const Icon(Icons.arrow_drop_down_rounded)
                        : IconButton(
                            tooltip: "Clear",
                            onPressed: () {
                              _rType.clear();
                              selectedRTypeId = null;
                              visibleFeilds.clear();
                              setState(() {});
                            },
                            icon: Icon(
                              Iconsax.close_circle,
                              color: AppColors.primaryColor,
                            ),
                          ),
                    controller: _rType,
                    hintText: "Type",
                    onTap: () async {
                      var value = await Sheet.showSheet(context,
                          size: 0.9, widget: RType(query: widget.rList));
                      if (value != null) {
                        _rType.text = value["value"];
                        visibleFeilds = List<String>.from(value["inputs"]);
                        selectedRTypeId = value["id"];
                        setState(() {});
                      }
                    },
                    readOnly: true,
                    valid: (input) {
                      if (input != null) {
                        if (input.isEmpty) {
                          return 'Select Receipt Type';
                        }
                      }
                      return null;
                    },
                  ),
                ),
              ],
            ),
            if (visibleFeilds.isNotEmpty)
              Column(
                children: [
                  if (visibleFeilds.contains('Member'))
                    Padding(
                      padding: const EdgeInsets.only(top: 10),
                      child: FormFields(
                        label: "Member (*)",
                        suffixIcon: _member.text.isEmpty
                            ? const Icon(Icons.arrow_drop_down_rounded)
                            : IconButton(
                                tooltip: "Clear",
                                onPressed: () {
                                  _member.clear();
                                  selectedMemberId = null;
                                  setState(() {});
                                },
                                icon: Icon(
                                  Iconsax.close_circle,
                                  color: AppColors.primaryColor,
                                ),
                              ),
                        controller: _member,
                        onTap: () async {
                          var value = await Sheet.showSheet(context,
                              size: 0.9,
                              widget: ListingMember(query: widget.mList));
                          if (value != null) {
                            _member.text = value["value"];
                            selectedMemberId = value["id"];
                          }
                        },
                        readOnly: true,
                        valid: (input) {
                          if (input != null) {
                            if (input.isEmpty) {
                              return 'Select Member';
                            }
                          }
                          return null;
                        },
                      ),
                    ),
                  if (visibleFeilds.contains('Amount'))
                    Padding(
                      padding: const EdgeInsets.only(top: 10),
                      child: FormFields(
                        controller: _amount,
                        label: "Amount (*)",
                        valid: (input) {
                          if (input != null) {
                            if (input.isEmpty) {
                              return 'Enter amount';
                            }
                          }
                          return null;
                        },
                      ),
                    ),
                  if (visibleFeilds.contains('Funeral To'))
                    Padding(
                      padding: const EdgeInsets.only(top: 10),
                      child: FormFields(
                        controller: _funeralTo,
                        label: "Funeral To",
                        valid: (input) {
                          if (input != null) {
                            if (input.isEmpty) {
                              return 'Enter the funeral to';
                            }
                          }
                          return null;
                        },
                      ),
                    ),
                  if (visibleFeilds.contains('Name'))
                    Padding(
                      padding: const EdgeInsets.only(top: 10),
                      child: FormFields(
                        controller: _nMemberName,
                        label: "Non-Member Name",
                        valid: (input) {
                          if (_member.text.isNotEmpty) {
                            return null;
                          }
                          if (input != null) {
                            if (input.isEmpty) {
                              return 'Enter the name or select member';
                            }
                          }
                          return null;
                        },
                      ),
                    ),
                  if (visibleFeilds.contains('Function Date'))
                    Padding(
                      padding: const EdgeInsets.only(top: 10),
                      child: FormFields(
                        suffixIcon: const Icon(Iconsax.calendar_1),
                        controller: _rDate,
                        label: "Function Date",
                        hintText: "yyyy-MM-dd",
                        onTap: () => _fDatePicker(),
                        readOnly: true,
                        valid: (input) {
                          if (input != null) {
                            if (input.isEmpty) {
                              return 'Select Date';
                            }
                          }
                          return null;
                        },
                      ),
                    ),
                  if (visibleFeilds.contains('Count For MudiKanikai'))
                    Padding(
                      padding: const EdgeInsets.only(top: 10),
                      child: FormFields(
                        controller: _countForMudiKanikai,
                        label: "Count For MudiKanikai",
                        valid: (input) {
                          if (input != null) {
                            if (input.isEmpty) {
                              return 'Enter the count';
                            }
                          }
                          return null;
                        },
                      ),
                    ),
                  if (visibleFeilds.contains('Count For Kadhu Kuthu'))
                    Padding(
                      padding: const EdgeInsets.only(top: 10),
                      child: FormFields(
                        controller: _countForKadhuKuthu,
                        label: "Count For Kadhu Kuthu",
                        valid: (input) {
                          if (input != null) {
                            if (input.isEmpty) {
                              return 'Enter the count';
                            }
                          }
                          return null;
                        },
                      ),
                    ),
                  if (visibleFeilds.contains('Description'))
                    Padding(
                      padding: const EdgeInsets.only(top: 10),
                      child: FormFields(
                        controller: _description,
                        label: "Description",
                        maxLines: 2,
                        valid: (input) {
                          if (input != null) {
                            if (input.isEmpty) {
                              return 'Enter the description';
                            }
                          }
                          return null;
                        },
                      ),
                    ),
                ],
              ),
          ],
        ),
      ),
      bottomNavigationBar: bottomAppbar(context),
    );
  }

  BottomAppBar bottomAppbar(BuildContext context) {
    return BottomAppBar(
      color: Colors.white,
      surfaceTintColor: Colors.white,
      child: ElevatedButton(
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(AppColors.primaryColor),
          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
          minimumSize: MaterialStateProperty.all(const Size(80, 30)),
          padding: MaterialStateProperty.all(EdgeInsets.zero),
          shape: MaterialStateProperty.all(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Iconsax.tick_circle, color: AppColors.pureWhiteColor),
            const SizedBox(width: 10),
            Text(
              "Submit",
              style: Theme.of(context)
                  .textTheme
                  .bodyLarge!
                  .copyWith(color: AppColors.pureWhiteColor),
            ),
          ],
        ),
        onPressed: () async {
          if (formKey.currentState!.validate()) {
            _submitForm();
          }
        },
      ),
    );
  }

  _submitForm() async {
    try {
      futureLoading(context);
      var result = {};

      if (_rType.text == "General Donation") {
        var map = {
          "edit_id": "",
          "receipt_date": _rDate.text,
          "receipt_type_id": selectedRTypeId,
          "member_id": selectedMemberId,
          "amount": _amount.text,
        };

        result = await ReceiptFunctions.saveReceipt(
            query: map, type: ReceiptType.generalDonation);
      } else if (_rType.text == "Personal Savings") {
        var map = {
          "edit_id": "",
          "receipt_date": _rDate.text,
          "receipt_type_id": selectedRTypeId,
          "member_id": selectedMemberId,
          "amount": _amount.text,
        };

        result = await ReceiptFunctions.saveReceipt(
            query: map, type: ReceiptType.personalSavings);
      } else if (_rType.text == "Nandavanam") {
        var map = {
          "edit_id": "",
          "receipt_date": _rDate.text,
          "receipt_type_id": selectedRTypeId,
          "member_id": selectedMemberId,
          "amount": _amount.text,
          "non_member_name": _nMemberName.text,
          "funeral_to": _funeralTo.text,
        };

        result = await ReceiptFunctions.saveReceipt(
            query: map, type: ReceiptType.nandavanam);
      } else if (_rType.text == "Mudi Kaanikai") {
        var map = {
          "edit_id": "",
          "receipt_date": _rDate.text,
          "receipt_type_id": selectedRTypeId,
          "member_id": selectedMemberId,
          "amount": _amount.text,
          "function_date": _functionDate.text,
          "count_for_kadhu_kuthu": _countForKadhuKuthu.text,
          "count_for_mudikanikai": _countForMudiKanikai.text,
        };

        result = await ReceiptFunctions.saveReceipt(
            query: map, type: ReceiptType.mudiKaanikai);
      } else if (_rType.text == "Pooja Donation") {
        var map = {
          "edit_id": "",
          "receipt_date": _rDate.text,
          "receipt_type_id": selectedRTypeId,
          "member_id": selectedMemberId,
          "amount": _amount.text,
        };

        result = await ReceiptFunctions.saveReceipt(
            query: map, type: ReceiptType.poojaDonation);
      } else if (_rType.text == "Gold/Silver/Dollar") {
        var map = {
          "edit_id": "",
          "receipt_date": _rDate.text,
          "receipt_type_id": selectedRTypeId,
          "member_id": selectedMemberId,
          "amount": _amount.text,
          "description": _description.text,
        };

        result = await ReceiptFunctions.saveReceipt(
            query: map, type: ReceiptType.goldSilverDollar);
      } else if (_rType.text == "New Member Registration") {
        var map = {
          "edit_id": "",
          "receipt_date": _rDate.text,
          "receipt_type_id": selectedRTypeId,
          "member_id": selectedMemberId,
          "amount": _amount.text,
        };

        result = await ReceiptFunctions.saveReceipt(
            query: map, type: ReceiptType.newMemberRegistration);
      } else if (_rType.text == "Old Thalakattu") {
        var map = {
          "edit_id": "",
          "receipt_date": _rDate.text,
          "receipt_type_id": selectedRTypeId,
          "member_id": selectedMemberId,
          "amount": _amount.text,
          "description": _description.text,
        };

        result = await ReceiptFunctions.saveReceipt(
            query: map, type: ReceiptType.oldThalakattu);
      } else if (_rType.text == "New Thalakattu") {
        var map = {
          "edit_id": "",
          "receipt_date": _rDate.text,
          "receipt_type_id": selectedRTypeId,
          "member_id": selectedMemberId,
          "amount": _amount.text,
          "year_amount": "",
          "poojai_from_date": "",
          "poojai_to_date": "",
          "poojai_amount": "",
        };

        result = await ReceiptFunctions.saveReceipt(
            query: map, type: ReceiptType.newThalakattu);
      }
      Navigator.pop(context);
      Snackbar.showSnackBar(context,
          content: "Receipt created successfully", isSuccess: true);
      Navigator.pop(context, true);
      Navigator.push(context, CupertinoPageRoute(builder: (context) {
        return PdfView(
            uri: result["head"]["print_url"], name: "Receipt Preview");
      }));
    } catch (e) {
      Navigator.pop(context);
      Snackbar.showSnackBar(context, content: e.toString(), isSuccess: false);
    }
  }
}
