import 'package:connevents/mixins/data.dart';
import 'package:connevents/models/event-type-model.dart';
import 'package:connevents/models/specific-user-category-model.dart';
import 'package:connevents/services/dio-service.dart';
import 'package:connevents/utils/loading-dialog.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../variables/globalVariables.dart';
import 'package:flutter/material.dart';


class InterestCategoriesPage extends StatefulWidget {
  const InterestCategoriesPage({Key? key}) : super(key: key);

  @override
  State<InterestCategoriesPage> createState() => _InterestCategoriesPageState();
}

class _InterestCategoriesPageState extends State<InterestCategoriesPage> {
  EventTypeList? listOfEventType;
  var isCorporateVisible = false;
  var isSocialEventsVisible = false;
  var isCharityVisible = false;
  List<EventTypes>  userEventTypes=[];
  List<int> listOfIds=[];


  void getSpecifiedUserCategories() async {
      print(AppData().userdetail!.users_id);
        var response = await DioService.post("specific_user_categories", {
              "userId": AppData().userdetail!.users_id
            });
           try{
          var userData = await response['data'];
          userEventTypes = userData.map<EventTypes>((e) => EventTypes.fromJson(e)).toList();
            setState(() {});
          userEventTypes.map((e) {
            e.categories!.map((e) {
              if (e.is_category_selected) listOfIds.add(e.categoryId!);
            }).toList();
          }).toList();


          Navigator.of(context).pop();
        }
        catch(e){
          Navigator.of(context).pop();
          showErrorToast("No categories found against this user.");
        }

  }




      @override
    void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
        openLoadingDialog(context, "fetching...");
        getSpecifiedUserCategories();
         });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
        decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage('assets/imgs/handsbg.png'), fit: BoxFit.cover),
        ),
        child: Column(
          children: [
            Expanded(
                child: SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(
                        horizontal: padding * 2, vertical: padding * 3),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Your Target Categories', style: TextStyle(color: Colors.white, fontSize: 25, fontWeight: FontWeight.bold),),
                        SizedBox(height: padding,),
                        Text('Choose your favorite categories so we can show you related events.', style: TextStyle(color: globalGolden, fontSize: 16,),),
                      ],
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(vertical: padding, horizontal: padding * 2),
                    child: ListView.builder(
                        physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: userEventTypes.length,
                        itemBuilder: (context,index){
                          EventTypes?  _eventType=userEventTypes[index];
                          return  Column(
                            children: [
                              GestureDetector(
                                onTap: (){
                                  if(isCorporateVisible) setState(() =>isCorporateVisible=false);
                                  else setState(()=> isCorporateVisible=true);
                                },
                                child: Padding(
                                  padding: const EdgeInsets.only(bottom: padding *2),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(_eventType.eventType!, style: TextStyle(color: globalGolden, fontSize: 16, fontWeight: FontWeight.w600,),),
                                      SvgPicture.asset(isCorporateVisible?  'assets/icons/up-arrow.svg' :  'assets/icons/downArrow.svg', width: 10, height: 8,),
                                    ],
                                  ),
                                ),
                              ),
                              ListView.builder(
                                  physics: NeverScrollableScrollPhysics(),
                                  shrinkWrap: true,
                                  itemCount: _eventType.categories?.length,
                                  itemBuilder:  (BuildContext context, int index) {
                                    EventTypeCategories categories=_eventType.categories![index];
                                    return Theme(
                                      data: ThemeData(unselectedWidgetColor: globalGolden),
                                      child: CheckboxListTile(
                                          contentPadding: EdgeInsets.zero,
                                          controlAffinity: ListTileControlAffinity.leading,
                                          dense: true,
                                          activeColor: Colors.green,
                                          title: Text(categories.category.toString(),style: TextStyle(color: globalGolden),),
                                          value:  categories.is_category_selected,
                                          onChanged: (bool? value){
                                            categories.is_category_selected=value!;
                                            listOfIds.contains(categories.categoryId) ?
                                                listOfIds.remove(categories.categoryId):
                                            listOfIds.add(categories.categoryId!);
                                            print(listOfIds);
                                            setState(() {});
                                          }),
                                    );
                                  })
                            ],
                          );
                        })
                  )
                ],
              ),
            )
            ),
            Container(
              width: double.infinity,
              padding: EdgeInsets.only(bottom: padding * 2,left: padding*2,right: padding*2),
              child: SizedBox(
                height: 50,
                width: double.infinity,
                child: TextButton(
                    onPressed: () async {

                      openLoadingDialog(context, "saving");
                      print(AppData().userdetail!.users_id);
                           try{
                          final response = await DioService.post('user_categories', {
                            "userId": AppData().userdetail!.users_id,
                            "categoryIds": listOfIds
                          });
                          print(response);
                          var userData = response['data']['user_categories'];
                          List<UserCategoriesModel> userDetail = userData.map<UserCategoriesModel>((e) => UserCategoriesModel.fromJson(e)).toList();
                         AppData().userCategory=userDetail;
                         showSuccessToast("Your Categories are saved");
                           Navigator.of(context).pop();
                           Navigator.of(context).pop();

                           } catch(e){
                             showSuccessToast("All categories are deselected by user");
                             Navigator.of(context).pop();
                             Navigator.of(context).pop();
                             }


                    },
                    style: TextButton.styleFrom(
                      backgroundColor: globalGreen,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                    child: Text('Save'.toUpperCase(), style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold,),)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}