## Flutter wrapper
-keep class io.flutter.app.** { *; }
-keep class io.flutter.plugin.**  { *; }
-keep class io.flutter.util.**  { *; }
-keep class io.flutter.view.**  { *; }
-keep class io.flutter.**  { *; }
-keep class io.flutter.plugins.**  { *; }

## MSG91 OTP SDK
# Keep all classes from sendotp_flutter_sdk package
-keep class com.msg91.sendotp.** { *; }
-keepclassmembers class com.msg91.sendotp.** { *; }

# Keep OTPWidget class and its methods
-keep class com.msg91.sendotp.library.OTPWidget { *; }
-keep class com.msg91.sendotp.library.OTPWidget$* { *; }

# Keep all public methods in OTP SDK
-keepclasseswithmembernames class * {
    native <methods>;
}

## HTTP and Dio
-keep class okhttp3.** { *; }
-keep interface okhttp3.** { *; }
-dontwarn okhttp3.**
-dontwarn okio.**

## Gson (if used by MSG91)
-keepattributes Signature
-keepattributes *Annotation*
-dontwarn sun.misc.**
-keep class com.google.gson.** { *; }
-keep class * implements com.google.gson.TypeAdapterFactory
-keep class * implements com.google.gson.JsonSerializer
-keep class * implements com.google.gson.JsonDeserializer

## Retrofit (if used)
-dontwarn retrofit2.**
-keep class retrofit2.** { *; }
-keepattributes Signature
-keepattributes Exceptions

## Keep all model classes (prevent JSON serialization issues)
-keep class * implements android.os.Parcelable {
  public static final android.os.Parcelable$Creator *;
}

## General Android
-keepattributes SourceFile,LineNumberTable
-keep public class * extends android.app.Activity
-keep public class * extends android.app.Application
-keep public class * extends android.app.Service
-keep public class * extends android.content.BroadcastReceiver
-keep public class * extends android.content.ContentProvider

## Supabase
-keep class io.supabase.** { *; }
-dontwarn io.supabase.**

## Google Play Core (for Flutter deferred components)
-keep class com.google.android.play.core.** { *; }
-keep interface com.google.android.play.core.** { *; }
-dontwarn com.google.android.play.core.**

# Keep split compat classes
-keep class com.google.android.play.core.splitcompat.** { *; }
-dontwarn com.google.android.play.core.splitcompat.**

# Keep split install classes
-keep class com.google.android.play.core.splitinstall.** { *; }
-dontwarn com.google.android.play.core.splitinstall.**

# Keep tasks classes
-keep class com.google.android.play.core.tasks.** { *; }
-dontwarn com.google.android.play.core.tasks.**

## Flutter embedding
-keep class io.flutter.embedding.** { *; }
-dontwarn io.flutter.embedding.**
