//
//  SignViewCallbacks.swift
//  ReactNativeSignView
//
//  Created by Harish on 17/02/19.
//  Copyright © 2019 Tekion. All rights reserved.
//

import Foundation

@objc public protocol SignViewCallbacks{
    func onSignatureChangesCb(_ base64DataOfSign:String);
}
