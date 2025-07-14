import 'package:cybershop/object_box/productModal_objectbox.dart';
import 'package:cybershop/objectbox.g.dart';
import 'package:path_provider/path_provider.dart';

class ObjectBox {
  late final Store _store;
  late final Box<ProductModalObjectBox> productBox;

  ObjectBox(this._store) {
    productBox = Box<ProductModalObjectBox>(_store);
  }

  static Future<ObjectBox> init() async {
    var dir = await getApplicationDocumentsDirectory();
    final store = Store(
      getObjectBoxModel(),
      directory: '${dir.path}/product',
    );

    return ObjectBox(store);
  }

  List<ProductModalObjectBox> getAllProducts() {
    return productBox.getAll();
  }

   int addProducts(ProductModalObjectBox productBoxs) {
    return productBox.put(productBoxs);
  }

}
