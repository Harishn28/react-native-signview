//
//  SignViewManager.m
//  ReactNativeSignView
//
//  Created by Harish on 11/02/19.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <React/RCTViewManager.h>
#import <React/RCTUIManager.h>
#import <ReactNativeSignView-Swift.h>

@interface SignViewManager : RCTViewManager<RCTBridgeModule>
@end


@implementation SignViewManager

RCT_EXPORT_MODULE();

- (UIView *)view
{
    RCTSignView *signView = [[RCTSignView alloc] init];
    return signView;
}


RCT_EXPORT_VIEW_PROPERTY(onSignAvailable, RCTDirectEventBlock);

RCT_CUSTOM_VIEW_PROPERTY(signatureColor, UIColor , RCTSignView){
    [view setSignatureColor: [RCTConvert UIColor:json]];
}

RCT_EXPORT_METHOD(clearSignature:(nonnull NSNumber *)reactTag){
    [self.bridge.uiManager addUIBlock:^(__unused RCTUIManager *uiManager, NSDictionary<NSNumber *, RCTSignView *> *viewRegistry) {
        RCTSignView *signView = viewRegistry[reactTag];
        
        if ([signView isKindOfClass:[RCTSignView class]]) {
            [signView clearSignature];
        } else{
            NSLog(@"Expecting ");
        }
    }];
}

@end
