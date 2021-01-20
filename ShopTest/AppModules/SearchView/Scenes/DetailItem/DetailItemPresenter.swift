//
//  DetailItemPresenter.swift
//  ShopTest
//
//  Created by david cortes on 19/01/21.
//  Copyright (c) 2021 ___ORGANIZATIONNAME___. All rights reserved.

import UIKit

protocol DetailItemPresentationLogic {
    func presentInitialInformation(response: DetailItem.LoadInitalData.Response)
}

class DetailItemPresenter: DetailItemPresentationLogic {
    weak var viewController: DetailItemDisplayLogic?
    
    func presentInitialInformation(response: DetailItem.LoadInitalData.Response) {
        let description = DetailDescription(title: NSLocalizedString("detailView.description.Title", comment: ""), detail: response.resultSearch.title ?? "")
        let cost = DetailDescription(title: NSLocalizedString("detailView.Cost.Title", comment: ""), detail: response.resultSearch.priceDisplaypriceDisplay)
        let brandValue = response.resultSearch.attributes?.first{ $0.id == "BRAND"}?.valueName ?? ""
        let brand = DetailDescription(title: NSLocalizedString("detailView.Brand.Title", comment: ""), detail: brandValue)
        let cityValue = "\(response.resultSearch.sellerAddress?.country?.name ?? "") \(response.resultSearch.sellerAddress?.city?.name ?? "")"
        let city = DetailDescription(title: NSLocalizedString("detailView.City.Title", comment: ""), detail: cityValue)
        let  detailDescription = [description, cost, brand, city].filter({$0.detail != ""})
        let viewModel = DetailItem.LoadInitalData.ViewModel(titleView: NSLocalizedString("Shopping", comment: ""), resultSearch: response.resultSearch, detail: detailDescription)
        viewController?.displayInitialInformation(viewModel: viewModel)
    }
}

