//
//  AlertManager.swift
//  ShopTest
//
//  Created by david cortes on 18/01/21.
//

import Foundation

struct AlertManager {
    
    static func alertInfoWithAction(mainText: String,
                                    actionButtonTitle:String,
                                    action: @escaping () -> Void) -> AlertViewController {
        let alertView = AlertViewController(mainText: mainText, actionButtonTitle: actionButtonTitle, firstSelector: action)
        alertView.modalPresentationStyle = .overCurrentContext
        alertView.modalTransitionStyle = .crossDissolve
        
        return alertView
    }
    
    static func alertChooseAction(mainText: String,
                                  actionButtonTitle: String,
                                  positiveAction: @escaping () -> Void,
                                  secundaryButtonTitle: String,
                                  negativeAction: @escaping () -> Void) -> AlertViewController {
        let alertView = AlertViewController(mainText: mainText, actionButtonTitle: actionButtonTitle, firstSelector: positiveAction, secundaryButtonTitle: secundaryButtonTitle, secondSelector: negativeAction)
        alertView.modalPresentationStyle = .overCurrentContext
        alertView.modalTransitionStyle = .crossDissolve
        
        return alertView
    }

}
