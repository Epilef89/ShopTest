//
//  DetailItemInteractor.swift
//  ShopTest
//
//  Created by david cortes on 19/01/21.
//  Copyright (c) 2021 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

protocol DetailItemBusinessLogic {
    func loadInitialInformation(request: DetailItem.LoadInitalData.Request)
}

protocol DetailItemDataStore {
    var resultSearch:ResultSearch? {get set}
}

class DetailItemInteractor: DetailItemBusinessLogic, DetailItemDataStore {
    var presenter: DetailItemPresentationLogic?
    var worker: DetailItemWorker?
    var resultSearch:ResultSearch?
    
    func loadInitialInformation(request: DetailItem.LoadInitalData.Request) {
        
        guard let resultSearch = self.resultSearch else{
            return
        }
        let response = DetailItem.LoadInitalData.Response(resultSearch: resultSearch)
        presenter?.presentInitialInformation(response: response)
    }
}

