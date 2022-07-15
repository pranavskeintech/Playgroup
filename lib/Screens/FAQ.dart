import 'package:flutter/material.dart';
import 'package:playgroup/Utilities/Strings.dart';


class FrequentlyAskedQuestions extends StatefulWidget {
  const FrequentlyAskedQuestions({ Key? key }) : super(key: key);

  @override
  State<FrequentlyAskedQuestions> createState() => _FrequentlyAskedQuestionsState();
}

class _FrequentlyAskedQuestionsState extends State<FrequentlyAskedQuestions> {


  List<int> extendedIndex = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Strings.appThemecolor,
        title: Text("FAQ"),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back_sharp),
        ),
      ),
      body: FAQBody(),
    );
  }

  FAQBody()
  {
    return Container(
      padding: EdgeInsets.all(28),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Frequently asked questions",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18),),
          SizedBox(height: 10,),
          Expanded(
            child: ListView.builder(
                                itemCount: 5,
                                scrollDirection: Axis.vertical,
                                itemBuilder: ((context, index) {
                                  return Container(
                                    decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(5)),                                    color: Colors.grey.withOpacity(0.1),
),
                                    margin: EdgeInsets.only(top:5,bottom: 5),
                                    padding: EdgeInsets.only(left: 10,),
                                    child: Column(
                                      children: [
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text("Text"),
                                            IconButton(onPressed: (){

                                              setState(() {

                                                if(extendedIndex.contains(index))
                                                {
                                                  extendedIndex.remove(index);
                                                }
                                                else
                                                {
                                                  extendedIndex.add(index);
                                                }
                                              });

                                            }, icon: Icon(Icons.add,size: 18,))
                                          ],
                                        ),
                                        
                                        extendedIndex.contains(index) ? Container(
                                          padding: EdgeInsets.only(bottom: 10,right: 10),
                                          child: Text("Contrary to popular belief, Lorem Ipsum is not simply random text. It has roots in a piece of classical Latin literature from 45 BC, making it over 2000 years old. Richard McClintock, a Latin professor at Hampden-Sydney College in Virginia, looked up one of the more obscure Latin words, consectetur, from a Lorem Ipsum passage, and going through the cites of the word in classical literature, discovered the undoubtable source",style: TextStyle(),textAlign: TextAlign.justify,)):SizedBox()
                                      ],
                                    ),
                                  );
                                })),
          ),
        ],

      ),
    );
  }
}