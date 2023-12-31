import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:evira/controllers/products-controller.dart';
import 'package:evira/data/models/firebase-models/user-wishlist.dart';
import 'package:evira/data/models/product.dart';
import 'package:evira/data/repositories/wishlist-repo.dart';
import 'package:get/get.dart';

class WishlistController extends GetxController {
  late final WishlistRepo _wishlistRepo;
  UserWishlist? _currentUserWishlist;
  List<QueryDocumentSnapshot<Object?>> _wishlistProducts = [];

  List<QueryDocumentSnapshot<Object?>> get wishlistProducts {
    return [..._wishlistProducts];
  }

  @override
  void onInit() {
    super.onInit();
    _wishlistRepo = WishlistRepo.instance;
  }

  UserWishlist? get currentUserWishlist {
    return _currentUserWishlist;
  }

  static WishlistController get get => Get.find();

  Future<void> getUserWishlist() async {
    final userWishlist = await _wishlistRepo.getUserWishlistFromRepo();
    if (userWishlist == null || userWishlist.wishlist.isEmpty) {
      return;
    }
    _currentUserWishlist = userWishlist;
    final data = await ProductController.get.getWishlistProducts(
      userWishlist.wishlist.keys.map((e) => int.parse(e)).toList(),
    );
    _wishlistProducts = data.docs;
  }

  Future<void> removeFromWishlist(
    String productId,
  ) async {
    await _wishlistRepo.removeFromWishlist(productId);
    _wishlistProducts.removeWhere((element) {
      return Product.fromJson(element.data() as Map).id == int.parse(productId);
    });
    _currentUserWishlist!.wishlist.remove(productId);
  }

  Future<void> addToWishlist(String productId) async {
    await _wishlistRepo.addToWishlist(productId);
    await getUserWishlist();
  }

  resetWishlistController() {
    _currentUserWishlist = null;
    _wishlistProducts = [];
  }
}
