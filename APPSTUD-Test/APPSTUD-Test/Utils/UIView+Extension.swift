//
//  UIView+Extension.swift
//  APPSTUD-Test
//
//  Created by Yauheni Shauchenka on 5/25/17.
//  Copyright © 2017 com.appstub. All rights reserved.
//

import Foundation
import UIKit

public extension UIView {
    
    func getBlurryViewWithFrame(_ frame : CGRect, border : Bool) -> UIView {
        
        var blurEffect : UIVisualEffect
        blurEffect = UIBlurEffect(style: .dark)
        let visualEffectView = UIVisualEffectView(effect : blurEffect)
        visualEffectView.frame = frame;
        
        if (border) {
            let border = UIView(frame: CGRect(x: 0, y: 0, width: frame.width, height: 0.5))
            border.backgroundColor = colorWithBrightness(1);
            border.alpha = 0.1;
            visualEffectView.addSubview(border)
        }
        
        let result = visualEffectView;
        return result;
    }
    
    // MARK: - private method
    fileprivate func colorWithBrightness(_ brightness : CGFloat) -> UIColor {
        return UIColor(hue: 0, saturation: 0, brightness: brightness, alpha: 1)
    }
    
    /**
     Rounds the given set of corners to the specified radius
     
     - parameter corners: Corners to round
     - parameter radius:  Radius to round to
     */
    func round(_ corners: UIRectCorner, radius: CGFloat) {
        _=_round(corners, radius: radius)
    }
    
    /**
     Rounds the given set of corners to the specified radius with a border
     
     - parameter corners:     Corners to round
     - parameter radius:      Radius to round to
     - parameter borderColor: The border color
     - parameter borderWidth: The border width
     */
    func round(_ corners: UIRectCorner, radius: CGFloat, borderColor: UIColor, borderWidth: CGFloat) {
        let mask = _round(corners, radius: radius)
        addBorder(mask, borderColor: borderColor, borderWidth: borderWidth)
    }
    
    /**
     Fully rounds an autolayout view (e.g. one with no known frame) with the given diameter and border
     
     - parameter diameter:    The view's diameter
     - parameter borderColor: The border color
     - parameter borderWidth: The border width
     */
    func fullyRound(_ diameter: CGFloat, borderColor: UIColor, borderWidth: CGFloat) {
        layer.masksToBounds = true
        layer.cornerRadius = diameter / 2
        layer.borderWidth = borderWidth
        layer.borderColor = borderColor.cgColor;
    }
}

private extension UIView {
    func _round(_ corner: UIRectCorner, radius: CGFloat) -> CAShapeLayer {
        let path = UIBezierPath(roundedRect: bounds, byRoundingCorners: corner, cornerRadii: CGSize(width: radius, height: radius))
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        self.layer.mask = mask
        return mask
    }
    
    func addBorder(_ mask: CAShapeLayer, borderColor: UIColor, borderWidth: CGFloat) {
        let borderLayer = CAShapeLayer()
        borderLayer.path = mask.path
        borderLayer.fillColor = UIColor.clear.cgColor
        borderLayer.strokeColor = borderColor.cgColor
        borderLayer.lineWidth = borderWidth
        borderLayer.frame = bounds
        layer.addSublayer(borderLayer)
    }
}
