package com.kd.custom_social_share

import android.app.Activity
import android.content.ActivityNotFoundException
import android.content.Intent
import android.content.pm.PackageManager
import android.net.Uri
import android.os.Build
import androidx.annotation.NonNull
import androidx.core.app.ShareCompat
import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.embedding.engine.plugins.activity.ActivityAware
import io.flutter.embedding.engine.plugins.activity.ActivityPluginBinding
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result

/** CustomSocialSharePlugin */
class CustomSocialSharePlugin : FlutterPlugin, MethodCallHandler, ActivityAware {
    /// The MethodChannel that will the communication between Flutter and native Android
    ///
    /// This local reference serves to register the plugin with the Flutter Engine and unregister it
    /// when the Flutter Engine is detached from the Activity
    private lateinit var channel: MethodChannel
    private lateinit var mActivity: Activity

    private val appsMap = mapOf(
        "facebook" to "com.facebook.katana",
        "facebookLite" to "com.facebook.lite",
        "facebookMessenger" to "com.facebook.orca",
        "facebookMessengerLite" to "com.facebook.mlite",
        "instagram" to "com.instagram.android",
        "line" to "jp.naver.line.android",
        "linkedIn" to "com.linkedin.android",
        "reddit" to "com.reddit.frontpage",
        "skype" to "com.skype.raider",
        "slack" to "com.Slack",
        "snapchat" to "com.snapchat.android",
        "telegram" to "org.telegram.messenger",
        "twitter" to "com.twitter.android",
        "viber" to "com.viber.voip",
        "wechat" to "com.tencent.mm",
        "whatsapp" to "com.whatsapp",
    )

    override fun onAttachedToEngine(@NonNull flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
        channel = MethodChannel(flutterPluginBinding.binaryMessenger, "custom_social_share")
        channel.setMethodCallHandler(this)
    }

    override fun onDetachedFromEngine(@NonNull binding: FlutterPlugin.FlutterPluginBinding) {
        channel.setMethodCallHandler(null)
    }

    override fun onAttachedToActivity(binding: ActivityPluginBinding) {
        mActivity = binding.activity
    }

    override fun onDetachedFromActivityForConfigChanges() {}

    override fun onReattachedToActivityForConfigChanges(binding: ActivityPluginBinding) {
        mActivity = binding.activity
    }

    override fun onDetachedFromActivity() {}

    override fun onMethodCall(@NonNull call: MethodCall, @NonNull result: Result) {
        val content: String? = call.argument("content")
        when (call.method) {

            "sms" -> {
                val intent = Intent(Intent.ACTION_SENDTO, Uri.parse("smsto:")).apply {
                    if (Build.VERSION.SDK_INT < Build.VERSION_CODES.O) type = "vnd.android-dir/mms-sms"
                    putExtra("sms_body", content)
                }
                callIntent(intent, result)
            }

            "email" -> {
                callIntent(Intent(Intent.ACTION_SENDTO, Uri.parse("mailto:?subject=$content")), result)
            }

            "toAll" -> {
                ShareCompat.IntentBuilder(mActivity).setType("text/plain").setText(content).startChooser()
            }

            "getInstalledApps" -> {
                //check if the apps exists
                //creating a mutable map of apps
                val apps: MutableMap<String, Boolean> = mutableMapOf()

                //assigning package manager
                val pm: PackageManager = mActivity.packageManager

                //get a list of installed apps.
                val packages = pm.getInstalledApplications(PackageManager.GET_META_DATA)

                //if sms app exists
                apps["sms"] = pm.queryIntentActivities(Intent(Intent.ACTION_SENDTO, Uri.parse("smsto:")), 0).isNotEmpty()

                //if email app exists
                apps["email"] = pm.queryIntentActivities(Intent(Intent.ACTION_SENDTO, Uri.parse("mailto:")), 0).isNotEmpty()

                //if other app exists
                appsMap.forEach { entry: Map.Entry<String, String> ->
                    apps[entry.key] = packages.any { it.packageName.toString().contentEquals(entry.value) }
                }

                result.success(apps)
            }

            "customApp" -> {
                callShareIntent((call.argument("package") as? String).orEmpty(), content, result)
            }

            else -> {
                if (appsMap.containsKey(call.method)) {
                    callShareIntent(appsMap[call.method].orEmpty(), content, result)
                } else {
                    result.notImplemented()
                }
            }
        }
    }

    private fun callShareIntent(packageName: String, content: String?, result: Result) {
        val intent = Intent(Intent.ACTION_SEND).apply {
            putExtra(Intent.EXTRA_TEXT, content)
            type = "text/plain"
            setPackage(packageName)
        }
        callIntent(intent, result)
    }

    private fun callIntent(intent: Intent, result: Result) {
        try {
            mActivity.startActivity(intent)
            result.success(true)
        } catch (ex: ActivityNotFoundException) {
            result.success(false)
        }
    }
}
