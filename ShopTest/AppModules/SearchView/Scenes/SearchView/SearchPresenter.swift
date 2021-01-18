//
//  SearchPresenter.swift
//  ShopTest
//
//  Created by david cortes on 16/01/21.


import UIKit

protocol SearchPresentationLogic {
    func presentInitialInformation(response: Search.LoadInitalData.Response)
    func presentShowResults(response:Search.SearchByTerm.Response)
    func presentMoreResults(response:Search.GetMoreResults.Response)
    func presentError(response:Search.ShowError.Response)
}

class SearchPresenter: SearchPresentationLogic {
    weak var viewController: SearchDisplayLogic?
    
    func presentInitialInformation(response: Search.LoadInitalData.Response) {
        let viewModel = Search.LoadInitalData.ViewModel(navBarTitle: response.navBarTitle, placeholderSearchView: response.placeholderSearchView, initialMessage: response.initialMessage)
        viewController?.displayInitialInformation(viewModel: viewModel)
    }
    
    func presentShowResults(response:Search.SearchByTerm.Response){
        let viewModel = Search.SearchByTerm.ViewModel(resultSearch: response.resultSearch)
        viewController?.displaySearchResults(viewModel: viewModel)
    }
    
    func presentMoreResults(response: Search.GetMoreResults.Response) {
        let viewModel = Search.GetMoreResults.ViewModel(resultSearch: response.resultSearch)
        viewController?.displayMoreItems(viewModel: viewModel)
    }
    func presentError(response:Search.ShowError.Response){
        let viewModel = Search.ShowError.ViewModel(errorMessage: response.errorMessage.getErrorMessage())
        viewController?.displayMessageError(viewmodel: viewModel)
    }
}

