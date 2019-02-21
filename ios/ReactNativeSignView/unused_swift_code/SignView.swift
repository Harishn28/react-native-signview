//
//  CircularView.swift
//  CustomViewSample
//
//  Created by Harish on 09/02/19.
//

// THis is native view for handling signature. Do not add react-native stuffs here.


import Foundation
import UIKit

class SignView: UIView {
    
    public var delegate: SignViewCallbacks?;
    
    private var currentPath = UIBezierPath();
    private let pathLayer = CAShapeLayer();
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder);
        commonInit();
    }
    
    func commonInit(){
        self.backgroundColor = UIColor.white;
        pathLayer.path = currentPath.cgPath;
        pathLayer.strokeColor = UIColor.black.cgColor;
        pathLayer.lineWidth = 2;
        self.layer.addSublayer(pathLayer);
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(onTap))
        self.addGestureRecognizer(tap)
    }
    
    @objc public func onTap(sender: UITapGestureRecognizer? = nil) {
        let location = sender!.location(in: self);
        currentPath.move(to: location);
        currentPath.addArc(withCenter: location, radius: 1, startAngle: 0, endAngle: .pi * 2, clockwise: true);
        drawPaths();
        self.onSignatureChange();
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch = touches.first!
        let location = touch.location(in: self)
        currentPath.move(to: location);
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch = touches.first!
        let location = touch.location(in: self)
        currentPath.move(to: location);
        drawPaths();
        self.onSignatureChange();
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first {
            let location = touch.location(in: self);
            
            if(location.x > 0 && location.x < self.bounds.width &&
                location.y > 0 && location.y < self.bounds.height){
                self.currentPath.addLine(to: location);
                self.currentPath.move(to: location);
                drawPaths();
            }
        }
    }
    
    private func getSignatureImage() -> UIImage? {
        if(currentPath.isEmpty){
            return nil;
        } else{
            UIGraphicsBeginImageContext(CGSize(width: self.bounds.size.width, height: self.bounds.size.height))
            self.pathLayer.render(in: UIGraphicsGetCurrentContext()!)
            let signatureImage = UIGraphicsGetImageFromCurrentImageContext()!
            UIGraphicsEndImageContext();
            return signatureImage;
        }
    }
    
    private func getBase64StringOfImage(_ image:UIImage) -> String? {
        let nsDataOfImage = image.pngData();
        let base64StringOfImage = nsDataOfImage?.base64EncodedString();
        return base64StringOfImage;
    }
    
    private func onSignatureChange(){
        var base64StringOfImage = "";
        if let signatureImage = getSignatureImage(){
            base64StringOfImage =  getBase64StringOfImage(signatureImage) ?? "";
        }
        delegate?.onSignatureChangesCb(base64StringOfImage);
    }
    
    @objc public func clearSignature(){
        currentPath.removeAllPoints();
        drawPaths();
        self.onSignatureChange();
    }
    
    @objc public func setSignatureColor(_ signColor:UIColor){
        pathLayer.strokeColor = signColor.cgColor;
    }
    
    func drawPaths(){
        pathLayer.path = currentPath.cgPath;
    }
}



