// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:pay/pay.dart';

// class PaymentView extends StatefulWidget {
//   final int tailorPrice;
//   const PaymentView({super.key, required this.tailorPrice});

//   @override
//   State<PaymentView> createState() => _PaymentViewState();
// }

// class _PaymentViewState extends State<PaymentView> {
//   int noOfOrders = 0;
//   bool isLoading = true;
//   String? error;

//   @override
//   void initState() {
//     super.initState();
//     fetchCustomerOrders();
//   }

//   Future<void> fetchCustomerOrders() async {
//     try {
//       final snapshot = await FirebaseFirestore.instance
//           .collection('Customer')
//           .where('email', isEqualTo: FirebaseAuth.instance.currentUser!.email)
//           .get();

//       if (snapshot.docs.isNotEmpty) {
//         setState(() {
//           noOfOrders = snapshot.docs.first.data()['no_of_orders'];
//           isLoading = false;
//         });
//       } else {
//         setState(() {
//           noOfOrders = 0;
//           isLoading = false;
//         });
//       }
//     } catch (e) {
//       setState(() {
//         error = e.toString();
//         isLoading = false;
//       });
//     }
//   }

//   List<PaymentItem> get _paymentItems => [
//         PaymentItem(
//           label: 'Total',
//           amount: (noOfOrders * widget.tailorPrice).toString(),
//           status: PaymentItemStatus.final_price,
//         )
//       ];

//   final String defaultGooglePay = '''{
//     "provider": "google_pay",
//     "data": {
//       "environment": "TEST",
//       "apiVersion": 2,
//       "apiVersionMinor": 0,
//       "allowedPaymentMethods": [
//         {
//           "type": "CARD",
//           "tokenizationSpecification": {
//             "type": "PAYMENT_GATEWAY",
//             "parameters": {
//               "gateway": "example",
//               "gatewayMerchantId": "gatewayMerchantId"
//             }
//           },
//           "parameters": {
//             "allowedCardNetworks": ["VISA", "MASTERCARD"],
//             "allowedAuthMethods": ["PAN_ONLY", "CRYPTOGRAM_3DS"],
//             "billingAddressRequired": true,
//             "billingAddressParameters": {
//               "format": "FULL",
//               "phoneNumberRequired": true
//             }
//           }
//         }
//       ],
//       "merchantInfo": {
//         "merchantId": "01234567890123456789",
//         "merchantName": "Example Merchant Name"
//       },
//       "transactionInfo": {
//         "countryCode": "PK",
//         "currencyCode": "PKR"
//       }
//     }
//   }''';

//   @override
//   Widget build(BuildContext context) {
//     if (isLoading) {
//       return Scaffold(
//         appBar: AppBar(
//           title: const Text("Payment"),
//         ),
//         body: const Center(
//           child: CircularProgressIndicator(),
//         ),
//       );
//     }

//     if (error != null) {
//       return Scaffold(
//         appBar: AppBar(
//           title: const Text("Payment"),
//         ),
//         body: Center(
//           child: Text('Error: $error'),
//         ),
//       );
//     }

//     return Scaffold(
//       appBar: AppBar(
//         title: const Text("Payment"),
//       ),
//       body: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         crossAxisAlignment: CrossAxisAlignment.center,
//         children: [
//           GooglePayButton(
//             paymentConfiguration:
//                 PaymentConfiguration.fromJsonString(defaultGooglePay),
//             paymentItems: _paymentItems,
//             type: GooglePayButtonType.buy,
//             margin: const EdgeInsets.only(top: 15.0),
//             onPaymentResult: onGooglePayResult,
//             loadingIndicator: const Center(
//               child: CircularProgressIndicator(),
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   void onGooglePayResult(paymentResult) {
//     FirebaseFirestore.instance
//         .collection("Customer")
//         .doc(FirebaseAuth.instance.currentUser!.email)
//         .set({"payment": true}, SetOptions(merge: true));
//   }
// }

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

class PaymentView extends StatefulWidget {
  final int cost;
  const PaymentView({super.key, required this.cost});

  @override
  State<PaymentView> createState() => _PaymentViewState();
}

class _PaymentViewState extends State<PaymentView> {
  final snapshot = FirebaseFirestore.instance
      .collection('Customer')
      .where('email', isEqualTo: FirebaseAuth.instance.currentUser!.email)
      .get();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Payment"),
      ),
      body: FutureBuilder<QuerySnapshot<Map<String, dynamic>>>(
        future: snapshot,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }
          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return Center(child: Text('No data found'));
          }

          return Center(
            child: Text(
                "Your total is: ${widget.cost * snapshot.data!.docs[0].data()['no_of_orders']}"),
          );
        },
      ),
    );
  }
}
