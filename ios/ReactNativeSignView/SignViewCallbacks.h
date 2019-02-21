//
//  SignViewCallbacks.h
//  ReactNativeSignView
//
//  Created by Harish on 20/02/19.
//  Copyright © 2019 Tekion. All rights reserved.
//

#ifndef SignViewCallbacks_h
#define SignViewCallbacks_h

@protocol SignViewCallbacks
@required
-(void)onSignatureChangesCb: (NSString*) base64DataOfSign;
@end

#endif /* SignViewCallbacks_h */
