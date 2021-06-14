import 'dart:async';
import 'dart:convert';

import 'package:crypto/crypto.dart';
import 'package:darty_commons/darty_commons.dart';
import 'package:flutter/cupertino.dart';
import 'package:jomla/Core/data/models/requests/confirm_checkout_request.dart';
import 'package:jomla/Core/data/models/requests/payment_request.dart';
import 'package:jomla/Core/data/models/responses/data/cart_data/cart_data.dart';
import 'package:jomla/Core/data/models/responses/data/partner_data.dart';
import 'package:jomla/Core/data/models/responses/data/payment_methods_data.dart';
import 'package:jomla/Core/data/repositories/network/jomla_api_repository/resources.dart';
import 'package:jomla/Core/domain/blocs/global/global_bloc.dart';
import 'package:jomla/Core/error/failures.dart';
import 'package:jomla/Core/utils/card_card_validator.dart';
import 'package:jomla/features/CheckOut/data/models/SaveQuotationModel.dart';
import 'package:jomla/features/CheckOut/data/models/confirm_payment_request.dart';
import 'package:jomla/features/CheckOut/data/models/installments_reponse_model.dart';
import 'package:jomla/features/CheckOut/data/models/installments_request_model.dart';
import 'package:jomla/features/CheckOut/data/models/success_model.dart';
import 'package:jomla/features/CheckOut/domain/use_cases/checkout_use_case.dart';
import 'package:jomla/features/MyCart/domain/use_cases/cart_use_case.dart';
import 'package:jomla/features/NewCard/domain/use_cases/payment_constants.dart';
import 'package:jomla/features/PaymentMethods/presentation/widgets/payment_methods_widget.dart';
import 'package:sortedmap/sortedmap.dart';
import 'package:uuid/uuid.dart';
import 'package:wifi/wifi.dart';

import '../../../../Core/domain/blocs/base/base_bloc.dart';
import 'general_checkout_event.dart';
import 'general_checkout_state.dart';

class GeneralCheckoutBloc
    extends BaseBloc<GeneralCheckoutEvent, GeneralCheckoutState> {
  final CheckoutUseCase _checkoutUseCase;
  final CartUseCase _cartUseCase;
  ItemPartner selectedPartner;
  IssuerDetail selectedIssuer;
  CreditCard selectedCreditCard;
  int selectedPaymentType = CARD;
  GlobalBloc globalBloc;
  bool isPayOnDelivery = false;
  bool isPayWithInstalment = false;
  bool isSuccessPaymentProcess = false;
  bool isPartialDelivery = false;
  ValueNotifier<InstallmentsResponseModel> installmentData =
      ValueNotifier(null);
  ValueNotifier<PlanDetails> selectedPlan = ValueNotifier(null);
  StreamSubscription<Map<dynamic, dynamic>> _paymentStatusSubscription;
  StreamController<CartData> _updateOrderController =
      StreamController.broadcast();
  CartData cartData;

  Stream<CartData> get updateOrderStream => _updateOrderController.stream;

  GeneralCheckoutBloc(this.globalBloc, this._checkoutUseCase, this._cartUseCase)
      : super(InitGeneralCheckoutState()) {
    _subscribePaymentProcessStatus();
  }

  GeneralCheckoutState get initialState => InitGeneralCheckoutState();

  _subscribePaymentProcessStatus() {
    // _paymentStatusSubscription =
    //     _paymentUseCase.getPaymentStatusStream().listen((status) async {
    //   print('STATus $status');
    //   switch (status[PaymentConstants.paymentStatus]) {
    //     case PaymentConstants.startPayment:
    //       showLoading();
    //       break;
    //     case PaymentConstants.successPayment:
    //
    //       //_confirmCheckoutAfterPayByCard();
    //       break;
    //     case PaymentConstants.errorPayment:
    //       showErrorDialog(
    //           localizationKey: status[PaymentConstants.paymentMessage] ??
    //               "something_went_wrong");
    //       hideLoading();
    //       break;
    //   }
    // });
  }

  confirmCheckoutAfterPayByCard(String fortid, String merchantRefrence) async {
    try {
      showLoading();
      firebaseAnalytics.purchaseSuccessfulEvent(cartData.amountTotal);
      facebookAnalytics.purchaseSuccessfulEvent(cartData.amountTotal);
      isSuccessPaymentProcess = true;
      merchantRefrence.log(className: "GeneralCheckOutBloc");
      await _checkoutUseCase.saveQuotation(SaveQuotationModel(
        fort_id: fortid,
        isPayByCard: true,
        isPartialDelivery: globalBloc.managingCartUseCase.isPartialDelivery(),
        merchant_refrence: merchantRefrence,
        orderId: sharedPreferences.getOrderId(),
        partnerShippingId: selectedPartner.id,
        payment_method: '${selectedCreditCard.paymentBrand}',
      ));
      var failureOrConfirmedCheckOut = await _checkoutUseCase.confirmCheckout(
          ConfirmCheckoutRequest(
              sharedPreferences.getOrderId(),
              selectedPartner.id,
              true,
              globalBloc.managingCartUseCase.isPartialDelivery()),
          PaymentRequest(
              '${selectedCreditCard.paymentBrand}'
              '(${selectedCreditCard.number.substring(selectedCreditCard.number.length - 4)})',
              sharedPreferences.getOrderId(),
              fort_id: fortid,
              merchant_refrence: merchantRefrence));
      failureOrConfirmedCheckOut.fold((failure) {
        if (failure is TimeOutFailure) {
          add(ErrorConfirmingEvent(failure, "CreditCard"));
        } else if (failure is ServerFailure) {
          add(ErrorConfirmingEvent(failure, "CreditCard"));
        }
      }, (r) async {
        await _clearCartData();
        await _checkoutUseCase.deleteQuotationID();
        add(SuccessPurchaseGeneralCheckoutEvent("Sales Order"));
      });

      hideLoading();
    } catch (e) {
      showErrorDialog(localizationKey: '${e}');
      rethrow;
    } finally {
      hideLoading();
    }
  }

  confirmCheckoutAfterPayByApplePay(String merchantRefrence) async {
    try {
      showLoading();
      firebaseAnalytics.purchaseSuccessfulEvent(cartData.amountTotal);
      facebookAnalytics.purchaseSuccessfulEvent(cartData.amountTotal);
      isSuccessPaymentProcess = true;
      await _checkoutUseCase.saveQuotation(SaveQuotationModel(
        isPayByCard: false,
        isPartialDelivery: globalBloc.managingCartUseCase.isPartialDelivery(),
        merchant_refrence: merchantRefrence,
        orderId: sharedPreferences.getOrderId(),
        partnerShippingId: selectedPartner.id,
        payment_method: '${selectedCreditCard.paymentBrand}',
      ));

      var failureOrConfirmedCheckOut = await _checkoutUseCase.confirmCheckout(
          ConfirmCheckoutRequest(
              sharedPreferences.getOrderId(),
              selectedPartner.id,
              true,
              globalBloc.managingCartUseCase.isPartialDelivery(),
              paymentType: APPLEPAY),
          PaymentRequest('PayWithApplePay', sharedPreferences.getOrderId(),
              merchant_refrence: merchantRefrence));
      failureOrConfirmedCheckOut.fold((failure) {
        if (failure is TimeOutFailure) {
          add(ErrorConfirmingEvent(failure, "APPLEPAY"));
        } else if (failure is ServerFailure) {
          add(ErrorConfirmingEvent(failure, "APPLEPAY"));
        }
      }, (r) async {
        await _clearCartData();
        await _checkoutUseCase.deleteQuotationID();
        add(SuccessPurchaseGeneralCheckoutEvent("Sales Order"));
      });
      hideLoading();
    } catch (e) {
      showErrorDialog(localizationKey: '${e.message}');
    } finally {
      hideLoading();
    }
  }

  @override
  Stream<GeneralCheckoutState> mapEventToState(
      GeneralCheckoutEvent event) async* {
    if (event is SuccessPurchaseGeneralCheckoutEvent) {
      cartData.amountTotal.toString().log(className: "CheckoutWidget");
      event.orderType.toString().log(className: "CheckoutWidget");
      cartData.id.toString().log(className: "CheckoutWidget");
      globalBloc.firebaseAnalytics.purchase(
          cartData.id.toString(), cartData.amountTotal, event.orderType);
      globalBloc.facebookAnalytics.purchase(
          cartData.id.toString(), cartData.amountTotal, event.orderType);
      yield SuccessPurchaseGeneralCheckoutState(event.orderType);
    }
    if (event is ConfirmCvvEvent) {
      if (event.issuerDetail != null) {
        _payByCardWithInstalment(
            event.cvv, event.issuerDetail, event.selectedPlanCode);
      } else {
        _payByCard(event.cvv);
      }
    }
    if (event is ShowLoadingPageEvent) {
      yield ShowLoadingPageState();
    }
    if (event is CheckoutEvent) {
      if (selectedPaymentType == CARD) {
        if (_checkoutDataIsValid()) {
          if (isPayWithInstalment) {
            add(ShowInstallmentsDialogEvent());
          } else {
            yield ShowCvvDialogState();
          }
        } else {
          _handleValidationCheckout();
        }
      } else if (selectedPaymentType == BANK_TRANSFER) {
        add(ShowLoadingPageEvent());
        _payByBankTransfer();
      } else if (selectedPaymentType == PAYONDELIVERY) {
        "PayOnDelivery".log(className: "GeneralCheckOutBloc");
        add(ShowLoadingPageEvent());
        _payOnDelivery();
      } else if (selectedPaymentType == APPLEPAY) {
        add(ShowLoadingPageEvent());
        _payWithApplePay();
      }
      // await _payOnDelivery();
    }

    if (event is ShowCvvDialogEvent) yield ShowCvvDialogState();
    if (event is GotTokenEvent) {
      String ip = await Wifi.ip;
      _makePurchase({
        PaymentConstants.customerEmail: globalBloc.partnerData.email,
        PaymentConstants.customer_ip: ip,
        PaymentConstants.amount:
            (double.parse(cartData.amountTotal) * 100).toInt(),
        PaymentConstants.currency: "SAR",
        PaymentConstants.merchantReference: event.model.merchant_reference,
        PaymentConstants.customer_name: globalBloc.partnerData.name,
        PaymentConstants.merchant_identifier: MERCHANT_IDENTIFIER,
        PaymentConstants.access_code: ACCESS_CODE,
        PaymentConstants.lang: "en",
      }, event.model);
    }
    if (event is ShowHtmlDialogEvent) {
      yield ShowHtmlDialogState(event.html, event.fortID);
    }
    if (event is FailurePurchaseGeneralCheckoutEvent) {
      showErrorDialog(localizationKey: '${event.message}');
    }
    if (event is ErrorConfirmingEvent) {
      if (event.failure is TimeOutFailure) {
        yield TimeOutErrorState();
      } else {
        yield ServerErrorState();
      }
    }
    if (event is ShowInstallmentsDialogEvent) {
      yield ShowInstallmentsDialogState();
    }
    if (event is TempPlanSelectedEvent) {
      selectedPlan.value = installmentData
          .value.installment_detail.issuer_detail
          .firstWhere((element) =>
              element.issuer_code == event.issuerDetail.issuer_code)
          .plan_details
          .firstWhere((element) =>
              element.plan_code == event.selectedPlanCode.plan_code);
    }

    if (event is GeneralErrorEvent) {
      yield GeneralErrorState();
    }

    if (event is PayWithInstallmentEvent) {
      selectedIssuer = event.issuerDetail;
      yield ShowCvvDialogState(
          issuerDetail: event.issuerDetail,
          planDetails: event.selectedPlanCode);
    }

    if (event is SelectedPlanEvent) {
      compareWithSelectedCard(event.issuerDetail, event.selectedPlanCode);
    }
  }

  _payByCard(String cvv) async {
    if (_checkoutDataIsValid() && CreditCardValidator.validateCvv(cvv)) {
      try {
        showLoading();
        String ip = await Wifi.ip;
        _payDirect({
          PaymentConstants.customerEmail: globalBloc.partnerData.email,
          PaymentConstants.customer_ip: ip,
          PaymentConstants.amount:
              (double.parse(cartData.amountTotal) * 100).toInt(),
          PaymentConstants.currency: "SAR",
          PaymentConstants.merchantReference: cartData.id.toString(),
          PaymentConstants.customer_name: globalBloc.partnerData.name,
          PaymentConstants.merchant_identifier: MERCHANT_IDENTIFIER,
          PaymentConstants.access_code: ACCESS_CODE,
          PaymentConstants.cardCvv: cvv,
          PaymentConstants.lang: "en",
        }, selectedCreditCard);
      } catch (ex) {
        showErrorDialog(localizationKey: ex);
        hideLoading();
        rethrow;
      } finally {
        // hideLoading();
      }
    } else {
      _handleValidationCheckout();
    }
  }

  _payWithApplePay() async {
    showLoading();
    var deviceId = await _checkoutUseCase.getDeviceId('en');
    PaymentItem item = PaymentItem(
        name: "Jomla user ${globalBloc.partnerData.name} Order",
        price: double.parse(cartData.amountTotal));
    var result = await _checkoutUseCase.payWithApplePayment({
      PaymentConstants.customerEmail: globalBloc.partnerData.email,
      PaymentConstants.amount:
          (double.parse(cartData.amountTotal) * 100).toInt(),
      PaymentConstants.currency: "SAR",
      PaymentConstants.merchantReference: cartData.id.toString(),
      PaymentConstants.customer_name: globalBloc.partnerData.name,
      PaymentConstants.merchant_identifier: MERCHANT_IDENTIFIER,
      PaymentConstants.access_code: APPLE_ACCESS_CODE,
      PaymentConstants.lang: "en",
      PaymentConstants.item: item.toJson(),
    }, deviceId);
    result.fold((l) {
      showErrorDialog(
          localizationKey:
              'Apple Pay Failed cause:${(l as ApplePayFailure).message}');
      add(GeneralErrorEvent());
    }, (r) {
      add(ShowLoadingPageEvent());
      confirmCheckoutAfterPayByApplePay(cartData.id.toString());
    });
  }

  _payByCardWithInstalment(
      String cvv, IssuerDetail details, PlanDetails planDetails) async {
    if (_checkoutDataIsValid() && CreditCardValidator.validateCvv(cvv)) {
      try {
        showLoading();
        var uuid = Uuid();
        String ip = await Wifi.ip;
        _payDirectWithInstallments({
          PaymentConstants.customerEmail: globalBloc.partnerData.email,
          PaymentConstants.customer_ip: ip,
          PaymentConstants.amount:
              (double.parse(cartData.amountTotal) * 100).toInt(),
          PaymentConstants.currency: "SAR",
          PaymentConstants.merchantReference: cartData.id.toString(),
          PaymentConstants.customer_name: globalBloc.partnerData.name,
          PaymentConstants.merchant_identifier: MERCHANT_IDENTIFIER,
          PaymentConstants.access_code: ACCESS_CODE,
          PaymentConstants.cardCvv: cvv,
          PaymentConstants.lang: "en",
        }, selectedCreditCard, details, planDetails);
      } catch (ex) {
        hideLoading();
        showErrorDialog(localizationKey: ex);
        add(GeneralErrorEvent());
        rethrow;
      } finally {}
    } else {
      _handleValidationCheckout();
    }
  }

  _payOnDelivery() async {
    if (_checkoutDataIsValid()) {
      try {
        showLoading();
        await _checkoutUseCase.confirmCheckout(
            ConfirmCheckoutRequest(
                sharedPreferences.getOrderId(),
                selectedPartner.id,
                isPayOnDelivery,
                globalBloc.managingCartUseCase.isPartialDelivery()),
            PaymentRequest('PayOnDelivery', sharedPreferences.getOrderId()));
        firebaseAnalytics.purchaseSuccessfulEvent(cartData.amountTotal);
        facebookAnalytics.purchaseSuccessfulEvent(cartData.amountTotal);

        await _clearCartData();
        add(SuccessPurchaseGeneralCheckoutEvent("Quotation Sent"));
        isSuccessPaymentProcess = true;
      } catch (ex) {
        showErrorDialog(localizationKey: ex.toString());
        add(GeneralErrorEvent());
        rethrow;
      } finally {
        hideLoading();
      }
    } else {
      _handleValidationCheckout();
    }
  }

  _payByBankTransfer() async {
    if (_checkoutDataIsValidForBankTransfer()) {
      try {
        showLoading();
        await _checkoutUseCase.confirmCheckout(
            ConfirmCheckoutRequest(
                sharedPreferences.getOrderId(),
                selectedPartner.id,
                isPayOnDelivery,
                globalBloc.managingCartUseCase.isPartialDelivery(),
                paymentType: BANK_TRANSFER),
            PaymentRequest('BankTransfer', sharedPreferences.getOrderId()));
        firebaseAnalytics.purchaseSuccessfulEvent(cartData.amountTotal);
        facebookAnalytics.purchaseSuccessfulEvent(cartData.amountTotal);
        await _clearCartData();
        add(SuccessPurchaseGeneralCheckoutEvent("Quotation Sent"));
        isSuccessPaymentProcess = true;
      } catch (ex) {
        add(GeneralErrorEvent());
        showErrorDialog(localizationKey: ex.message);
      } finally {
        hideLoading();
      }
    } else {
      _handleValidationCheckout();
    }
  }

  _clearCartData() async {
    await sharedPreferences.clearOrderId();
    globalBloc.managingCartUseCase.clear();
    await sharedPreferences.deleteCoupon();
  }

  _handleValidationCheckout() {
    if (selectedPartner == null) {
      showErrorDialog(localizationKey: 'please_select_address');
      return;
    }
    if (selectedCreditCard == null) {
      showErrorDialog(localizationKey: 'please_select_credit_card');
      return;
    }
  }

  selectShippingAddress(ItemPartner shippingAddress) async {
    selectedPartner = shippingAddress;
    try {
      showLoading();
      cartData = await _cartUseCase.setDeliveryData(
          shippingAddress.id, sharedPreferences.getOrderId());
      _updateOrderController.add(cartData);
    } catch (e) {
      showErrorDialog(localizationKey: e.message);
    } finally {
      hideLoading();
    }
  }

  bool _checkoutDataIsValid() =>
      ((selectedPartner != null && selectedCreditCard != null) ||
          (selectedPartner != null && selectedPaymentType == PAYONDELIVERY));

  // bool _checkoutDataIsValid() => isPayOnDelivery == true;

  bool _checkoutDataIsValidForBankTransfer() => selectedPartner != null;

  @override
  Future<void> close() {
    _paymentStatusSubscription?.cancel();
    _updateOrderController?.close();
    return super.close();
  }

  void _makePurchase(Map paymentParams, SuccessModel model) async {
    Map<String, dynamic> editedMap = Map<String, dynamic>.from(paymentParams);
    editedMap.putIfAbsent('command', () => 'PURCHASE');
    editedMap.putIfAbsent('token_name', () => model.token_name);
    editedMap.putIfAbsent(
        'return_url', () => '$JOMLA_BASE_DOMAIN/payment/process');
    editedMap.putIfAbsent('remember_me', () => 'YES');
    String signatureGenerate = REQUEST_PHRASE;
    var map = SortedMap.from(editedMap, Ordering.byKey());
    'Map: ${map.toString()}'.log(className: "GeneralCheckOutBloc");
    map.forEach((key, value) {
      signatureGenerate += '$key=$value';
    });
    signatureGenerate = signatureGenerate + REQUEST_PHRASE;
    var bytes = utf8.encode(signatureGenerate);
    'Signature: $signatureGenerate'.log(className: "GeneralCheckOutBloc");
    var digest = sha256.convert(bytes);
    'Digest: $digest'.log(className: "GeneralCheckOutBloc");
    model.toJson().toString().log(className: "GeneralCheckOutBloc");

    var ressponse = await _checkoutUseCase.confirmPayment(ConfirmPaymentRequest(
        amount: paymentParams[PaymentConstants.amount],
        currency: paymentParams[PaymentConstants.currency],
        token_name: model.token_name,
        signature: digest.toString(),
        merchant_reference: model.merchant_reference,
        merchant_identifier: model.merchant_identifier,
        language: model.language,
        access_code: model.access_code,
        command: "PURCHASE",
        remember_me: 'YES',
        customer_email: paymentParams[PaymentConstants.customerEmail],
        customer_ip: paymentParams[PaymentConstants.customer_ip],
        customer_name: paymentParams[PaymentConstants.customer_name],
        return_url: '$JOMLA_BASE_DOMAIN/payment/process'));
    hideLoading();
    if (ressponse != null) {
      if (ressponse.redirect_url != null && ressponse.redirect_url.isNotEmpty) {
        add(ShowHtmlDialogEvent(ressponse.redirect_url, ressponse.fort_id));
      }
    }
  }

  void _payDirect(Map<String, dynamic> paymentParams, CreditCard card) async {
    showLoading();
    Map<String, dynamic> editedMap = Map<String, dynamic>.from(paymentParams);
    editedMap.putIfAbsent('command', () => 'PURCHASE');
    editedMap.putIfAbsent('token_name', () => card.tokenName);
    editedMap.putIfAbsent(
        'return_url', () => '$JOMLA_BASE_DOMAIN/payment/process');
    editedMap.putIfAbsent('remember_me', () => 'YES');

    String signatureGenerate = REQUEST_PHRASE;
    var map = SortedMap.from(editedMap, Ordering.byKey());
    'Map: ${map.toString()}'.log(className: "GeneralCheckOutBloc");
    map.forEach((key, value) {
      signatureGenerate += '$key=$value';
    });
    signatureGenerate = signatureGenerate + REQUEST_PHRASE;
    var bytes = utf8.encode(signatureGenerate);
    'Signature: $signatureGenerate'.log(className: "GeneralCheckOutBloc");
    var digest = sha256.convert(bytes);
    'Digest: $digest'.log(className: "GeneralCheckOutBloc");
    // print(model.toJson());

    var ressponse = await _checkoutUseCase.confirmPayment(ConfirmPaymentRequest(
        amount: paymentParams[PaymentConstants.amount],
        currency: paymentParams[PaymentConstants.currency],
        token_name: card.tokenName,
        signature: digest.toString(),
        merchant_reference: paymentParams[PaymentConstants.merchantReference],
        merchant_identifier:
            paymentParams[PaymentConstants.merchant_identifier],
        language: paymentParams[PaymentConstants.lang],
        access_code: paymentParams[PaymentConstants.access_code],
        command: "PURCHASE",
        remember_me: 'YES',
        card_security_code: int.parse(paymentParams[PaymentConstants.cardCvv]),
        customer_email: paymentParams[PaymentConstants.customerEmail],
        customer_ip: paymentParams[PaymentConstants.customer_ip],
        customer_name: paymentParams[PaymentConstants.customer_name],
        return_url: '$JOMLA_BASE_DOMAIN/payment/process'));

    if (ressponse != null) {
      if (ressponse.redirect_url != null && ressponse.redirect_url.isNotEmpty) {
        add(ShowHtmlDialogEvent(ressponse.redirect_url, ressponse.fort_id));
      } else if (ressponse.response_message == 'Success') {
        confirmCheckoutAfterPayByCard(
            ressponse.fort_id, ressponse.merchant_reference);
        add(ShowLoadingPageEvent());
      }
    } else {
      hideLoading();
      add(GeneralErrorEvent());
      showErrorDialog(localizationKey: 'general_error');
    }
  }

  void getInstallmentsData() async {
    showLoading();
    Map<String, dynamic> editedMap = {
      "query_command": "GET_INSTALLMENTS_PLANS",
      PaymentConstants.access_code: ACCESS_CODE,
      PaymentConstants.merchant_identifier: MERCHANT_IDENTIFIER,
    };

    String signatureGenerate = REQUEST_PHRASE;
    var map = SortedMap.from(editedMap, Ordering.byKey());
    'Map: ${map.toString()}'.log(className: "GeneralCheckOutBloc");
    map.forEach((key, value) {
      signatureGenerate += '$key=$value';
    });
    signatureGenerate = signatureGenerate + REQUEST_PHRASE;
    var bytes = utf8.encode(signatureGenerate);
    'Signature: $signatureGenerate'.log(className: "GeneralCheckOutBloc");
    var digest = sha256.convert(bytes);
    'Digest: $digest'.log(className: "GeneralCheckOutBloc");
    var response =
        await _checkoutUseCase.getInstallmentsDetails(InstallmentsRequestModel(
      signature: digest.toString(),
      merchant_identifier: MERCHANT_IDENTIFIER,
      access_code: ACCESS_CODE,
      // language: _localizationUseCase.fetchLocale() == Locale('en', 'US')
      //     ? "en"
      //     : "ar",
      // currency: "SAR",
      // amount: (double.parse(cartData.amountTotal) * 100).toInt(),
      query_command: "GET_INSTALLMENTS_PLANS",
    ));
    if (response != null && response.response_code == "62000") {
      'installments: ${response.toJson()}'
          .log(className: "GeneralCheckOutBloc");
      installmentData.value = response;
    }
    hideLoading();
  }

  void compareWithSelectedCard(IssuerDetail issuerDetail, PlanDetails details) {
    ("number" + selectedCreditCard.number.substring(0, 6))
        .log(className: "GeneralCheckOutBloc");
    if (issuerDetail.bins.any((element) =>
        element.bin == selectedCreditCard.number.substring(0, 6))) {
      var amount = (double.parse(cartData.amountTotal) * 100).toInt();
      if (amount >= details.minimum_amount && amount < details.maximum_amount) {
        add(PayWithInstallmentEvent(issuerDetail, details));
      } else {
        showErrorDialog(localizationKey: 'card_no_match_provider');
      }
    } else {
      showErrorDialog(localizationKey: 'card_no_match_provider');
    }
  }

  void _payDirectWithInstallments(
      Map<String, Object> paymentParams,
      CreditCard card,
      IssuerDetail issuerDetail,
      PlanDetails planDetails) async {
    Map<String, dynamic> editedMap = Map<String, dynamic>.from(paymentParams);
    editedMap.putIfAbsent('command', () => 'PURCHASE');
    editedMap.putIfAbsent('token_name', () => card.tokenName);
    editedMap.putIfAbsent(
        'return_url', () => '$JOMLA_BASE_DOMAIN/payment/process');
    editedMap.putIfAbsent('installments', () => 'HOSTED');
    editedMap.putIfAbsent('issuer_code', () => issuerDetail.issuer_code);
    editedMap.putIfAbsent('plan_code', () => planDetails.plan_code);
    editedMap.putIfAbsent('remember_me', () => 'YES');
    String signatureGenerate = REQUEST_PHRASE;
    var map = SortedMap.from(editedMap, Ordering.byKey());
    'Map: ${map.toString()}'.log(className: "GeneralCheckOutBloc");
    map.forEach((key, value) {
      signatureGenerate += '$key=$value';
    });
    signatureGenerate = signatureGenerate + REQUEST_PHRASE;
    var bytes = utf8.encode(signatureGenerate);
    'Signature: $signatureGenerate'.log(className: "GeneralCheckOutBloc");
    var digest = sha256.convert(bytes);
    'Digest: $digest'.log(className: "GeneralCheckOutBloc");
    // print(model.toJson());
    showLoading();
    var ressponse = await _checkoutUseCase.confirmPayment(ConfirmPaymentRequest(
        amount: paymentParams[PaymentConstants.amount],
        currency: paymentParams[PaymentConstants.currency],
        token_name: card.tokenName,
        signature: digest.toString(),
        merchant_reference: paymentParams[PaymentConstants.merchantReference],
        merchant_identifier:
            paymentParams[PaymentConstants.merchant_identifier],
        language: paymentParams[PaymentConstants.lang],
        access_code: paymentParams[PaymentConstants.access_code],
        command: "PURCHASE",
        remember_me: 'YES',
        card_security_code: int.parse(paymentParams[PaymentConstants.cardCvv]),
        customer_email: paymentParams[PaymentConstants.customerEmail],
        customer_ip: paymentParams[PaymentConstants.customer_ip],
        customer_name: paymentParams[PaymentConstants.customer_name],
        plan_code: planDetails.plan_code,
        installments: 'HOSTED',
        issuer_code: issuerDetail.issuer_code,
        return_url: '$JOMLA_BASE_DOMAIN/payment/process'));

    if (ressponse != null) {
      if (ressponse.redirect_url != null && ressponse.redirect_url.isNotEmpty) {
        add(ShowHtmlDialogEvent(ressponse.redirect_url, ressponse.fort_id));
      } else if (ressponse.response_message == 'Success') {
        hideLoading();
        confirmCheckoutAfterPayByCard(
            ressponse.fort_id, ressponse.merchant_reference);
        add(ShowLoadingPageEvent());
      }
    } else {
      hideLoading();
      add(GeneralErrorEvent());
      showErrorDialog(localizationKey: 'general_error');
    }
  }
}

class PaymentItem {
  final String name;
  final double price;

  PaymentItem({@required this.name, @required this.price});

  Map<String, String> toJson() => {
        "name": name,
        "price": price.toStringAsFixed(2),
      };
}