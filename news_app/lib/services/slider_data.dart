import 'package:news_app/model/slider_model.dart';

List<SliderModel> getSliderData() {
  List<SliderModel> sliderList = [];

  SliderModel sliderModel =
      new SliderModel(name: "Business", image: "assets/images/business.jpg");
  sliderList.add(sliderModel);

  sliderModel = new SliderModel(
      name: "Entertainment", image: "assets/images/entertainment.jpg");

  sliderList.add(sliderModel);

  sliderModel =
      new SliderModel(name: "General", image: "assets/images/general.jpg");

  sliderList.add(sliderModel);

  sliderModel =
      new SliderModel(name: "Health", image: "assets/images/health.jpg");

  sliderList.add(sliderModel);

  sliderModel =
      new SliderModel(name: "Science", image: "assets/images/science.jpg");

  sliderList.add(sliderModel);

  sliderModel =
      new SliderModel(name: "Sports", image: "assets/images/sports.jpg");

  sliderList.add(sliderModel);

  return sliderList;
}
