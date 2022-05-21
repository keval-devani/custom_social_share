import Flutter
import UIKit

public class SwiftCustomSocialSharePlugin: NSObject, FlutterPlugin {
    public static func register(with registrar: FlutterPluginRegistrar) {
        let channel = FlutterMethodChannel(name: "custom_social_share", binaryMessenger: registrar.messenger())
        let instance = SwiftCustomSocialSharePlugin()
        registrar.addMethodCallDelegate(instance, channel: channel)
    }
    
    public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        let content: String
        if call.arguments == nil {
            content = ""
        } else {
            content = (call.arguments as! [String: Any])["content"] as? String ?? ""
        }
        
        switch call.method {
            
        case "copy":
            let pasteboard = UIPasteboard.general
            pasteboard.string = content
            result(NSNumber(value: true))
            break
            
        case "sms":
            let urlSchema = "sms:?&body=\(content)"
            launchURL(hookUrl: urlSchema, result: result)
            break
            
        case "email":
            let urlSchema = "mailto:?&body=\(content)"
            launchURL(hookUrl: urlSchema, result: result)
            break
            
        case "toAll":
            let textShare = [ content ]
            let activityViewController = UIActivityViewController(activityItems: textShare , applicationActivities: nil)
            
            let controller = UIApplication.shared.keyWindow?.rootViewController
            activityViewController.popoverPresentationController?.sourceView = controller?.view
            
            controller?.present(activityViewController, animated: true)
            
            break
            
        case "getInstalledApps":
            
            var installedApps: [String: Bool] = [:]
            
            installedApps["copy"] = true
            
            installedApps["sms"] = canOpenApp(appName: "sms")
            installedApps["email"] = canOpenApp(appName: "mailto")
            
            installedApps["facebook"] = canOpenApp(appName: "fb")
            installedApps["facebookMessenger"] = canOpenApp(appName: "fb-messenger")
            installedApps["instagram"] = canOpenApp(appName: "instagram")
            installedApps["line"] = canOpenApp(appName: "line")
            installedApps["linkedIn"] = canOpenApp(appName: "linkedin")
            installedApps["reddit"] = canOpenApp(appName: "reddit")
            installedApps["skype"] = canOpenApp(appName: "skype")
            installedApps["slack"] = canOpenApp(appName: "slack")
            installedApps["snapchat"] = canOpenApp(appName: "snapchat")
            installedApps["telegram"] = canOpenApp(appName: "tg")
            installedApps["twitter"] = canOpenApp(appName: "twitter")
            installedApps["viber"] = canOpenApp(appName: "viber")
            installedApps["weChat"] = canOpenApp(appName: "wechat")
            installedApps["whatsApp"] = canOpenApp(appName: "whatsapp")
            
            result(installedApps)
            
            break
            
        case "facebook":
            let urlSchema = "fb://text=\(content)"
            launchURL(hookUrl: urlSchema, result: result)
            break
            
        case "facebookMessenger":
            let urlSchema = "fb-messenger://text=\(content)"
            launchURL(hookUrl: urlSchema, result: result)
            break
            
        case "instagram":
            let urlSchema = "instagram://text=\(content)"
            launchURL(hookUrl: urlSchema, result: result)
            break
            
        case "line":
            let urlSchema = "https://line.me/R/msg/text/?\(content)"
            launchURL(hookUrl: urlSchema, result: result)
            break
            
        case "linkedIn":
            let urlSchema = "linkedin://text=\(content)"
            launchURL(hookUrl: urlSchema, result: result)
            break
            
        case "reddit":
            let urlSchema = "reddit://text=\(content)"
            launchURL(hookUrl: urlSchema, result: result)
            break
            
        case "skype":
            let urlSchema = "skype:?chat&topic=\(content)"
            launchURL(hookUrl: urlSchema, result: result)
            break
            
        case "slack":
            let urlSchema = "slack://text=\(content)"
            launchURL(hookUrl: urlSchema, result: result)
            break
            
        case "snapchat":
            let urlSchema = "snapchat://text=\(content)"
            launchURL(hookUrl: urlSchema, result: result)
            break
            
        case "telegram":
            let urlSchema = "tg://msg?text=\(content)"
            launchURL(hookUrl: urlSchema, result: result)
            break
            
        case "twitter":
            let urlSchema = "https://twitter.com/intent/tweet?text=\(content)"
            launchURL(hookUrl: urlSchema, result: result)
            break
            
        case "viber":
            let urlSchema = "viber://forward?text=\(content)"
            launchURL(hookUrl: urlSchema, result: result)
            break
            
        case "weChat":
            
            break
            
        case "whatsApp":
            let urlSchema = "whatsapp://send?text=\(content)"
            launchURL(hookUrl: urlSchema, result: result)
            break
            
        default:
            result(FlutterMethodNotImplemented)
        }
    }
    
    func launchURL(hookUrl: String, result: @escaping FlutterResult) {
        if let urlString = hookUrl.addingPercentEncoding(withAllowedCharacters: NSCharacterSet.urlQueryAllowed) {
            if let url = NSURL(string: urlString) {
                if UIApplication.shared.canOpenURL(url as URL) {
                    UIApplication.shared.open(url as URL, options: [:], completionHandler: nil)
                    result(NSNumber(value: true))
                } else {
                    result(NSNumber(value: false))
                }
            }
        }
    }
    
    func canOpenApp(appName: String) -> Bool {
        let appScheme = "\(appName)://app"
        let appUrl = URL(string: appScheme)
        return UIApplication.shared.canOpenURL(appUrl! as URL)
    }
}
