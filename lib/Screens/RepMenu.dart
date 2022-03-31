import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../Theme.dart';
import 'Widgets/FoodCard.dart';

class RepMenu extends StatefulWidget {
  const RepMenu({Key? key}) : super(key: key);

  @override
  State<RepMenu> createState() => _RepMenuState();
}

class _RepMenuState extends State<RepMenu> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return SizedBox(
      height: height,
      child: Column(
        children: [
          Expanded(
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
                          const Spacer(flex: 2,),
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
                                      borderRadius:
                                          const BorderRadius.all(Radius.circular(5)),
                                      border: Border.all(color: LightTheme.deepIndigoAccent),
                                      color: Colors.grey.withOpacity(0.5)),
                                  height: 30,
                                  width: 110,
                                  child: const Center(
                                    child: Text(
                                      'Tuesday',
                                      style: TextStyle(
                                        fontWeight: FontWeight.w400,
                                        fontSize: 16,
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
                                      borderRadius:
                                      const BorderRadius.all(Radius.circular(5)),
                                      border: Border.all(color: LightTheme.deepIndigoAccent),
                                      color: Colors.grey.withOpacity(0.5)),
                                  height: 30,
                                  width: 110,
                                  child: const Center(
                                    child: Text(
                                      'Dinner',
                                      style: TextStyle(
                                        fontWeight: FontWeight.w400,
                                        fontSize: 16,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const Spacer(flex: 2,),
                        ],
                      ),
                    ),
                  ),
                ),
                SliverPadding(padding: const EdgeInsets.only(top: 10,),
                sliver: SliverToBoxAdapter(
                  child: Center(
                    child: ClipRRect(
                      borderRadius: const BorderRadius.all(Radius.circular(5)),
                      child: Container(
                        height: 40,
                        width: 200,
                        color: LightTheme.deepIndigoAccent,
                        child: const Center(
                          child: Text('A-Mess',style: TextStyle(color:Colors.white,fontSize: 18,fontWeight: FontWeight.w400),),
                        ),
                      ),
                    ),
                  ),
                ),),
                SliverPadding(padding: const EdgeInsets.only(top: 20,),
                  sliver: SliverToBoxAdapter(
                    child: Row(
                      children: [
                        const Spacer(),
                        IconButton(onPressed: (){}, icon: const Icon( Icons.keyboard_arrow_left)),
                        ClipRRect(
                          borderRadius: const BorderRadius.all(Radius.circular(5)),
                          child: Container(
                            height: 40,
                            width: 200,
                            color: LightTheme.deepIndigoAccent,
                            child: const Center(
                              child: Text('Tuesday',style: TextStyle(color:Colors.white,fontSize: 18,fontWeight: FontWeight.w400),),
                            ),
                          ),
                        ),
                        IconButton(onPressed: (){}, icon: const Icon( Icons.keyboard_arrow_right)),
                      const Spacer(),
                      ],
                    ),
                  ),),
                SliverPadding(padding: const EdgeInsets.only(top: 20,),
                  sliver: SliverToBoxAdapter(
                    child: Row(
                      children: [
                        const Spacer(),
                        IconButton(onPressed: (){}, icon: const Icon( Icons.keyboard_arrow_left)),
                        ClipRRect(
                          borderRadius: const BorderRadius.all(Radius.circular(5)),
                          child: Container(
                            height: 40,
                            width: 200,
                            color: LightTheme.deepIndigoAccent,
                            child: const Center(
                              child: Text('Dinner',style: TextStyle(color:Colors.white,fontSize: 18,fontWeight: FontWeight.w400),),
                            ),
                          ),
                        ),
                        IconButton(onPressed: (){}, icon: const Icon( Icons.keyboard_arrow_right)),
                        const Spacer(),
                      ],
                    ),
                  ),),
                SliverPadding(padding: const EdgeInsets.only(top: 40),
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
                                 color: Colors.grey,
                                 fontSize: 13
                               ),
                             ),
                           ),
                           SizedBox(
                             height: 50,
                             child: TextFormField(
                               decoration: InputDecoration(
                                 fillColor: Colors.white,
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
                ),),
                SliverPadding(padding: const EdgeInsets.only(top: 20),
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
                                    color: Colors.grey,
                                    fontSize: 13
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 50,
                              child: TextFormField(
                                decoration: InputDecoration(
                                  fillColor: Colors.white,
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
                  ),),
                SliverPadding(padding: const EdgeInsets.only(top: 20,bottom: 40),
                  sliver: SliverToBoxAdapter(
                    child: Center(
                      child: Container(
                        width: 300,
                        height: 50,
                        decoration: BoxDecoration(
                          borderRadius: const BorderRadius.all(Radius.circular(5)),
                          border: Border.all(color: LightTheme.deepIndigoAccent),
                        ),
                        child: const Center(
                          child: Text(
                            'Upload Photo',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w500,
                              color: LightTheme.deepIndigoAccent,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),),
              ],
            ),
          ),
          SizedBox(height: 80,
            child: Container(
              decoration: const BoxDecoration(
                  color: Colors.white,
                  boxShadow: [BoxShadow(
                    color: Colors.grey,
                    blurRadius: 5.0,
                  ),]
              ),
              child: Row(
                children: [
                  const Spacer(flex:2,),
                  Center(
                    child: Container(
                      height: 50,
                      width: 150,
                      decoration: BoxDecoration(
                        borderRadius:const BorderRadius.all(Radius.circular(5)),
                        border: Border.all(
                          color: Colors.grey,
                        )
                      ),
                      child: const Center(
                        child: Text(
                          'Discard Changes',
                          style: TextStyle(
                          ),
                        ),
                      ),
                    ),
                  ),
                  const Spacer(),
                  Center(
                    child: ClipRRect(
                      borderRadius: const BorderRadius.all(Radius.circular(5)),
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
                  const Spacer(flex:2,),
                ],
              )
            ),
          ),
        ],
      ),
    );
  }
}
