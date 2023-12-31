import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:evira/data/models/user.dart';
import 'package:evira/utils/constants/strings.dart';
import 'package:get/get.dart';

class WishlistDS {
  final CollectionReference _wishlistCollection =
      FirebaseFirestore.instance.collection(Strings.wishlistCollectionName);
  
  Future<QueryDocumentSnapshot<Object?>?> getUserWishlist(
    String userEmail,
  ) async {
      final userQuerySnapshot = await _wishlistCollection
          .where(Strings.userEmailKeyForWishlistDocument, isEqualTo: userEmail)
          .get();
      if (userQuerySnapshot.docs.length.isEqual(0)) {
        return null;
      }
      return userQuerySnapshot.docs[0];
  }

  Future<void> addToWishlist(String userEmail, String productId) async {
    
      final userWishlist = await getUserWishlist(userEmail);
      if (userWishlist != null) {
        final currentWishlist = (userWishlist.data()
            as Map)[Strings.productsMapKeyForWishlistDocument] as Map;
        if (currentWishlist[productId] == true) {
          return;
        }
        final updatedWishList = {...currentWishlist, productId: true};
        await _wishlistCollection.doc(userWishlist.id).update(
          {Strings.productsMapKeyForWishlistDocument: updatedWishList},
        );
        return;
      }
      await _wishlistCollection.add({
        Strings.userEmailKeyForWishlistDocument: userEmail,
        Strings.productsMapKeyForWishlistDocument: {productId: true},
      });
  }

  Future<void> removeFromWishlist(String userEmail, String productId) async {
      final userWishlist = await getUserWishlist(userEmail);
      if (userWishlist == null) {
        return;
      }
      final currentWishlist = (userWishlist.data()
          as Map)[Strings.productsMapKeyForWishlistDocument] as Map;
      currentWishlist.remove(productId);
      await _wishlistCollection.doc(userWishlist.id).update(
        {Strings.productsMapKeyForWishlistDocument: currentWishlist},
      );
  }

  Future<void> deleteUserWishlist(User user) async {
    final userData = await getUserWishlist(user.getEmail!);
    if (userData == null) {
      return;
    }
    await _wishlistCollection.doc(userData.id).delete();
  }
}
