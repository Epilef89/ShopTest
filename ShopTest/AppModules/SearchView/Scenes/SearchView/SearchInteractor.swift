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
    var worker: SearchWorker = SearchWorker()
    var offset: Int = 0
    var term:String = ""
    var wattingService:Bool = false

    
    func loadInitialInformation(request: Search.LoadInitalData.Request) {
        
        let response = Search.LoadInitalData.Response()
        presenter?.presentInitialInformation(response: response)
    }
    
    func searchByTerm(request:Search.SearchByTerm.Request){
        
        #warning("Pendiente cambiar de tienda")
        KeyManager().set(country: "MCO")
        let country = KeyManager().getCountry() ?? ""
        offset = 0
        term = request.term
        wattingService = true
        worker.fetchResultsBy(request.term, country: country, offset: offset) { (response, result) in
            self.wattingService = false
            switch result {
            case .success:
                guard let results = result.value?.results else {
                    return
                }
                let quantity = result.value?.paging?.total ?? 0
                if results.count > 0{
                    let response = Search.SearchByTerm.Response(resultSearch: results, totalResultsCount: quantity, term: request.term)
                    self.presenter?.presentShowResults(response: response)
                }else{
                    let response = Search.ShowError.Response(errorMessage: CustomErrors.errorNoData, retry: false)
                    self.presenter?.presentError(response: response)
                }
                
            case .failure (let error):
                let response = Search.ShowError.Response(errorMessage: error ?? CustomErrors.errorGeneralResponse, retry: true)
                self.presenter?.presentError(response: response)
            }
        }
    }
    
    func getMoreItemsByPreviousTerm(request:Search.GetMoreResults.Request){
        let country = KeyManager().getCountry() ?? ""
        offset += 1
        wattingService = true
        worker.fetchResultsBy(term,country: country, offset:offset) { (response, result) in
            self.wattingService = false
            switch result {
            case .success:
                guard let results = result.value?.results else {
                    return
                }
                let quantity = result.value?.paging?.total ?? 0
                if results.count > 0{
                    let response = Search.GetMoreResults.Response(resultSearch: results, totalResultsCount: quantity)
                    self.presenter?.presentMoreResults(response: response)
                }else{
                    let response = Search.ShowError.Response(errorMessage: CustomErrors.errorNoData, retry: false)
                    self.presenter?.presentError(response: response)
                }
            case .failure (let error):
                let response = Search.ShowError.Response(errorMessage: error ?? CustomErrors.errorGeneralResponse, retry: true)
                self.presenter?.presentError(response: response)
            }
        }

    }
}

