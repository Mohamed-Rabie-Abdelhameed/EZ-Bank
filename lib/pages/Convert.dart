import 'package:ez_bank/Network/API.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Convert extends StatefulWidget {
  const Convert({super.key});

  @override
  State<Convert> createState() => _ConvertState();

  static toDouble(String json) {}
}

class _ConvertState extends State<Convert> {
  TextEditingController _amountController = TextEditingController();
  TextEditingController _fromController = TextEditingController();
  TextEditingController _toController = TextEditingController();
  TextEditingController _resultController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  API api = API();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Convert",
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  DropdownMenu(
                      enableFilter: false,
                      enableSearch: false,
                      controller: _fromController,
                      initialSelection: "USD",
                      menuHeight: 360,
                      label: Text("From"),
                      menuStyle: MenuStyle(
                        backgroundColor: MaterialStateColor.resolveWith(
                            (states) => Theme.of(context).canvasColor),
                        elevation:
                            MaterialStateProperty.resolveWith((states) => 10.0),
                        shape: MaterialStateProperty.resolveWith((states) =>
                            RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0))),
                      ),
                      textStyle: TextStyle(
                        color: Theme.of(context).primaryColor,
                        fontSize: 20,
                      ),
                      dropdownMenuEntries: [
                        DropdownMenuEntry(value: "USD", label: "USD"),
                        DropdownMenuEntry(value: "EUR", label: "EUR"),
                        DropdownMenuEntry(value: "GBP", label: "GBP"),
                        DropdownMenuEntry(value: "JPY", label: "JPY"),
                        DropdownMenuEntry(value: "AUD", label: "AUD"),
                        DropdownMenuEntry(value: "CAD", label: "CAD"),
                        DropdownMenuEntry(value: "CHF", label: "CHF"),
                        DropdownMenuEntry(value: "EGP", label: "EGP"),
                        DropdownMenuEntry(value: "CNY", label: "CNY"),
                        DropdownMenuEntry(value: "HKD", label: "HKD"),
                        DropdownMenuEntry(value: "NZD", label: "NZD"),
                        DropdownMenuEntry(value: "SEK", label: "SEK"),
                        DropdownMenuEntry(value: "SGD", label: "SGD"),
                        DropdownMenuEntry(value: "KRW", label: "KRW"),
                        DropdownMenuEntry(value: "MXN", label: "MXN"),
                        DropdownMenuEntry(value: "INR", label: "INR"),
                        DropdownMenuEntry(value: "RUB", label: "RUB"),
                        DropdownMenuEntry(value: "ZAR", label: "ZAR"),
                        DropdownMenuEntry(value: "TRY", label: "TRY"),
                        DropdownMenuEntry(value: "BRL", label: "BRL"),
                        DropdownMenuEntry(value: "TWD", label: "TWD"),
                        DropdownMenuEntry(value: "THB", label: "THB"),
                        DropdownMenuEntry(value: "MYR", label: "MYR"),
                        DropdownMenuEntry(value: "PHP", label: "PHP"),
                        DropdownMenuEntry(value: "IDR", label: "IDR"),
                      ]),
                  DropdownMenu(
                      enableFilter: false,
                      enableSearch: false,
                      controller: _toController,
                      initialSelection: "USD",
                      menuHeight: 360,
                      label: Text("To"),
                      menuStyle: MenuStyle(
                        backgroundColor: MaterialStateColor.resolveWith(
                            (states) => Theme.of(context).canvasColor),
                        elevation:
                            MaterialStateProperty.resolveWith((states) => 10.0),
                        shape: MaterialStateProperty.resolveWith((states) =>
                            RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0))),
                      ),
                      textStyle: TextStyle(
                        color: Theme.of(context).primaryColor,
                        fontSize: 20,
                      ),
                      dropdownMenuEntries: [
                        DropdownMenuEntry(value: "USD", label: "USD"),
                        DropdownMenuEntry(value: "EUR", label: "EUR"),
                        DropdownMenuEntry(value: "GBP", label: "GBP"),
                        DropdownMenuEntry(value: "JPY", label: "JPY"),
                        DropdownMenuEntry(value: "AUD", label: "AUD"),
                        DropdownMenuEntry(value: "CAD", label: "CAD"),
                        DropdownMenuEntry(value: "CHF", label: "CHF"),
                        DropdownMenuEntry(value: "EGP", label: "EGP"),
                        DropdownMenuEntry(value: "CNY", label: "CNY"),
                        DropdownMenuEntry(value: "HKD", label: "HKD"),
                        DropdownMenuEntry(value: "NZD", label: "NZD"),
                        DropdownMenuEntry(value: "SEK", label: "SEK"),
                        DropdownMenuEntry(value: "SGD", label: "SGD"),
                        DropdownMenuEntry(value: "KRW", label: "KRW"),
                        DropdownMenuEntry(value: "MXN", label: "MXN"),
                        DropdownMenuEntry(value: "INR", label: "INR"),
                        DropdownMenuEntry(value: "RUB", label: "RUB"),
                        DropdownMenuEntry(value: "ZAR", label: "ZAR"),
                        DropdownMenuEntry(value: "TRY", label: "TRY"),
                        DropdownMenuEntry(value: "BRL", label: "BRL"),
                        DropdownMenuEntry(value: "TWD", label: "TWD"),
                        DropdownMenuEntry(value: "THB", label: "THB"),
                        DropdownMenuEntry(value: "MYR", label: "MYR"),
                        DropdownMenuEntry(value: "PHP", label: "PHP"),
                        DropdownMenuEntry(value: "IDR", label: "IDR"),
                      ]),
                ],
              ),
              SizedBox(
                height: 30,
              ),
              Form(
                key: _formKey,
                child: TextFormField(
                  controller: _amountController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    labelText: 'Amount',
                  ),
                  style: TextStyle(fontSize: 22),
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter some text';
                    } else if (double.parse(value) <= 0) {
                      return 'Please enter a valid amount';
                    } else if (!value.isNumericOnly) {
                      return 'Please enter a valid amount';
                    }
                    return null;
                  },
                ),
              ),
              SizedBox(
                height: 30,
              ),
              TextFormField(
                enabled: false,
                style: TextStyle(fontSize: 22),
                controller: _resultController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  disabledBorder: InputBorder.none,
                  labelText: 'Result',
                  labelStyle: TextStyle(
                      color: Theme.of(context).primaryColor, fontSize: 50),
                ),
              ),
              SizedBox(
                height: 30,
              ),
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      var rate = await api.getRate(
                        _fromController.text,
                        _toController.text,
                      );
                      var result = rate * double.parse(_amountController.text);
                      setState(() {
                        _resultController.text = result.toStringAsFixed(2);
                      });
                    }
                  },
                  child: Text(
                    "Convert",
                    style: TextStyle(
                        fontSize: 20,
                        color: Theme.of(context).scaffoldBackgroundColor),
                  ),
                  style: ElevatedButton.styleFrom(
                    primary: Theme.of(context).primaryColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0),
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
