//
//  RCTSignView.swift
//  ReactNativeSignView
//
//  Created by Harish on 17/02/19.
//  Copyright © 2019 Tekion. All rights reserved.
//

import Foundation

class RCTSignView: SignView, SignViewCallbacks{
    
    @objc var onSignAvailable: RCTDirectEventBlock?;
    
    override func commonInit() {
        super.commonInit();
        super.delegate = self;
    }
    
    func onSignatureChangesCb(_ base64DataOfSign: String) {
        onSignAvailable?(["signature":base64DataOfSign]);
    }
}
