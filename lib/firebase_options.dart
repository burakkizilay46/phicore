// PLACEHOLDER — kendi Firebase projenizin değerleriyle değiştirin.
//
// Önerilen yol: `flutterfire configure` çalıştırın; bu dosya otomatik üretilir
// ve aşağıdaki TODO'lar gerçek değerlerle değişir.
//
// Manuel yol: Firebase Console → Project settings'ten Android ve iOS uygulama
// değerlerini alıp aşağıdaki TODO alanlarını doldurun.
//
// Bu template yalnızca Android + iOS hedefler.
// ignore_for_file: lines_longer_than_80_chars

import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

/// Platforma göre [FirebaseOptions] döndürür.
///
/// Kullanım:
/// ```dart
/// await Firebase.initializeApp(
///   options: DefaultFirebaseOptions.currentPlatform,
/// );
/// ```
class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      throw UnsupportedError(
        'Web bu template kapsamında yapılandırılmadı. Gerekirse '
        '`flutterfire configure` ile web platformunu ekleyin.',
      );
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions yalnızca Android ve iOS için '
          'yapılandırıldı (platform: $defaultTargetPlatform).',
        );
    }
  }

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'TODO_ANDROID_API_KEY',
    appId: 'TODO_ANDROID_APP_ID',
    messagingSenderId: 'TODO_MESSAGING_SENDER_ID',
    projectId: 'TODO_PROJECT_ID',
    storageBucket: 'TODO_PROJECT_ID.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'TODO_IOS_API_KEY',
    appId: 'TODO_IOS_APP_ID',
    messagingSenderId: 'TODO_MESSAGING_SENDER_ID',
    projectId: 'TODO_PROJECT_ID',
    storageBucket: 'TODO_PROJECT_ID.appspot.com',
    iosBundleId: 'com.example.phicore',
  );
}
