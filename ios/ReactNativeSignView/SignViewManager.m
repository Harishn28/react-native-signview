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
    SignView *signView = [[SignView alloc] init];
    return signView;
}

@end
