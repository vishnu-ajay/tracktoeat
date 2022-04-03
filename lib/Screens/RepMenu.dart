import 'dart:io';
import 'dart:typed_data';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import '../Auth/AuthUser.dart';
import '../Database/Database.dart';
import '../Database/Food.dart';
import '../Theme.dart';
import 'package:image_picker/image_picker.dart';
import 'Widgets/FoodCard.dart';

class RepMenu extends StatefulWidget {
  final AuthUser authUser;
  const RepMenu({Key? key,required this.authUser}) : super(key: key);

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
  final _textController = TextEditingController(text: "");
  final _priceController = TextEditingController(text: "");
  final ImagePicker _picker = ImagePicker();
  String messName = "";
  int _mealIndex = 0;
  int _dayIndex = 0;
  String mealName = "Snacks";
  double mealPrice = 0.0;
  File? _uploadImage;

  bool applyFilters = true;

  Food? _oFood;

  bool loading = false;

  @override
  void initState() {
    setState(() {
      loading = true;
    });
    Database.getMyMess(widget.authUser.user!.email??"").then((value){
      setState(() {
        messName = value;
        loading = false;
      });
    });
    super.initState();
  }

  void clearAll(){
    applyFilters = true;
    _uploadImage = null;
    // _mealIndex = 0;
    _oFood = null;
    _oFood = null;
    // _dayIndex = 0;
    mealName = "";
    mealPrice = 0;
    _textController.text = "";
    _priceController.text = "";
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Stack(
      children: [
        SizedBox(
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
                                child: Center(
                                  child: Text(
                                    messName,
                                    style: const TextStyle(
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
                                      applyFilters = true;
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
                                      applyFilters = true;
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
                                      applyFilters = true;
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
                                      applyFilters = true;
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
                          child: Center(
                            child: GestureDetector(
                              onTap: ()async{
                                setState(() {
                                  loading = true;
                                });
                                print(messName);
                                print(_meals[_mealIndex]);
                                _oFood = await Database.getFood(messName,_daysOfTheWeek[_dayIndex], _meals[_mealIndex]);
                                print(_oFood?.toJson());
                                print('@'*50);
                                mealPrice = _oFood!.price;
                                mealName = _oFood!.mealName;
                                _textController.text = mealName;
                                _priceController.text = mealPrice.toString();
                                setState(() {
                                  loading = false;
                                  applyFilters = false;
                                });

                                return;
                              },
                              child: Container(
                                height: 40,
                                width: 200,
                                decoration: BoxDecoration(
                                    borderRadius:
                                    const BorderRadius.all(Radius.circular(5)),
                                  color: applyFilters ? LightTheme.deepIndigoAccent : Colors.black12,
                                ),
                                child: Center(
                                  child: Text(
                                    'Apply Filters',
                                    style: TextStyle(
                                        color: applyFilters ? Colors.white : Colors.grey,
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
                                      controller: _textController,
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
                                      controller: _priceController,
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
                      if((!applyFilters) && (_oFood!=null) && (_oFood!.imageUrl!=""))
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
                                    image: Image.network(
                                      _oFood!.imageUrl,
                                      fit: BoxFit.fill,
                                    ).image,
                                  ),
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
                                    if(_oFood!=null){
                                      _oFood!.imageUrl = "";
                                    }
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
                child: GestureDetector(
                  onTap: (){
                    setState(() {
                      clearAll();
                    });
                  },
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

                                  if(applyFilters){
                                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(backgroundColor: Colors.deepOrange,content: Text('Apply filters before saving!',style: TextStyle(color: LightTheme.white),)));

                                    return;
                                  }

                                  if((_formKey.currentState == null) || (!_formKey.currentState!.validate())) {
                                    return;
                                  }
                                  
                                  setState(() {
                                    loading = true;
                                  });
                                  
                                  String _imageUrl = (_uploadImage == null)
                                      ? ""
                                      : await Database.uploadImage(
                                          _uploadImage!.readAsBytesSync(),
                                          _uploadImage!.path.split('.').last);
                                  Food _food = Food(mealName: mealName, mess: messName,imageUrl: _imageUrl.isEmpty ? _oFood!.imageUrl : _imageUrl, price: mealPrice, day: _daysOfTheWeek[_dayIndex], mealType: _meals[_mealIndex], count:(_oFood==null)?0:_oFood!.count,rating: (_oFood==null)?0:_oFood!.rating,prevCount: _oFood!.prevCount, prevRating: _oFood!.prevCount);

                                  Database.setFood(_food);
                                  
                                  setState(() {
                                    loading = false;
                                  });

                                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(backgroundColor: LightTheme.deepIndigoAccent,content: Text('Updated Database Successfully!',style: TextStyle(color: LightTheme.white),)));
                                  
                                  clearAll();

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
              ),
            ],
          ),
        ),
        if (loading)
          BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 2.0, sigmaY: 2.0),
            child: Container(
              color: Colors.black.withOpacity(0),
            ),
          ),
        if (loading)
          const Align(
            alignment: Alignment.center,
            child: SizedBox(
              height: 60,
              width: 60,
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(
                    LightTheme.caribbeanGreen),
              ),
            ),
          )
      ],
    );
  }
}
