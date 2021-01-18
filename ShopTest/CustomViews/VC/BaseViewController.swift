//
//  BaseViewController.swift
//  ShopTest
//
//  Created by david cortes on 15/01/21.
//

import UIKit

class BaseViewController: UIViewController {
    
    var loaderView = UIView()
    var navigationBar = UIView()
    var backgroundNavigationBar = UIView()
    var backButtonNavigationBar = UIButton(type: .custom)
    var titleLabelNavigationBar = NavigationBarTitleLabel()
    
    
    override func viewDidLoad() {
        setUpUI()
        modalPresentationStyle = .overFullScreen
        self.navigationController?.modalPresentationStyle = .overFullScreen
        self.navigationController?.isNavigationBarHidden = true
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    func setUpUI() {
        navigationBar.isHidden = true
        backgroundNavigationBar.isHidden = true
        self.view.backgroundColor = UIColor.grayMainColor
        navigationBar.backgroundColor = UIColor.yellowMainColor
        backgroundNavigationBar.backgroundColor = UIColor.yellowMainColor
        view.addSubview(backgroundNavigationBar)
        view.addSubview(navigationBar)
        navigationBar.addSubview(backButtonNavigationBar)
        navigationBar.addSubview(titleLabelNavigationBar)
        backButtonNavigationBar.setImage(UIImage(named: "backButton"), for: .normal)
        backButtonNavigationBar.setImage(UIImage(named: "backButton"), for: .normal)
        backButtonNavigationBar.imageView?.contentMode = .scaleAspectFit
        backButtonNavigationBar.imageEdgeInsets = UIEdgeInsets(top: 0, left: -20, bottom: 0, right: 0)
        backButtonNavigationBar.addTarget(self, action: #selector(actionBack), for: .touchUpInside)
        backButtonNavigationBar.titleLabel?.font = UIFont.getFont(.regular, size: 16)
        backButtonNavigationBar.setTitleColor(.black, for: .normal)
        titleLabelNavigationBar.textAlignment = .center
        titleLabelNavigationBar.text = "Shopping"
        setUpConstraints()
    }
    
    func setUpConstraints() {
        setUpNavigationBarConstraints()
        setUpBackgroundNavigationBarConstraint()
        setUpBackButtonNBConstraints()
        setUpTitleConstraints()
    }
    
    func setUpBackgroundNavigationBarConstraint(){
        backgroundNavigationBar.translatesAutoresizingMaskIntoConstraints = false
        
        let leftConstraint = NSLayoutConstraint(item: backgroundNavigationBar,
                                                attribute: NSLayoutConstraint.Attribute.leading,
                                                relatedBy: NSLayoutConstraint.Relation.equal,
                                                toItem: view, attribute: NSLayoutConstraint.Attribute.leading,
                                                multiplier: 1, constant: 0)
        let rightConstraint = NSLayoutConstraint(item: backgroundNavigationBar,
                                                 attribute: NSLayoutConstraint.Attribute.trailing,
                                                 relatedBy: NSLayoutConstraint.Relation.equal,
                                                 toItem: view,
                                                 attribute: NSLayoutConstraint.Attribute.trailing, multiplier: 1,
                                                 constant: 0)
        let topConstraint = NSLayoutConstraint(item: backgroundNavigationBar,
                                               attribute: NSLayoutConstraint.Attribute.top,
                                               relatedBy: NSLayoutConstraint.Relation.equal,
                                               toItem: view, attribute: NSLayoutConstraint.Attribute.top,
                                               multiplier: 1,
                                               constant: 0)
        let heightConstraint = NSLayoutConstraint(item: backgroundNavigationBar,
                                                  attribute: NSLayoutConstraint.Attribute.bottom,
                                                  relatedBy: NSLayoutConstraint.Relation.equal,
                                                  toItem: navigationBar, attribute: NSLayoutConstraint.Attribute.bottom,
                                                  multiplier: 1,
                                                  constant: 0)
        view.addConstraints([leftConstraint, rightConstraint, topConstraint, heightConstraint])
    }
    
    func setUpNavigationBarConstraints() {
        navigationBar.translatesAutoresizingMaskIntoConstraints = false
        
        let leftConstraint = NSLayoutConstraint(item: navigationBar,
                                                attribute: NSLayoutConstraint.Attribute.leading,
                                                relatedBy: NSLayoutConstraint.Relation.equal,
                                                toItem: view, attribute: NSLayoutConstraint.Attribute.leading,
                                                multiplier: 1, constant: 0)
        let rightConstraint = NSLayoutConstraint(item: navigationBar,
                                                 attribute: NSLayoutConstraint.Attribute.trailing,
                                                 relatedBy: NSLayoutConstraint.Relation.equal,
                                                 toItem: view,
                                                 attribute: NSLayoutConstraint.Attribute.trailing, multiplier: 1,
                                                 constant: 0)
        let topConstraint = NSLayoutConstraint(item: navigationBar,
                                               attribute: NSLayoutConstraint.Attribute.top,
                                               relatedBy: NSLayoutConstraint.Relation.equal,
                                               toItem: view, attribute: NSLayoutConstraint.Attribute.topMargin,
                                               multiplier: 1,
                                               constant: 0)
        let heightConstraint = NSLayoutConstraint(item: navigationBar,
                                                  attribute: NSLayoutConstraint.Attribute.height,
                                                  relatedBy: NSLayoutConstraint.Relation.equal,
                                                  toItem: nil, attribute: NSLayoutConstraint.Attribute.notAnAttribute,
                                                  multiplier: 1,
                                                  constant: 44)
        view.addConstraints([leftConstraint, rightConstraint, topConstraint, heightConstraint])
    }
    
    func setUpBackButtonNBConstraints() {
        backButtonNavigationBar.translatesAutoresizingMaskIntoConstraints = false
        let leftConstraint = NSLayoutConstraint(item: backButtonNavigationBar,
                                                attribute: NSLayoutConstraint.Attribute.leading,
                                                relatedBy: NSLayoutConstraint.Relation.equal,
                                                toItem: navigationBar, attribute: NSLayoutConstraint.Attribute.leading,
                                                multiplier: 1, constant: 10)
        let widthConstraint = NSLayoutConstraint(item: backButtonNavigationBar,
                                                 attribute: NSLayoutConstraint.Attribute.width,
                                                 relatedBy: NSLayoutConstraint.Relation.equal,
                                                 toItem: nil,
                                                 attribute: NSLayoutConstraint.Attribute.notAnAttribute, multiplier: 1,
                                                 constant: 36)
        let centerConstraint = NSLayoutConstraint(item: backButtonNavigationBar,
                                                  attribute: NSLayoutConstraint.Attribute.centerY,
                                                  relatedBy: NSLayoutConstraint.Relation.equal,
                                                  toItem: navigationBar, attribute: NSLayoutConstraint.Attribute.centerY,
                                                  multiplier: 1,
                                                  constant: 0)
        let heightConstraint = NSLayoutConstraint(item: backButtonNavigationBar,
                                                  attribute: NSLayoutConstraint.Attribute.height,
                                                  relatedBy: NSLayoutConstraint.Relation.equal,
                                                  toItem: nil, attribute: NSLayoutConstraint.Attribute.notAnAttribute,
                                                  multiplier: 1,
                                                  constant: 36)
        view.addConstraints([leftConstraint, widthConstraint, centerConstraint, heightConstraint])
    }
    
    
    func setUpTitleConstraints() {
        titleLabelNavigationBar.translatesAutoresizingMaskIntoConstraints = false
        let leftConstraint = NSLayoutConstraint(item: titleLabelNavigationBar,
                                                attribute: NSLayoutConstraint.Attribute.leading,
                                                relatedBy: NSLayoutConstraint.Relation.equal,
                                                toItem: view, attribute: NSLayoutConstraint.Attribute.leading,
                                                multiplier: 1, constant: 40)
        let rightConstraint = NSLayoutConstraint(item: titleLabelNavigationBar,
                                                 attribute: NSLayoutConstraint.Attribute.trailing,
                                                 relatedBy: NSLayoutConstraint.Relation.equal,
                                                 toItem: view,
                                                 attribute: NSLayoutConstraint.Attribute.trailing, multiplier: 1,
                                                 constant: -40)
        let centerConstraint = NSLayoutConstraint(item: titleLabelNavigationBar,
                                               attribute: NSLayoutConstraint.Attribute.centerY,
                                               relatedBy: NSLayoutConstraint.Relation.equal,
                                               toItem: navigationBar, attribute: NSLayoutConstraint.Attribute.centerY,
                                               multiplier: 1,
                                               constant: 0)
        let heightConstraint = NSLayoutConstraint(item: titleLabelNavigationBar,
                                                  attribute: NSLayoutConstraint.Attribute.height,
                                                  relatedBy: NSLayoutConstraint.Relation.equal,
                                                  toItem: navigationBar, attribute: NSLayoutConstraint.Attribute.height,
                                                  multiplier: 1,
                                                  constant: 0)
        view.addConstraints([leftConstraint, rightConstraint, centerConstraint, heightConstraint])
    }

    
    
    func showLoader(show: Bool) {
        if show {
            DispatchQueue.main.asyncAfter(deadline: .now()+0.1) {
                UIViewController.removeSpinner(spinner: self.loaderView)
                self.loaderView =  UIViewController.displaySpinner(onView: self.view)
            }
        } else {
            DispatchQueue.main.asyncAfter(deadline: .now()+0.1) {
                UIViewController.removeSpinner(spinner: self.loaderView)
            }
        }
    }
    
    @objc func actionBack() {
        self.navigationController?.popViewController(animated: true)
    }
    

}




