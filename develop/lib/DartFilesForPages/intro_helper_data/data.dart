import 'package:flutter/material.dart';


class SliderModel{

  String imageAssetPath;
  String title;
  String desc;

  SliderModel({required this.imageAssetPath,required this.title,required this.desc});

  void setImageAssetPath(String getImageAssetPath){
    imageAssetPath = getImageAssetPath;
  }

  void setTitle(String getTitle){
    title = getTitle;
  }

  void setDesc(String getDesc){
    desc = getDesc;
  }

  String getImageAssetPath(){
    return imageAssetPath;
  }

  String getTitle(){
    return title;
  }

  String getDesc(){
    return desc;
  }

}


List<SliderModel> getSlides(){

  List<SliderModel> slides = [];
  SliderModel sliderModel;


  sliderModel = new SliderModel(
      imageAssetPath: "assets/splash1.png",
      title: "Smart Navigator",
      desc: "Smart Location Based Recommendation With Route Planner"
  );
  slides.add(sliderModel);

  //2
  sliderModel = new SliderModel(
      imageAssetPath: "assets/splash2.png",
      title: "Smart Assistant",
      desc: "AI Based Chatbot to facilitate native speakers" )
  ;
  slides.add(sliderModel);

  //3
  sliderModel = new SliderModel(
      imageAssetPath: "assets/splash3.png",
      title: "Smart Visionary",
      desc: "Virtual Reality For Mesmerizing Experience " )
  ;
  slides.add(sliderModel);

  //4
  sliderModel = new SliderModel(
      imageAssetPath: "assets/splash4.png",
      title: "Smart Recognition",
      desc: "Effective Place Recognition" )
  ;
  slides.add(sliderModel);

  return slides;
}