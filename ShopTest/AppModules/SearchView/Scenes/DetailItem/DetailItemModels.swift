//
//  DetailItemModels.swift
//  ShopTest
//
//  Created by david cortes on 19/01/21.
//  Copyright (c) 2021 ___ORGANIZATIONNAME___. All rights reserved.

import UIKit

enum DetailItem {
    // MARK: Use cases
    
    enum LoadInitalData {
        struct Request {
        }
        struct Response {
            var resultSearch:ResultSearch
        }
        struct ViewModel {
            var titleView:String
            var resultSearch:ResultSearch
            var detail:[DetailDescription]
        }
    }
}


struct DetailDescription{
    var title:String
    var detail:String
}
