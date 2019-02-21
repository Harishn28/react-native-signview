//
//  RCTSignView.m
//  ReactNativeSignView
//
//  Created by Harish on 20/02/19.
//  Copyright © 2019 Tekion. All rights reserved.
//

#import "UIKit/UIKit.h"
#import "RCTSignView.h"


@implementation RCTSignView 

@synthesize onSignAvailable;

- (void) commonInit{
    [super commonInit];
    super.delegate = self;
}

-(void)onSignatureChangesCb: (NSString*) base64DataOfSign{
    self.onSignAvailable(@{@"signature": base64DataOfSign});
}



@end
