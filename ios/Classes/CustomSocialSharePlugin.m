#import "CustomSocialSharePlugin.h"
#if __has_include(<custom_social_share/custom_social_share-Swift.h>)
#import <custom_social_share/custom_social_share-Swift.h>
#else
// Support project import fallback if the generated compatibility header
// is not copied when this plugin is created as a library.
// https://forums.swift.org/t/swift-static-libraries-dont-copy-generated-objective-c-header/19816
#import "custom_social_share-Swift.h"
#endif

@implementation CustomSocialSharePlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftCustomSocialSharePlugin registerWithRegistrar:registrar];
}
@end
