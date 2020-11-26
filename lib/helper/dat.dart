import 'package:news/model/catmodel.dart';

List<Catmodel> getModel() {
  List<Catmodel> cam = new List<Catmodel>();
  Catmodel catmodel = new Catmodel();
  catmodel.cateogryname = "National";
  catmodel.cateogryimage = 'assets/nat.jpg';
  cam.add(catmodel);
  catmodel = new Catmodel();
  catmodel.cateogryname = "general";
  catmodel.cateogryimage = "assets/int.jpg";
  cam.add(catmodel);

  catmodel = new Catmodel();
  catmodel.cateogryname = "health";
  catmodel.cateogryimage = "assets/cov.jpg";
  cam.add(catmodel);

  catmodel = new Catmodel();
  catmodel.cateogryname = "business";
  catmodel.cateogryimage = 'assets/bus.jpg';
  cam.add(catmodel);

  catmodel = new Catmodel();
  catmodel.cateogryname = "entertainment";
  catmodel.cateogryimage = "assets/ent.jpg";
  cam.add(catmodel);

  catmodel = new Catmodel();
  catmodel.cateogryname = "sports";
  catmodel.cateogryimage = "assets/spo.jpg";
  cam.add(catmodel);

  catmodel = new Catmodel();
  catmodel.cateogryname = "science";
  catmodel.cateogryimage = "assets/wea.jpg";
  cam.add(catmodel);

  return cam;
}
