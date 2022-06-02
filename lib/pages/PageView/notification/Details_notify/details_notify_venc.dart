import 'package:flutter/material.dart';

class DetailsNotifyVenc extends StatefulWidget {
  const DetailsNotifyVenc({Key? key}) : super(key: key);

  @override
  State<DetailsNotifyVenc> createState() => _DetailsNotifyVencState();
}

class _DetailsNotifyVencState extends State<DetailsNotifyVenc> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: true,
          backgroundColor: Colors.blue.shade900,
          title: Text("Vencimentos"),
          centerTitle: true,
        ),
        body:  SingleChildScrollView(
          physics: ScrollPhysics(),
          child: Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            margin: EdgeInsets.symmetric(horizontal: 20,vertical: 20),
            child: Column(
              children: [
                Text("Vencimento 1",textAlign: TextAlign.center,style: TextStyle(fontSize: 25,color: Colors.blue.shade900),),
                Text("o vencimento 1 está próximo",textAlign: TextAlign.center,style: TextStyle(fontSize: 15,color: Colors.blue),),
                Container(
                  margin: EdgeInsets.symmetric(vertical: 10),
                  child: Text(
                      " Lorem ipsum dolor sit amet consectetur adipiscing elit augue sapien"
                          " viverra, turpis dictum porttitor eu blandit sodales purus "
                          "laoreet. Natoque vitae hendrerit primis quis blandit lorem "
                          "felis platea taciti, sem nam faucibus erat neque tortor "
                          "himenaeos fermentum, sodales eros facilisi luctus fusce "
                          "conubia eu magna. Malesuada ligula quis senectus litora "
                          "nullam nec a nibh diam, aliquet massa montes dignissim "
                          "cubilia velit hac ante. Nec ut porta efficitur elit sapien "
                          "mollis litora eu lorem at, non augue hendrerit iaculis "
                          "semper purus a curae ante lectus consequat, proin interdum "
                          "mauris donec taciti pharetra dictumst luctus odio. Mauris "
                          "vulputate adipiscing duis etiam nisl habitasse tristique, "
                          "natoque dolor maximus lacus sed amet, mus litora sem tincidunt "
                          "luctus tempor. Justo posuere elementum vehicula ac praesent"
                          "volutpat amet id finibus, nunc litora porta porttitor sit "
                          "proin ad natoque euismod magnis, maecenas nisl laoreet"
                          "sociosqu parturient ut facilisis nam.\n"
                          " Nostra donec sit elit suspendisse sed vel ultricies "
                          "tincidunt, tempus urna accumsan conubia nulla parturient"
                          "duis aliquet, turpis ac curabitur penatibus dui molestie."
                      ,softWrap: true,style: TextStyle(fontSize: 18,color: Colors.blue.shade900),textAlign: TextAlign.left),
                )

              ],
            ),
          ),
        )
    );
  }
}
