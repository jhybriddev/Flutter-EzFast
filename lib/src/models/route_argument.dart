class RouteArgument {
  String id;
  String heroTag;
  dynamic param;
  dynamic secondParam;
  dynamic thirdParam;

  setString(String id) {
    this.id = id;
  }

  RouteArgument({this.id, this.heroTag, this.param, this.secondParam, this.thirdParam});

  @override
  String toString() {
    return '{id: $id, , params : $param ,secondParam : $secondParam heroTag:${heroTag.toString()} }';
  }
}
