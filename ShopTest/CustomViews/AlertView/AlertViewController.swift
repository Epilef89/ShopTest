//
//  AlertViewController.swift
//  ShopTest
//
//  Created by david cortes on 18/01/21.
//

import UIKit

class AlertViewController: UIViewController {
    
    //MARK: IBOutlets
    @IBOutlet weak var messageLabel: AlertMessage!
    @IBOutlet weak var primaryButton: MainButton!
    @IBOutlet weak var secundaryButton: SecundaryButton!
    @IBOutlet weak var contentMessageView: UIView!
    
    //MARK: Variables
    var mainText: String = ""
    var actionButtonTitle = ""
    var secundaryButtonTitle = ""
    
    typealias PositiveAction = () -> Void
    typealias NegativeAction = () -> Void
    
    var positiveAction: PositiveAction
    var negativeAction: NegativeAction

    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }

    func setup() {
        self.view.backgroundColor = UIColor.transparentBackgroundAlert
        view.isOpaque = false
        
        messageLabel.text = mainText
        primaryButton.showsTouchWhenHighlighted = true
        primaryButton.addTarget(self, action:#selector(actionPrimaryButton) , for: .touchUpInside)
        primaryButton.setTitle(actionButtonTitle, for: .normal)
        secundaryButton.showsTouchWhenHighlighted = true
        secundaryButton.addTarget(self, action: #selector(actionSecundaryButton), for: .touchUpInside)
        secundaryButton.setTitle(secundaryButtonTitle, for: .normal)
        contentMessageView.layer.masksToBounds = true
        contentMessageView.layer.cornerRadius = 8
        if secundaryButtonTitle == ""{
            secundaryButton.isHidden = true
        }
        
        
    }
    
    init(mainText: String,
         actionButtonTitle: String,
         firstSelector: @escaping PositiveAction) {
            self.mainText = mainText
            self.actionButtonTitle = actionButtonTitle
            positiveAction = firstSelector
            negativeAction = {}
        super.init(nibName: "AlertViewController", bundle: nil)
            
    }

    init(mainText: String, actionButtonTitle: String, firstSelector: @escaping PositiveAction,
         secundaryButtonTitle: String, secondSelector: @escaping NegativeAction) {
        self.mainText = mainText
        self.actionButtonTitle = actionButtonTitle
        self.secundaryButtonTitle = secundaryButtonTitle
        positiveAction = firstSelector
        negativeAction = secondSelector
        super.init(nibName: "AlertViewController", bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        positiveAction = {}
        negativeAction = {}
        self.mainText = ""
        self.actionButtonTitle = ""
        self.secundaryButtonTitle = ""
        super.init(coder: aDecoder)
    }
    
    @objc func actionPrimaryButton(){
        
        self.dismiss(animated: true) {
            self.positiveAction()
        }
    }


    @objc func actionSecundaryButton(){
        self.dismiss(animated: true){
            self.negativeAction()
        }
    }

}
