//
//  BaseViewController.swift
//  ShopTest
//
//  Created by david cortes on 15/01/21.
//

import UIKit

class BaseViewController: UIViewController {
    
    var loaderView = UIView()
    
    
    override func viewDidLoad() {
        setUpUI()
        modalPresentationStyle = .overFullScreen
        self.navigationController?.modalPresentationStyle = .overFullScreen

    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    func setUpUI() {
        
        
    }
    
    
    
    @objc func closeView(){
        self.dismiss(animated: true, completion: nil)
    }
    
    
    func showLoader(show: Bool) {
        if show {
            DispatchQueue.main.asyncAfter(deadline: .now()+0.1) {
                self.loaderView =  UIViewController.displaySpinner(onView: self.view)
            }
        } else {
            DispatchQueue.main.asyncAfter(deadline: .now()+0.1) {
                UIViewController.removeSpinner(spinner: self.loaderView)
            }
        }
    }
    

}




