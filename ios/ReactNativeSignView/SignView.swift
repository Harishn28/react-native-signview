//
//  CircularView.swift
//  CustomViewSample
//
//  Created by Harish on 09/02/19.
//

import Foundation
import UIKit

class SignView: UIView {
    
    var currentPath = UIBezierPath();
    let pathLayer = CAShapeLayer();
    
    
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
    
    @objc public func clearSignature(){
        currentPath.removeAllPoints();
        drawPaths();
    }
    
    @objc public func setSignatureColor(){
        print("----setSignatureColor: to be done");
        pathLayer.strokeColor = UIColor.red.cgColor;
    }
    
    func drawPaths(){
        pathLayer.path = currentPath.cgPath;
    }
}



