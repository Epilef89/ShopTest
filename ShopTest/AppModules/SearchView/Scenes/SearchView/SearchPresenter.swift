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
    func presentGoToDetail(response:Search.GoToDetail.Response)
}

class SearchPresenter: SearchPresentationLogic {
    weak var viewController: SearchDisplayLogic?
    
    func presentInitialInformation(response: Search.LoadInitalData.Response) {
        let navBarTitle = NSLocalizedString("searchView.navigationBar.Title", comment: "")
        let placeholderSearchView = NSLocalizedString("searchView.searchBar.placeholder", comment: "")
        let initialMessage = NSLocalizedString("searchView.initialMessage", comment: "")
        
        let viewModel = Search.LoadInitalData.ViewModel(navBarTitle: navBarTitle, placeholderSearchView: placeholderSearchView, initialMessage: initialMessage)
        viewController?.displayInitialInformation(viewModel: viewModel)
    }
    
    func presentShowResults(response:Search.SearchByTerm.Response){
        let totlaResultsCount = NSLocalizedString("searchView.quantityResultsMessage", comment: "")
            .replacingOccurrences(of: "$0", with: String(response.totalResultsCount))
            .replacingOccurrences(of: "$1", with: response.term)
        let viewModel = Search.SearchByTerm.ViewModel(resultSearch: response.resultSearch, totalResultsCount: totlaResultsCount, moreResults: response.moreResults)
        viewController?.displaySearchResults(viewModel: viewModel)
    }
    
    func presentMoreResults(response: Search.GetMoreResults.Response) {
        let viewModel = Search.GetMoreResults.ViewModel(resultSearch: response.resultSearch, totalResultsCount: String(response.totalResultsCount), moreResults: response.moreResults)
        viewController?.displayMoreItems(viewModel: viewModel)
    }
    func presentError(response:Search.ShowError.Response){
        let viewModel = Search.ShowError.ViewModel(errorMessage: response.errorMessage.getErrorMessage(), retry: response.retry, titlePrimaryButton: NSLocalizedString("aceptButton", comment: ""), titleSecundaryButton:  NSLocalizedString("retryButton", comment: ""))
        viewController?.displayMessageError(viewmodel: viewModel)
    }
    func presentGoToDetail(response:Search.GoToDetail.Response){
        let viewModel = Search.GoToDetail.ViewModel()
        viewController?.displayGoToDetail(viewModel: viewModel)
    }
}

