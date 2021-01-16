//
//  KeyboardLayoutConstraint.swift
//  ShopTest
//
//  Created by david cortes on 15/01/21.
//

import Foundation
import UIKit

open class KeyboardLayoutConstraint: NSLayoutConstraint {
    
    fileprivate var offset : CGFloat = 0
    fileprivate var keyboardVisibleHeight : CGFloat = 0
    override open func awakeFromNib() {
        super.awakeFromNib()
        
        offset = constant
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShowNotification), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHideNotification), name: UIResponder.keyboardWillHideNotification, object: nil)
        
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    
    
    // MARK: Notification
    
    @objc func keyboardWillShowNotification(notification: NSNotification) {
        
        if let userInfo = notification.userInfo {
            if let frameValue = userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue {
                let frame = frameValue.cgRectValue
                keyboardVisibleHeight = frame.size.height
            }
            
            self.updateConstant()
            switch (userInfo[UIResponder.keyboardAnimationDurationUserInfoKey] as? NSNumber, userInfo[UIResponder.keyboardAnimationCurveUserInfoKey] as? NSNumber) {
            case let (.some(duration), .some(curve)):
                
                let options = UIView.AnimationOptions(rawValue: curve.uintValue)
                
                UIView.animate(
                    withDuration: TimeInterval(duration.doubleValue),
                    delay: 0,
                    options: options,
                    animations: {
                        UIApplication.shared.windows.filter {$0.isKeyWindow}.first?.layoutIfNeeded()
                        return
                    }, completion: { finished in
                    })
            default:
                
                break
            }
            
        }
        
    }
    
    @objc func keyboardWillHideNotification(notification: NSNotification) {
        keyboardVisibleHeight = 0
        self.updateConstant()
        
        
        
        if let userInfo = notification.userInfo {
            
            switch (userInfo[UIResponder.keyboardAnimationDurationUserInfoKey] as? NSNumber, userInfo[UIResponder.keyboardAnimationCurveUserInfoKey] as? NSNumber) {
            case let (.some(duration), .some(curve)):
                
                let options = UIView.AnimationOptions(rawValue: curve.uintValue)
                
                UIView.animate(
                    withDuration: TimeInterval(duration.doubleValue),
                    delay: 0,
                    options: options,
                    animations: {
                        UIApplication.shared.windows.filter {$0.isKeyWindow}.first?.layoutIfNeeded()
                        return
                    }, completion: { finished in
                    })
            default:
                break
            }
        }
    }
    
    func updateConstant() {
        self.constant = offset + keyboardVisibleHeight
    }
    
}

