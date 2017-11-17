@import UIKit;
#import "RNBraintree.h"
#import "BraintreeCore.h"
#import "BraintreeDropIn.h"
#import "RCTRootView.h"


@implementation RNBraintree

static NSString* token;

- (dispatch_queue_t)methodQueue
{
    return dispatch_get_main_queue();
}
RCT_EXPORT_MODULE()

-(RCTBridge*) getBridge {
    static dispatch_once_t once;
    static id bridge;
    dispatch_once(&once, ^{
        NSURL *jsCodeLocation;
#if DEBUG
        jsCodeLocation = [NSURL URLWithString:@"http://localhost:8081/index.ios.bundle?platform=ios&dev=true"];
#else
        jsCodeLocation = [[NSBundle mainBundle] URLForResource:@"main" withExtension:@"jsbundle"];
#endif
        bridge = [
                  [RCTBridge alloc] initWithBundleURL:jsCodeLocation
                  moduleProvider:nil
                  launchOptions:nil
                  ];
    });
    return bridge;
}

RCT_EXPORT_METHOD(init: (NSString *) ttoken)
{
    token = ttoken;
}

RCT_REMAP_METHOD(showDropIn, resolver:(RCTPromiseResolveBlock)resolve rejecter:(RCTPromiseRejectBlock)reject)
{
    //RCTLogInfo(@"RNBraintree in showDropIn, token:  %@", clientTokenOrTokenizationKey);
    UIViewController *viewController = [[[[UIApplication sharedApplication] delegate] window] rootViewController];
    BTDropInRequest *request = [[BTDropInRequest alloc] init];
    BTDropInController *dropIn = [[BTDropInController alloc] initWithAuthorization:token request:request handler:^(BTDropInController * _Nonnull controller, BTDropInResult * _Nullable result, NSError * _Nullable error) {
    [viewController dismissViewControllerAnimated:YES completion:nil];
        //NSLog(@"RNBraintree.. @",result.paymentMethod.nonce);
        
        if (error != nil) {
            NSLog(@"ERROR");
            reject(@"ERROR", @"Braintree Dropin error", error);
        } else if (result.cancelled) {
            NSLog(@"CANCELLED");
            reject(@"CANCELLED", @"Braintree Dropin canceled", nil);
        } else {
            resolve(result.paymentMethod.nonce);
            // Use the BTDropInResult properties to update your UI
            // result.paymentOptionType
            // result.paymentMethod
            // result.paymentIcon
            // result.paymentDescription
        }
    }];

    [viewController presentViewController:dropIn animated:YES completion:^{}];
}

@end
