//
//  UIView+Extension.swift
//  BookStore
//
//  Created by amir on 19.11.2020.
//

import UIKit

typealias Gradient = (UIColor, UIColor)

extension UIView {
    
    public func fillSuperView(constant : CGFloat = 0) {
        translatesAutoresizingMaskIntoConstraints = false
        if let superview = superview {
            leadingAnchor.constraint(equalTo: superview.leadingAnchor,constant:constant).isActive = true
            trailingAnchor.constraint(equalTo: superview.trailingAnchor,constant:-constant).isActive = true
            topAnchor.constraint(equalTo: superview.topAnchor,constant:constant).isActive = true
            bottomAnchor.constraint(equalTo: superview.bottomAnchor,constant:-constant).isActive = true
        }
    }
    
    public func fillSafeAreaSuperView(constant : CGFloat = 0) {
        translatesAutoresizingMaskIntoConstraints = false
        if let superview = superview {
            leadingAnchor.constraint(equalTo: superview.safeAreaLayoutGuide.leadingAnchor,constant:constant).isActive = true
            trailingAnchor.constraint(equalTo: superview.safeAreaLayoutGuide.trailingAnchor,constant:-constant).isActive = true
            topAnchor.constraint(equalTo: superview.safeAreaLayoutGuide.topAnchor,constant:constant).isActive = true
            bottomAnchor.constraint(equalTo: superview.safeAreaLayoutGuide.bottomAnchor, constant:-constant).isActive = true
        }
    }
    
    public func anchorCenterXToSuperview(constant: CGFloat = 0) {
        translatesAutoresizingMaskIntoConstraints = false
        if let anchor = superview?.centerXAnchor {
            centerXAnchor.constraint(equalTo: anchor, constant: constant).isActive = true
        }
    }
    
    public func anchorCenterYToSuperview(constant: CGFloat = 0) {
        translatesAutoresizingMaskIntoConstraints = false
        if let anchor = superview?.centerYAnchor {
            centerYAnchor.constraint(equalTo: anchor, constant: constant).isActive = true
        }
    }
    
    public func anchorCenterSuperview() {
        anchorCenterXToSuperview()
        anchorCenterYToSuperview()
    }
    
    func anchor(top : NSLayoutYAxisAnchor?  , leading : NSLayoutXAxisAnchor? , bottom :  NSLayoutYAxisAnchor? , trailing : NSLayoutXAxisAnchor?, paddingTop :  CGFloat , paddingleft : CGFloat , paddingBottom :  CGFloat , paddingRight : CGFloat , width : CGFloat  , height : CGFloat, centerX : NSLayoutXAxisAnchor?, centerY : NSLayoutYAxisAnchor?)  {
        
        self.translatesAutoresizingMaskIntoConstraints = false
        
        if let top = top {
            self.topAnchor.constraint(equalTo: top, constant: paddingTop).isActive = true
        }
        if let left = leading {
            self.leadingAnchor.constraint(equalTo: left, constant: paddingleft).isActive = true
        }
        if let bottom = bottom {
            self.bottomAnchor.constraint(equalTo: bottom, constant: -paddingBottom).isActive = true
        }
        if let right = trailing {
            self.trailingAnchor.constraint(equalTo: right, constant: -paddingRight).isActive = true
        }
        if width != 0  {
            self.widthAnchor.constraint(equalToConstant: width).isActive = true
        }
        if height != 0 {
            self.heightAnchor.constraint(equalToConstant: height).isActive = true
        }
        if let centerX = centerX {
            self.centerXAnchor.constraint(equalTo: centerX).isActive = true
        }
        if let centerY = centerY {
            self.centerYAnchor.constraint(equalTo: centerY).isActive = true
        }
    }
    
    func shakeView() {
        let animation = CABasicAnimation(keyPath: "position")
        animation.duration = 0.07
        animation.repeatCount = 3
        animation.autoreverses = true
        animation.fromValue = NSValue(cgPoint: CGPoint(x: self.center.x - 10, y: self.center.y))
        animation.toValue = NSValue(cgPoint: CGPoint(x: self.center.x + 10, y: self.center.y))
        self.layer.add(animation, forKey: "position")
    }
    
    func roundCorners(corners: UIRectCorner, radius: CGFloat) {
        let path = UIBezierPath(roundedRect: bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        layer.mask = mask
    }
    
    internal func screenSize() ->(width : CGFloat,height : CGFloat){
        guard let window = UIApplication.shared.keyWindow else { return (0,0) }
        let width = window.frame.width
        let height = window.frame.height
        return (width ,height)
    }
    
    @discardableResult
    func applyGradient(_ gradientColors: Gradient, startPoint: CGPoint = CGPoint(x: 0.0, y: 0.0), endPoint: CGPoint = CGPoint(x: 1.0, y: 1.0)) -> CAGradientLayer {
        removeGradientLayerIfNeeded()
        let gradient = CAGradientLayer()
        gradient.colors = [gradientColors.0.cgColor, gradientColors.1.cgColor]
        gradient.locations = [0.0, 1.0]
        gradient.startPoint = startPoint
        gradient.endPoint = endPoint
        gradient.frame = self.bounds
        gradient.setValue(998877, forKey: "tag")
        self.layer.insertSublayer(gradient, at: 0)
        return gradient
    }

    func removeGradientLayerIfNeeded() {
        var gradientLayer: CALayer?
        self.layer.sublayers?.forEach({ (sublayer) in
            if let tag = sublayer.value(forKey: "tag") {
                if (tag as! Int) == 998877 {
                    gradientLayer = sublayer
                }
            }
        })
        if gradientLayer != nil {
            gradientLayer?.removeFromSuperlayer()
        }
    }
}
