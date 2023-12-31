import 'package:evira/controllers/auth-controller.dart';
import 'package:evira/data/data-sources/cart-ds.dart';
import 'package:evira/data/models/firebase-models/user-cart.dart';
import 'package:evira/utils/constants/values.dart';
import 'package:evira/utils/helpers/error-handler.dart';

class CartRepo {
  final CartDS cartDs;
  CartRepo._(this.cartDs);

  static CartRepo? _instance;

  static CartRepo get instance {
    _instance ??= CartRepo._(CartDS());
    return _instance!;
  }

  Future<void> addToCartFromRepo(String productId) async {
    await errorHandler(tryLogic: () async {
      final userEmail = AuthController.get.userData!.getEmail!;
      await cartDs.addToCart(userEmail, productId);
    });
  }

  Future<void> removeFromCartFromRepo(String productId) async {
    await errorHandler(tryLogic: () async {
      final userEmail = AuthController.get.userData!.getEmail!;
      await cartDs.removeFromCart(userEmail, productId);
    });
  }

  Future<void> removeFromCartPermanently(String productId) async {
    await errorHandler(tryLogic: () async {
      final userEmail = AuthController.get.userData!.getEmail!;
      await cartDs.removeFromCartPermanently(userEmail, productId);
    });
  }

  Future<UserCart?> getUserCartFromRepo() async {
    return await errorHandler<UserCart?>(tryLogic: () async {
      final userEmail = AuthController.get.userData!.getEmail!;
      final userCartDoc = await cartDs.getUserCart(userEmail);
      if (userCartDoc == null) {
        return null;
      }
      final userCartData = userCartDoc.data() as Map<String, dynamic>;
      return UserCart.fromJson(userCartData);
    });
  }

  Future<void> cleanUpUserCart() async {
    await errorHandler(tryLogic: () async {
      final userEmail = AuthController.get.userData!.getEmail!;
      await cartDs.cleanUpUserCart(userEmail);
    });
  }

  Future<void> deleteUserCart() async {
    await errorHandler(
      tryLogic: () async {
        final user = AuthController.get.userData!;
        await cartDs.deleteUserCart(user);
      },
      secondsToCancel: Values.medlongOperationsSecondsToCancle,
    );
  }
}
