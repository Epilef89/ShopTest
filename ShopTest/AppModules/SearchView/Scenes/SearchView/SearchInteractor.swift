//
//  SearchInteractor.swift
//  ShopTest
//
//  Created by david cortes on 16/01/21.


import UIKit

protocol SearchBusinessLogic {
    func loadInitialInformation(request: Search.LoadInitalData.Request)
    func searchByTerm(request:Search.SearchByTerm.Request)
    func getMoreItemsByPreviousTerm(request:Search.GetMoreResults.Request)
}

protocol SearchDataStore {
    var wattingService:Bool {get set}
}

class SearchInteractor: SearchBusinessLogic, SearchDataStore {
    var presenter: SearchPresentationLogic?
    var worker: SearchWorker?
    var offset: Int = 0
    var term:String = ""
    var wattingService:Bool = false
    
    func loadInitialInformation(request: Search.LoadInitalData.Request) {
        
        let navBarTitle = NSLocalizedString("searchView.navigationBar.Title", comment: "")
        let placeholderSearchView = NSLocalizedString("searchView.searchBar.placeholder", comment: "")
        let initialMessage = NSLocalizedString("searchView.initialMessage", comment: "")
        let response = Search.LoadInitalData.Response(navBarTitle: navBarTitle, placeholderSearchView: placeholderSearchView, initialMessage: initialMessage)
        presenter?.presentInitialInformation(response: response)
    }
    
    func searchByTerm(request:Search.SearchByTerm.Request){
        
        #warning("Pendiente cambiar de tienda")
        KeyManager().set(country: "MLA")
        let country = KeyManager().getCountry() ?? ""
        offset = 0
        term = request.term
        wattingService = true
        getResultsBy(term: request.term, country: country, offset: offset) { (results, error)  in
            self.wattingService = false
            if error == nil{
                let response = Search.SearchByTerm.Response(resultSearch: results)
                self.presenter?.presentShowResults(response: response)
            }else{
                let response = Search.ShowError.Response(errorMessage: error ?? CustomErrors.errorGeneralResponse)
                self.presenter?.presentError(response: response)
            }
        }
    }
    
    func getMoreItemsByPreviousTerm(request:Search.GetMoreResults.Request){
        let country = KeyManager().getCountry() ?? ""
        offset += 1000
        wattingService = true
        getResultsBy(term: term, country: country, offset: offset) { (results, error) in
            self.wattingService = false
            if error == nil{
                let response = Search.GetMoreResults.Response(resultSearch: results)
                self.presenter?.presentMoreResults(response: response)
            }else{
                let response = Search.ShowError.Response(errorMessage: CustomErrors.errorGeneralResponse)
                self.presenter?.presentError(response: response)
            }
        }
    }
    
    //Functions
    
    private func getResultsBy(term:String, country:String, offset:Int, completionHandler: @escaping ([ResultSearch], NSError?) -> Void){
        let worker = SearchWorker()
        worker.fetchResultsBy(term,country: country, offset:offset) { (response, result) in
            switch result {
            case .success:
                guard let results = result.value?.results else {
                    completionHandler([], CustomErrors.errorGeneralResponse)
                    return
                }
                completionHandler(results, nil)
            case .failure:
                completionHandler([], CustomErrors.errorGeneralResponse)
            }
        }
    }
}

