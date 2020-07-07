import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provide/provide.dart';
import '../../Provide/cart.dart';
import '../../Provide/details_info.dart';
import '../../Provide/CurrentIndexProvide.dart';

class DetailsBottom extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    var goodsInfo = Provide.value<DetailsInfoProvide>(context).detailsModel;
    var goodsName =goodsInfo.longName;
    var goodsId =goodsInfo.goodsId;
    var count =1;
    var price =goodsInfo.marketPrice;
    var images= goodsInfo.imageRects.first;

    return Container(
       width:ScreenUtil().setWidth(750),
       color: Colors.white,
       height: ScreenUtil().setHeight(80),
       child: Row(
         children: <Widget>[
           Stack(
             children: <Widget>[
                InkWell(
                  onTap: (){
                      Provide.value<CurrentIndexProvide>(context).changeIndex(2);
                        Navigator.pop(context);
                  },
                  child: Container(
                      width: ScreenUtil().setWidth(110) ,
                      alignment: Alignment.center,
                      child:Icon(
                            Icons.shopping_cart,
                            size: 35,
                            color: Colors.lightBlueAccent,
                          ), 
                    ) ,
                ),
                Provide<CartProvide>(
                  builder: (context,child,val){
                    int  goodsCount = Provide.value<CartProvide>(context).allGoodsCount;
                    return  Positioned(
                        top:0,
                        right: 10,
                        child: Container(
                          padding:EdgeInsets.fromLTRB(6, 3, 6, 3),
                          decoration: BoxDecoration(
                            color:Colors.lightBlueAccent,
                            border:Border.all(width: 2,color: Colors.white),
                            borderRadius: BorderRadius.circular(12.0)
                          ),
                          child: Text(
                            '${goodsCount}',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: ScreenUtil().setSp(22)
                            ),
                          ),
                        ),
                      ) ;
                  },
                )
             ],
           ),

           InkWell(
             onTap: ()async {
                 await Provide.value<CartProvide>(context).save(goodsId,goodsName,count,price,images);
             },
             child: Container(
               alignment: Alignment.center,
               width: ScreenUtil().setWidth(320),
               height: ScreenUtil().setHeight(80),
               color: Colors.green,
               child: Text(
                 '加入购物车',
                 style: TextStyle(color: Colors.white,fontSize: ScreenUtil().setSp(28)),
               ),
             ) ,
           ),
           InkWell(
             onTap: ()async{
                await Provide.value<CartProvide>(context).remove();
              },
             child: Container(
               alignment: Alignment.center,
               width: ScreenUtil().setWidth(320),
               height: ScreenUtil().setHeight(80),
               color: Colors.blueAccent,
               child: Text(
                 '马上购买',
                 style: TextStyle(color: Colors.white,fontSize: ScreenUtil().setSp(28)),
               ),
             ) ,
           ),
         ],
       ),
    );
  }
}