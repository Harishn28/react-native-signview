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
        print("----------sd");
        self.backgroundColor = UIColor.white;
        
        pathLayer.path = currentPath.cgPath;
        pathLayer.strokeColor = UIColor.black.cgColor;
        pathLayer.lineWidth = 2;
        self.layer.addSublayer(pathLayer);
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(onTap))
        self.addGestureRecognizer(tap)
    }
    
    @objc public func onTap(sender: UITapGestureRecognizer? = nil) {
        print("----Tapped");
        currentPath.addArc(withCenter: currentPath.currentPoint, radius: 2, startAngle: 0, endAngle: .pi * 2, clockwise: false);
        drawPaths();
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        print("------touches began");
        let touch = touches.first!
        let location = touch.location(in: self)
        currentPath.move(to: location);
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        print("------touches ended");
        let touch = touches.first!
        let location = touch.location(in: self)
        currentPath.move(to: location);
        drawPaths();
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        //        print("------touches moved");
        let touch = touches.first!
        let location = touch.location(in: self)
        self.currentPath.addLine(to: location);
        self.currentPath.move(to: location);
        drawPaths();
    }
    
    @objc public func clearSignature(){
        currentPath.removeAllPoints();
        drawPaths();
    }
    
    func drawPaths(){
        pathLayer.path = currentPath.cgPath;
    }
}



