//
//  CurvedView.swift
//  BookStore
//
//  Created by amir on 19.11.2020.
//

import UIKit

@IBDesignable class CurvedView: UIView {

    @IBInspectable var curveHeight:CGFloat = 50.0
    
    var curvedLayer = CAShapeLayer()
    
    override func draw(_ rect: CGRect) {
        
        let path = UIBezierPath()
        path.move(to: CGPoint(x: 0, y: 0))
        path.addLine(to: CGPoint(x: rect.width, y: 0))
        path.addLine(to: CGPoint(x: rect.width, y: rect.height))
        path.addArc(withCenter: CGPoint(x: CGFloat(rect.width) - curveHeight, y: rect.height), radius: curveHeight, startAngle: 0, endAngle: 1.5 * CGFloat.pi, clockwise: false)
        path.addLine(to: CGPoint(x: curveHeight, y: rect.height - curveHeight))
        path.addArc(withCenter: CGPoint(x: curveHeight, y: rect.height - (curveHeight * 2.0)), radius: curveHeight, startAngle: 0, endAngle:  CGFloat.pi, clockwise: true)
        
        path.close()
        
        curvedLayer.path = path.cgPath
        curvedLayer.fillColor = UIColor.darkGray.cgColor
        curvedLayer.frame = rect
        
        self.layer.insertSublayer(curvedLayer, at: 0)
        self.backgroundColor = .clear
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowRadius = 10.0
        self.layer.shadowOpacity = 0.7
    }
    
}
