//
//  UIViewControllerExtension.swift
//  ShopTest
//
//  Created by david cortes on 15/01/21.
//

import UIKit

extension UIViewController {
    
    class func displaySpinner(onView: UIView) -> UIView {
        let spinnerView =  UIView.init(frame: onView.bounds)
        spinnerView.backgroundColor = UIColor.init(red: 0.5, green: 0.5, blue: 0.5, alpha: 0.5)
        let aIndicator = UIActivityIndicatorView.init(style: .large)
        aIndicator.startAnimating()
        aIndicator.center = spinnerView.center
        aIndicator.color = UIColor.yellow
        
        DispatchQueue.main.async {
            spinnerView.addSubview(aIndicator)
            onView.addSubview(spinnerView)
        }
        
        return spinnerView
    }
    
    class func removeSpinner(spinner: UIView) {
        DispatchQueue.main.async {
            spinner.removeFromSuperview()
        }
    }
}

public func print(_ items: String..., filename: String = #file, function : String = #function, line: Int = #line, separator: String = " ", terminator: String = "\n") {
    #if Develop || QA
        let pretty = "\(URL(fileURLWithPath: filename).lastPathComponent) [#\(line)] \(function)\n\t-> "
        let output = items.map { "\($0)" }.joined(separator: separator)
        Swift.print(pretty+output, terminator: terminator)
    #endif
}
