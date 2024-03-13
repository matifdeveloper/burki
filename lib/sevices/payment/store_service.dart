/*
********************************************************************************

    _____/\\\\\\\\\_____/\\\\\\\\\\\\\\\__/\\\\\\\\\\\__/\\\\\\\\\\\\\\\_
    ___/\\\\\\\\\\\\\__\///////\\\/////__\/////\\\///__\/\\\///////////__
    __/\\\/////////\\\_______\/\\\___________\/\\\_____\/\\\_____________
    _\/\\\_______\/\\\_______\/\\\___________\/\\\_____\/\\\\\\\\\\\_____
    _\/\\\\\\\\\\\\\\\_______\/\\\___________\/\\\_____\/\\\///////______
    _\/\\\/////////\\\_______\/\\\___________\/\\\_____\/\\\_____________
    _\/\\\_______\/\\\_______\/\\\___________\/\\\_____\/\\\_____________
    _\/\\\_______\/\\\_______\/\\\________/\\\\\\\\\\\_\/\\\_____________
    _\///________\///________\///________\///////////__\///______________

    Created by Muhammad Atif on 3/13/2024.
    Portfolio https://atifnoori.web.app.
    IsloAI

 *********************************************************************************/

import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter_inapp_purchase/flutter_inapp_purchase.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../utils/utils.dart';

class StoreService {
  /// We want singleton object of ``[StoreService]`` so create private constructor
  ///
  /// Use StoreService as ``StoreService.instance``
  StoreService._private();

  static final StoreService instance = StoreService._private();

  /// logged in [user]'s [premium] status
  bool _isProUser = false;
  bool get isProUser => _isProUser;

  /// To listen the [status] of [connection] between app and the billing server
  late StreamSubscription<ConnectionResult> _connectionSubscription;

  /// To listen the status of the purchase made inside or outside of the app (App Store / Play Store)
  ///
  /// If [status] is not [error] then app will be notified by this stream
  late StreamSubscription<PurchasedItem?> _purchaseUpdatedSubscription;

  /// To listen the [errors] of the purchase
  late StreamSubscription<PurchaseResult?> _purchaseErrorSubscription;

  /// List of [product] ids you want to fetch
  late List<String> _subscriptionIds;
  set subscriptionIds( subscriptionIds){
    _subscriptionIds = subscriptionIds;
  }

  List<String> get subscriptionIds => _subscriptionIds;

  /// All available [products] will be store in this list
  List<IAPItem> _subscriptionItems = [];
  List<IAPItem> get subscriptionItems {
    try {
      _subscriptionItems;
      return _subscriptionItems;
    } catch (e) {
      return _subscriptionItems;
    }
  }

  /// All past purchases will be store in this list
  late List<PurchasedItem> _pastPurchases;

  /// view of the app will subscribe to this to get notified
  /// when premium status of the user changes
  final ObserverList<Function> _proStatusChangedListeners =
      ObserverList<Function>();

  /// view of the app will subscribe to this to get errors of the purchase
  final ObserverList<Function(String)> _errorListeners =
      ObserverList<Function(String)>();

  /// view can subscribe to _proStatusChangedListeners using this method
  addToProStatusChangedListeners(Function callback) {
    _proStatusChangedListeners.add(callback);
  }

  /// view can cancel to _proStatusChangedListeners using this method
  removeFromProStatusChangedListeners(Function callback) {
    _proStatusChangedListeners.remove(callback);
  }

  /// view can subscribe to _errorListeners using this method
  addToErrorListeners(dynamic Function(String) callback) {
    _errorListeners.add(callback);
  }

  /// view can cancel to _errorListeners using this method
  removeFromErrorListeners(dynamic Function(String) callback) {
    _errorListeners.remove(callback);
  }

  /// Call this method to notify all the subscribers of _proStatusChangedListeners
  void _callProStatusChangedListeners(String message) {
    FlutterLogger.success(message);
    for (var callback in _proStatusChangedListeners) {
      callback();
    }
  }

  /// Call this method to notify all the subscribers of _errorListeners
  void _callErrorListeners(String error) {
    FlutterLogger.error(error);
    for (var callback in _errorListeners) {
      callback(error);
    }
  }

  /// Call this method at the startup of you app to initialize connection
  /// with billing server and get all the necessary data
  Future<void> initConnection() async {
    try {
      final initResult = await FlutterInappPurchase.instance.initialize();
      FlutterLogger.info(initResult ?? 'unknown');
    } catch (e) {
      FlutterLogger.error(e.toString());
    }

    _connectionSubscription =
        FlutterInappPurchase.connectionUpdated.listen((connected) {});

    _purchaseUpdatedSubscription =
        FlutterInappPurchase.purchaseUpdated.listen(_handlePurchaseUpdate);

    _purchaseErrorSubscription =
        FlutterInappPurchase.purchaseError.listen(_handlePurchaseError);

    _getSubscriptionItems();
  }

  /// call when user close the app
  void dispose() {
    _connectionSubscription.cancel();
    _purchaseErrorSubscription.cancel();
    _purchaseUpdatedSubscription.cancel();
    FlutterInappPurchase.instance.finalize();
  }

  void _handlePurchaseError(PurchaseResult? purchaseError) {
    _callErrorListeners(purchaseError!.message!);
  }

  /// Called when new updates arrives at ``purchaseUpdated`` stream
  void _handlePurchaseUpdate(PurchasedItem? productItem) async {
    if (Platform.isAndroid) {
      await _handlePurchaseUpdateAndroid(productItem!);
    } else {
      await _handlePurchaseUpdateIOS(productItem!);
    }
  }

  /// Handle iOS Purchase
  Future<void> _handlePurchaseUpdateIOS(PurchasedItem purchasedItem) async {
    switch (purchasedItem.transactionStateIOS) {
      case TransactionState.deferred:
        // Edit: This was a bug that was pointed out here : https://github.com/dooboolab/flutter_inapp_purchase/issues/234
        // FlutterInAppPurchase.instance.finishTransaction(purchasedItem);
        break;
      case TransactionState.failed:
        _callErrorListeners("Transaction Failed");
        break;
      case TransactionState.purchased:
        await _verifyAndFinishTransaction(purchasedItem);
        break;
      case TransactionState.purchasing:
        break;
      case TransactionState.restored:
        FlutterInappPurchase.instance.finishTransaction(purchasedItem);
        FlutterInappPurchase.instance.finishTransactionIOS(
          purchasedItem.transactionId!,
        );

        break;
      default:
    }
  }

  /// three purchase state https://developer.android.com/reference/com/android/billingclient/api/Purchase.PurchaseState
  /// 0 : UNSPECIFIED_STATE
  /// 1 : PURCHASED
  /// 2 : PENDING
  Future<void> _handlePurchaseUpdateAndroid(PurchasedItem purchasedItem) async {
    switch (purchasedItem.purchaseStateAndroid) {
      case PurchaseState.purchased:
        if (!purchasedItem.isAcknowledgedAndroid!) {
          await _verifyAndFinishTransaction(purchasedItem);
        }
        break;
      default:
        _callErrorListeners("Something went wrong");
    }
  }

  /// Call this method when status of purchase is success
  /// Call API of your back end to verify the receipt
  /// back end has to call billing server's API to verify the purchase token
  _verifyAndFinishTransaction(PurchasedItem purchasedItem) async {
    bool isValid = false;
    try {
      if (Platform.isAndroid) {
        await FlutterInappPurchase.instance.acknowledgePurchaseAndroid(
          purchasedItem.purchaseToken!,
        );
      }
      // Call API
      isValid = true; //await _verifyPurchase(purchasedItem);
    } on Exception {
      _callErrorListeners("Something went wrong");
      return;
    }

    if (isValid) {
      if (Platform.isAndroid) {
        FlutterInappPurchase.instance.finishTransaction(purchasedItem);
      } else {
        FlutterInappPurchase.instance.finishTransaction(purchasedItem);
        FlutterInappPurchase.instance.finishTransactionIOS(
          purchasedItem.transactionId!,
        );
      }
      _isProUser = true;
      _callProStatusChangedListeners('Purchased success');
    }/*  else {
      _callErrorListeners("Verification failed");
    }*/
  }

  /// Get subscription items
  Future<void> _getSubscriptionItems() async {
    List<IAPItem> items =
        await FlutterInappPurchase.instance.getSubscriptions(_subscriptionIds);
    _subscriptionItems = [];
    for (var item in items) {
      _subscriptionItems.add(item);
    }

    List<IAPItem> sortedList = List.from(_subscriptionItems);

    // Sort the list based on the custom order defined in 'subscriptionIds'
    sortedList.sort((a, b) => _subscriptionIds.indexOf(a.productId!).compareTo(
          _subscriptionIds.indexOf(b.productId!),
        ));

    // Sort the list based on the custom order defined in 'subscriptionIds'
    _subscriptionItems = sortedList;
  }

  /// Restore past purchases
  Future<Map<String, dynamic>> restore(context) async {
    List<PurchasedItem>? purchasedItems =
        await FlutterInappPurchase.instance.getAvailablePurchases();

    if (purchasedItems != null) {
      for (var purchasedItem in purchasedItems) {
        bool isValid = false;

        if (Platform.isAndroid) {
          Map map = json.decode(purchasedItem.transactionReceipt!);
          // if your app missed finishTransaction due to network or crash issue
          // finish transactions
          if (!map['acknowledged']) {
            isValid = true; //await _verifyPurchase(purchasedItem);
            if (isValid) {
              FlutterInappPurchase.instance.finishTransaction(purchasedItem);
              _callProStatusChangedListeners('Purchased success');
            }
            _isProUser = true;
          } else {
            _isProUser = true;
            _callProStatusChangedListeners('Purchased success');
          }
        } else if (Platform.isIOS) {
          FlutterInappPurchase.instance.finishTransaction(purchasedItem);
          FlutterInappPurchase.instance.finishTransactionIOS(
            purchasedItem.transactionId!,
          );
          _callProStatusChangedListeners('Purchased success');
        }

        FlutterLogger.info(purchasedItem);
      }

      _pastPurchases = [];
      _pastPurchases.addAll(purchasedItems);

      return {'result': true, 'message': 'Purchases restored successfully'};
    } else {
      return {'result': false, 'message': 'No previous purchases available'};
    }
  }

  /// Buy Subscription
  Future<Map<String, dynamic>> buySubscription(IAPItem item) async {
    try {
      await FlutterInappPurchase.instance.requestSubscription(item.productId!);
      return {'result': true, 'message': 'Subscription added successfully'};
    } catch (error) {
      throw error.toString();
    }
  }

  /// Open subscription management in app store
  Future<void> openSubscriptionManagementPage() async {
    // Replace with the actual URL for subscription management
    final url = Platform.isAndroid
        ? 'https://play.google.com/store/account/subscriptions'
        : 'https://apps.apple.com/account/subscriptions';
    final androidUrl = Uri.parse(url);

    // On iOS, use the Apple App Store URL
    if (await canLaunchUrl(androidUrl)) {
      await launchUrl(androidUrl);
    } else {
      // Handle the case where the URL can't be launched
      throw 'can\'t launch the url';
    }
  }

}
