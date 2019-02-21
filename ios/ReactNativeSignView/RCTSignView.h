//
//  RCTSignView.h
//  ReactNativeSignView
//
//  Created by Harish on 20/02/19.
//  Copyright © 2019 Tekion. All rights reserved.
//

#ifndef RCTSignView_h
#define RCTSignView_h

#import <React/RCTComponent.h>
#import <React/RCTViewManager.h>
#import <React/RCTUIManager.h>
#import "SignView.h"
#import "SignViewCallbacks.h"


@interface RCTSignView : SignView<SignViewCallbacks>
    @property (nonatomic, copy) RCTDirectEventBlock onSignAvailable;
@end

#endif /* RCTSignView_h */
