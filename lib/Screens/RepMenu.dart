import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import '../Database/Database.dart';
import '../Database/Food.dart';
import '../Theme.dart';
import 'package:image_picker/image_picker.dart';
import 'Widgets/FoodCard.dart';

class RepMenu extends StatefulWidget {
  const RepMenu({Key? key}) : super(key: key);

  @override
  State<RepMenu> createState() => _RepMenuState();
}

class _RepMenuState extends State<RepMenu> {
  final List<String> _daysOfTheWeek = [
    'Sunday',
    'Monday',
    'Tuesday',
    'Wednesday',
    'Thursday',
    'Friday',
    'Saturday'
  ];
  final List<String> _meals = ['Snacks', 'Dinner'];
  final _formKey = GlobalKey<FormState>();
  final ImagePicker _picker = ImagePicker();
  String messName = "None";
  int _mealIndex = 0;
  int _dayIndex = 0;
  String mealName = "";
  double mealPrice = 0.0;
  File? _uploadImage;

  Food? _oFood;

  @override
  void initState() {
    // TODO: get _oFood
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return SizedBox(
      height: height,
      child: Column(
        children: [
          Expanded(
            child: Form(
              key: _formKey,
              child: CustomScrollView(
                slivers: [
                  const SliverPadding(
                    padding: EdgeInsets.only(top: 30, bottom: 5),
                    sliver: SliverToBoxAdapter(
                      child: Center(
                        child: Text(
                          'Mess Representative controls',
                          style: TextStyle(
                              color: LightTheme.darkGray,
                              fontWeight: FontWeight.w500,
                              fontSize: 21),
                        ),
                      ),
                    ),
                  ),
                  const SliverPadding(
                    padding: EdgeInsets.only(left: 60, top: 50, bottom: 20),
                    sliver: SliverToBoxAdapter(
                      child: Text(
                        'Change Food Item',
                        style: TextStyle(
                            color: LightTheme.gray,
                            fontWeight: FontWeight.w500,
                            fontSize: 15),
                      ),
                    ),
                  ),
                  SliverPadding(
                    padding: const EdgeInsets.only(left: 0),
                    sliver: SliverToBoxAdapter(
                      child: SizedBox(
                        height: 100,
                        child: Row(
                          children: [
                            const Spacer(
                              flex: 2,
                            ),
                            SizedBox(
                              width: 110,
                              height: 60,
                              child: Column(
                                children: [
                                  const SizedBox(
                                    height: 30,
                                    child: Text(
                                      'Chosen Day',
                                      style: TextStyle(
                                        color: LightTheme.gray,
                                        fontSize: 13,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                  ),
                                  Container(
                                    decoration: BoxDecoration(
                                        borderRadius: const BorderRadius.all(
                                            Radius.circular(5)),
                                        border: Border.all(
                                            color: LightTheme.deepIndigoAccent),
                                        color: Colors.grey.withOpacity(0.5)),
                                    height: 30,
                                    width: 110,
                                    child: Center(
                                      child: Text(
                                        _daysOfTheWeek[_dayIndex],
                                        style: const TextStyle(
                                          fontWeight: FontWeight.w400,
                                          fontSize: 14,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const Spacer(),
                            SizedBox(
                              width: 110,
                              height: 60,
                              child: Column(
                                children: [
                                  const SizedBox(
                                    height: 30,
                                    child: Text(
                                      'Chosen Meal',
                                      style: TextStyle(
                                        color: LightTheme.gray,
                                        fontSize: 13,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                  ),
                                  Container(
                                    decoration: BoxDecoration(
                                        borderRadius: const BorderRadius.all(
                                            Radius.circular(5)),
                                        border: Border.all(
                                            color: LightTheme.deepIndigoAccent),
                                        color: Colors.grey.withOpacity(0.5)),
                                    height: 30,
                                    width: 110,
                                    child: Center(
                                      child: Text(
                                        _meals[_mealIndex],
                                        style: const TextStyle(
                                          fontWeight: FontWeight.w400,
                                          fontSize: 14,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const Spacer(
                              flex: 2,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  SliverPadding(
                    padding: const EdgeInsets.only(
                      top: 10,
                    ),
                    sliver: SliverToBoxAdapter(
                      child: Center(
                        child: ClipRRect(
                          borderRadius:
                              const BorderRadius.all(Radius.circular(5)),
                          child: Container(
                            height: 40,
                            width: 200,
                            color: LightTheme.deepIndigoAccent,
                            child: const Center(
                              child: Text(
                                'A-Mess',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 18,
                                    fontWeight: FontWeight.w400),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  SliverPadding(
                    padding: const EdgeInsets.only(
                      top: 20,
                    ),
                    sliver: SliverToBoxAdapter(
                      child: Row(
                        children: [
                          const Spacer(),
                          IconButton(
                              onPressed: () {
                                setState(() {
                                  _dayIndex--;
                                  _dayIndex %= _daysOfTheWeek.length;
                                });
                              },
                              icon: const Icon(Icons.keyboard_arrow_left)),
                          ClipRRect(
                            borderRadius:
                                const BorderRadius.all(Radius.circular(5)),
                            child: Container(
                              height: 40,
                              width: 200,
                              color: LightTheme.deepIndigoAccent,
                              child: Center(
                                child: Text(
                                  _daysOfTheWeek[_dayIndex],
                                  style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 18,
                                      fontWeight: FontWeight.w400),
                                ),
                              ),
                            ),
                          ),
                          IconButton(
                              onPressed: () {
                                setState(() {
                                  _dayIndex++;
                                  _dayIndex %= _daysOfTheWeek.length;
                                });
                              },
                              icon: const Icon(Icons.keyboard_arrow_right)),
                          const Spacer(),
                        ],
                      ),
                    ),
                  ),
                  SliverPadding(
                    padding: const EdgeInsets.only(
                      top: 20,
                    ),
                    sliver: SliverToBoxAdapter(
                      child: Row(
                        children: [
                          const Spacer(),
                          IconButton(
                              onPressed: () {
                                setState(() {
                                  _mealIndex--;
                                  _mealIndex %= _meals.length;
                                });
                              },
                              icon: const Icon(Icons.keyboard_arrow_left)),
                          ClipRRect(
                            borderRadius:
                                const BorderRadius.all(Radius.circular(5)),
                            child: Container(
                              height: 40,
                              width: 200,
                              color: LightTheme.deepIndigoAccent,
                              child: Center(
                                child: Text(
                                  _meals[_mealIndex],
                                  style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 18,
                                      fontWeight: FontWeight.w400),
                                ),
                              ),
                            ),
                          ),
                          IconButton(
                              onPressed: () {
                                setState(() {
                                  _mealIndex++;
                                  _mealIndex %= _meals.length;
                                });
                              },
                              icon: const Icon(Icons.keyboard_arrow_right)),
                          const Spacer(),
                        ],
                      ),
                    ),
                  ),
                  SliverPadding(
                    padding: const EdgeInsets.only(top: 40),
                    sliver: SliverToBoxAdapter(
                      child: Center(
                        child: SizedBox(
                          width: 300,
                          child: Column(
                            children: [
                              const Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  'Meal Name',
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                      color: Colors.grey, fontSize: 13),
                                ),
                              ),
                              SizedBox(
                                height: 70,
                                child: TextFormField(
                                  onChanged: (value) {
                                    setState(() {
                                      mealName = value;
                                    });
                                  },
                                  validator: (val) {
                                    if (val != null && val.isNotEmpty) {
                                      return null;
                                    }
                                    return 'Meal name cannot be empty!';
                                  },
                                  decoration: InputDecoration(
                                    fillColor: Colors.white,
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(5.0),
                                      borderSide: const BorderSide(
                                        color: LightTheme.deepIndigoAccent,
                                      ),
                                    ),
                                    focusedErrorBorder:OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(5.0),
                                      borderSide: const BorderSide(
                                        color: Colors.red,
                                      ),
                                    ),
                                    errorBorder:OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(5.0),
                                      borderSide: const BorderSide(
                                        color: Colors.red,
                                      ),
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(5.0),
                                      borderSide: const BorderSide(
                                        color: Colors.grey,
                                        width: 1.0,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  SliverPadding(
                    padding: const EdgeInsets.only(top: 20),
                    sliver: SliverToBoxAdapter(
                      child: Center(
                        child: SizedBox(
                          width: 300,
                          child: Column(
                            children: [
                              const Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  'Meal Price',
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                      color: Colors.grey, fontSize: 13),
                                ),
                              ),
                              SizedBox(
                                height: 70,
                                child: TextFormField(
                                  onChanged: (value) {
                                    setState(() {
                                      mealPrice = double.parse(value);
                                    });
                                  },
                                  validator: (val) {
                                    if (val != null && val.isNotEmpty) {
                                      return null;
                                    }
                                    return 'Meal price cannot be empty!';
                                  },
                                  keyboardType: const TextInputType.numberWithOptions(decimal: true),
                                  decoration: InputDecoration(
                                    fillColor: Colors.white,
                                    errorBorder:OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(5.0),
                                      borderSide: const BorderSide(
                                        color: Colors.red,
                                      ),
                                    ),
                                    focusedErrorBorder:OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(5.0),
                                      borderSide: const BorderSide(
                                        color: Colors.red,
                                      ),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(5.0),
                                      borderSide: const BorderSide(
                                        color: LightTheme.deepIndigoAccent,
                                      ),
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(5.0),
                                      borderSide: const BorderSide(
                                        color: Colors.grey,
                                        width: 1.0,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  if (_uploadImage != null)
                    SliverPadding(
                      padding: const EdgeInsets.only(top: 20),
                      sliver: SliverToBoxAdapter(
                        child: Center(
                          child: ClipRRect(
                            child: Container(
                              height: 300,
                              width: 300,
                              padding: const EdgeInsets.all(8.0),
                              decoration: BoxDecoration(
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(5)),
                                  border: Border.all(
                                    color: LightTheme.deepIndigoAccent,
                                  )),
                              child: Image(
                                image: Image.file(
                                  _uploadImage!,
                                  fit: BoxFit.fill,
                                ).image,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  SliverPadding(
                    padding: const EdgeInsets.only(top: 20, bottom: 40),
                    sliver: SliverToBoxAdapter(
                      child: Center(
                        child: GestureDetector(
                          onTap: () async {
                            await Permission.photos.request();

                            var permissionStatus =
                                await Permission.photos.status;

                            if (permissionStatus.isGranted) {
                              //Select Image
                              XFile? image = await _picker.pickImage(
                                  source: ImageSource.gallery);

                              if (image == null) {
                                print('Not image has been selected!');
                                return;
                              }

                              setState(() {
                                _uploadImage = File(image.path);
                              });
                            } else {
                              print(
                                  'Permission not granted. Try Again with permission access');
                              //TODO: Replace print statement with scaffold message.
                            }
                          },
                          child: Container(
                            width: 300,
                            height: 50,
                            decoration: BoxDecoration(
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(5)),
                              border: Border.all(
                                  color: LightTheme.deepIndigoAccent),
                            ),
                            child: const Center(
                              child: Text(
                                'Choose Photo',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w500,
                                  color: LightTheme.deepIndigoAccent,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            height: 80,
            child: Container(
                decoration:
                    const BoxDecoration(color: Colors.white, boxShadow: [
                  BoxShadow(
                    color: Colors.grey,
                    blurRadius: 5.0,
                  ),
                ]),
                child: Row(
                  children: [
                    const Spacer(
                      flex: 2,
                    ),
                    Center(
                      child: Container(
                        height: 50,
                        width: 150,
                        decoration: BoxDecoration(
                            borderRadius:
                                const BorderRadius.all(Radius.circular(5)),
                            border: Border.all(
                              color: Colors.grey,
                            )),
                        child: const Center(
                          child: Text(
                            'Discard Changes',
                            style: TextStyle(),
                          ),
                        ),
                      ),
                    ),
                    const Spacer(),
                    Center(
                      child: ClipRRect(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(5)),
                        child: GestureDetector(
                          onTap: () async {
                            if((_formKey.currentState == null) || (_formKey.currentState!.validate())) {
                              return;
                            }
                            print(mealName);
                            print(mealPrice);
                            String _imageUrl = (_uploadImage == null)
                                ? ""
                                : await Database.uploadImage(
                                    _uploadImage!.readAsBytesSync(),
                                    _uploadImage!.path.split('.').last);
                            Food _food = Food(mealName: mealName, mess: messName,imageUrl: _imageUrl, price: mealPrice, day: _daysOfTheWeek[_dayIndex], mealType: _meals[_mealIndex], count:(_oFood==null)?0:_oFood!.count,rating: (_oFood==null)?0:_oFood!.rating);
                          },
                          child: Container(
                            height: 50,
                            width: 150,
                            color: LightTheme.deepIndigoAccent,
                            child: const Center(
                              child: Text(
                                'Save Changes',
                                style: TextStyle(
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    const Spacer(
                      flex: 2,
                    ),
                  ],
                )),
          ),
        ],
      ),
    );
  }
}
