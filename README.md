# PhiCore

Flutter base/boilerplate projesi. MVVM + feature-based yapı, Riverpod state management,
merkezi tema sistemi ve hazır Firebase entegrasyonu (Auth, Analytics, App Check) içerir.

Mimari ve klasör yapısı detayları için `CLAUDE.md` dosyasına bakın.

---

## 🔥 Firebase Kurulumu

Bu template, Firebase için **base** bir kurulumla gelir. Kod hazırdır; sizin yapmanız gereken
yalnızca **kendi Firebase projenizin anahtarlarını birkaç belirli dosyaya** koymaktır.

### Neler hazır geliyor?
- **Firebase Auth**: Email/şifre, Google ve Apple ile giriş; kayıt; şifre sıfırlama.
- **Firebase Analytics**: Otomatik ekran takibi + örnek `login`/`sign_up` event'leri.
- **Firebase App Check**: Play Integrity (Android) / DeviceCheck (iOS), dev'de debug sağlayıcı.

> **Platform kapsamı:** Bu template **Android + iOS** hedefler.

### `enableFirebase` bayrağı — kutudan çıkar çıkmaz çalışır
`lib/core/constants/env_config.dart` içindeki `enableFirebase` bayrağı **kapalıyken** uygulama
**mock `AuthService`** ile çalışır; Analytics ve App Check no-op olur. Yani Firebase'i kurmadan da
projeyi çalıştırıp UI'ı görebilirsiniz. Kendi Firebase projenizi bağladıktan sonra `dev` için
bu bayrağı `true` yapın (`staging`/`prod` zaten `true`).

```dart
// lib/core/constants/env_config.dart
static bool get enableFirebase {
  switch (_env) {
    case Environment.dev:     return false; // ← kurulumdan sonra true yapın
    case Environment.staging:
    case Environment.prod:    return true;
  }
}
```

---

### 1) Önkoşullar
1. [Firebase Console](https://console.firebase.google.com/)'da bir proje oluşturun.
2. (Önerilen) FlutterFire CLI'yi kurun:
   ```bash
   dart pub global activate flutterfire_cli
   npm install -g firebase-tools && firebase login
   ```

### 2) Yapılandırma — iki yol

#### Yol A — FlutterFire CLI (önerilen)
Proje kökünde çalıştırın:
```bash
flutterfire configure
```
Bu komut `lib/firebase_options.dart` dosyasını ve platform dosyalarını
(`android/app/google-services.json`, `ios/Runner/GoogleService-Info.plist`) **otomatik üretir**.

#### Yol B — Manuel
1. **`lib/firebase_options.dart`** içindeki `TODO_*` placeholder'ları Firebase Console →
   Project settings'teki Android ve iOS değerleriyle doldurun.
2. Android uygulaması için **`google-services.json`** indirip `android/app/` altına koyun.
   (Şablon: `android/app/google-services.json.example`)
3. iOS uygulaması için **`GoogleService-Info.plist`** indirip Xcode ile `Runner` target'a ekleyin.
   (Şablon: `ios/Runner/GoogleService-Info.plist.example`)

> Gerçek `google-services.json` ve `GoogleService-Info.plist` dosyaları `.gitignore`'da yer alır,
> repoya commit'lenmez. `lib/firebase_options.dart` ise placeholder olarak commit'lidir.

### 3) Düzenleyeceğiniz dosyalar (özet)
| Dosya | Ne için |
|---|---|
| `lib/core/constants/env_config.dart` | `enableFirebase` bayrağını açma |
| `lib/firebase_options.dart` | Firebase proje anahtarları (CLI otomatik üretir) |
| `lib/core/config/firebase_config.dart` | Analytics/App Check aç-kapa, debug seçimi |
| `android/app/google-services.json` | Android Firebase config (CLI/indirme) |
| `ios/Runner/GoogleService-Info.plist` | iOS Firebase config (CLI/indirme) |
| `ios/Runner/Info.plist` | Google Sign-In `REVERSED_CLIENT_ID` URL şeması |
| `ios/Runner/Runner.entitlements` | Sign in with Apple yetkisi |

---

### 4) Auth sağlayıcılarını etkinleştirme

Firebase Console → **Authentication → Sign-in method** altında kullanacağınız sağlayıcıları açın.

**Email/Password** — Console'dan etkinleştirmek yeterli.

**Google**
- Console'da Google sağlayıcısını açın.
- **Android:** SHA-1 ve SHA-256 parmak izlerinizi Firebase Console → Project settings → Android
  uygulaması altına ekleyin, ardından güncel `google-services.json`'ı yeniden indirin.
  ```bash
  cd android && ./gradlew signingReport   # SHA-1 / SHA-256 değerlerini gösterir
  ```
- **iOS:** `GoogleService-Info.plist` içindeki `REVERSED_CLIENT_ID` değerini
  `ios/Runner/Info.plist` → `CFBundleURLSchemes` altındaki `TODO_REVERSED_CLIENT_ID` yerine yazın.

**Apple** (iOS)
- Console'da Apple sağlayıcısını açın.
- [Apple Developer](https://developer.apple.com/) hesabında App ID için **Sign In with Apple**
  yetkisini etkinleştirin.
- Xcode → Runner target → **Signing & Capabilities → + Capability → Sign in with Apple** ekleyin
  (bu, `ios/Runner/Runner.entitlements` dosyasını bağlar).

> Sosyal giriş butonları `lib/features/auth/sign_in/view/auth_view.dart` içinde hazır. Apple
> butonu yalnızca iOS'ta görünür. Google logosu yerine geçici bir ikon kullanılıyor; dilerseniz
> resmi logoyu bir asset olarak ekleyin.

---

### 5) Analytics
Ek anahtar gerekmez. `FirebaseAnalyticsObserver` `MaterialApp.navigatorObservers`'a otomatik
eklenir ve ekran geçişlerini izler. Başarılı giriş/kayıt için örnek `login`/`sign_up` event'leri
`FirebaseAuthService` içinde loglanır.

- Açma/kapama: `lib/core/config/firebase_config.dart` → `enableAnalytics`.
- Doğrulama: cihazda **DebugView**'i açın:
  ```bash
  # Android
  adb shell setprop debug.firebase.analytics.app com.example.phicore
  ```
  Firebase Console → Analytics → **DebugView**'da event akışını görebilirsiniz.
- Kod içinden özel event: `AnalyticsService.instance.logEvent('event_adi', parameters: {...})`.

---

### 6) App Check
`main.dart`'ta Firebase init sonrası otomatik etkinleştirilir.

- Açma/kapama: `lib/core/config/firebase_config.dart` → `enableAppCheck`.
- **Debug (dev):** İlk çalıştırmada konsola (logcat / Xcode) bir **debug token** yazılır. Bunu
  Firebase Console → **App Check → Apps → (uygulamanız) → Manage debug tokens** altına ekleyin.
- **Üretim:**
  - **Android:** Play Integrity — Console'da SHA-256'yı kaydedin.
  - **iOS:** DeviceCheck — Apple Developer Team ID + private key'i Console'a ekleyin.
- Korumayı zorunlu kılmak için her ürün (Auth, Firestore, ...) için Console'dan **Enforce**'u açın.
  (Önce token'ların geldiğini DebugView/metriklerden doğrulayın, sonra zorunlu kılın.)

---

## 🧭 Onboarding Akışı

İlk açılışta, **giriş ekranından önce** gösterilen yapılandırılabilir bir tanıtım + anket akışı.
Amaç: kullanıcıyı kısaca karşılamak ve ürün için değerli birkaç bilgi toplamak
(kullanım amacı, deneyim seviyesi, bizi nereden keşfettiği). Soru sayısı bilinçli olarak az
tutulmuştur — uzun anketler tamamlanma oranını düşürür.

### Akış nasıl çalışır?
Yönlendirme tek noktadan, `lib/features/splash/view_model/splash_view_model.dart` içinde
kararlaştırılır:

```
splash → (onboarding görülmedi)            → onboarding → signIn → home
       → (görüldü + oturum açık)           → home
       → (görüldü + oturum yok)            → signIn
```

- Onboarding tamamlandığında `signIn` ekranına geçilir ve `onboarding_completed` bayrağı
  (`SharedPreferences`) kaydedilir.
- Toplanan cevaplar **yalnızca bellek-içi (Riverpod state)** tutulur. Backend/analytics gönderimi
  `OnboardingViewModel.complete()` içinde `TODO` olarak bırakılmıştır.

### `alwaysShow` bayrağı — geliştirme kolaylığı
`lib/features/onboarding/config/onboarding_config.dart` içindeki `alwaysShow`:

| Değer | Davranış |
|---|---|
| `true` (varsayılan / dev) | Her açılışta onboarding gösterilir (kayıtlı bayrak yok sayılır). |
| `false` (prod) | Onboarding yalnızca **bir kez** gösterilir. |

### Adımları düzenleme — tek dosya
Tüm akış `OnboardingConfig.steps` listesinden yönetilir. Adım **eklemek / çıkarmak / sıralamak**
için yalnızca bu listeyi düzenlemeniz yeterli; metinler doğrudan değil, lokalizasyon anahtarı
olarak tutulur.

```dart
// lib/features/onboarding/config/onboarding_config.dart
static const List<OnboardingStep> steps = [
  OnboardingInfoStep(...),       // tanıtım slaytı
  OnboardingQuestionStep(...),   // tek seçimli soru
  OnboardingPermissionStep(...), // bildirim izni (soft-ask)
];
```

3 adım tipi (`lib/features/onboarding/data/model/onboarding_step.dart`):

| Tip | Ne işe yarar | Önemli alanlar |
|---|---|---|
| `OnboardingInfoStep` | Karşılama / değer önerisi slaytı | `titleKey`, `descriptionKey`, `icon` |
| `OnboardingQuestionStep` | Tek seçimli anket sorusu | `key`, `questionKey`, `options`, `optional` |
| `OnboardingPermissionStep` | Bildirim izni hazırlık ekranı | `titleKey`, `descriptionKey` |

> **`optional`:** `OnboardingQuestionStep.optional = true` yaparsanız cevap zorunlu olmaktan
> çıkar (kullanıcı cevap vermeden "Devam" edebilir). Varsayılan olarak sorular zorunludur.

### Metinler (lokalizasyon)
Adımlarda kullanılan tüm metinler anahtardır; karşılıkları iki dosyada bulunur:
`lib/core/localization/translations/en.dart` ve `tr.dart` (`onb_` ön ekiyle başlayanlar).
Yeni bir adım/soru eklerken anahtarlarını **her iki dosyaya da** eklemeyi unutmayın.

### Tema
Tüm onboarding ekranları tema-duyarlıdır (`context.colorScheme` / `context.textTheme` kullanır,
hardcoded renk yoktur). `main.dart`'taki `themeMode`'a göre açık/koyu temaya otomatik uyum sağlar.

### Bildirim izni
Bildirim adımı şu an yalnızca **hazırlık (soft-ask)** ekranıdır; gerçek sistem izni isteği
`lib/features/onboarding/view/onboarding_view.dart` içinde `TODO` olarak bırakılmıştır
(projeye bir izin paketi — `permission_handler` / `firebase_messaging` — eklendiğinde bağlanır).

### İlgili dosyalar
| Dosya / klasör | Sorumluluk |
|---|---|
| `lib/features/onboarding/config/onboarding_config.dart` | **Düzenleme noktası**: adımlar + `alwaysShow` |
| `lib/features/onboarding/data/model/onboarding_step.dart` | Adım tipleri (sealed sınıflar) |
| `lib/features/onboarding/view_model/` | State + ViewModel (navigasyon, cevaplar) |
| `lib/features/onboarding/view/` | Ekran kabuğu + adım widget'ları |
| `lib/features/splash/view_model/splash_view_model.dart` | Onboarding yönlendirme kararı |

---

## Geliştirme Komutları
```bash
flutter pub get
dart run build_runner build --delete-conflicting-outputs   # freezed/riverpod codegen
flutter analyze
flutter test
flutter run
```
