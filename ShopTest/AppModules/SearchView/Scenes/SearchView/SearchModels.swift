//
//  SearchModels.swift
//  ShopTest
//
//  Created by david cortes on 16/01/21.


import UIKit

enum Search {
    // MARK: Use cases
    
    enum LoadInitalData {
        struct Request {
        }
        struct Response {
        }
        struct ViewModel {
            var navBarTitle:String
            var placeholderSearchView:String
            var initialMessage:String
        }
    }
    
    enum SearchByTerm{
        struct Request{
            var term:String
        }
        struct Response{
            var resultSearch:[ResultSearch]
            var totalResultsCount:Int
            var term:String
            var moreResults:Bool
        }
        struct ViewModel{
            var resultSearch:[ResultSearch]
            var totalResultsCount:String
            var moreResults:Bool
        }
    }
    
    enum GetMoreResults{
        struct Request {
            var retry:Bool
        }
        struct Response {
            var resultSearch:[ResultSearch]
            var totalResultsCount:Int
            var moreResults:Bool
        }
        struct ViewModel{
            var resultSearch:[ResultSearch]
            var totalResultsCount:String
            var moreResults:Bool
        }
    }
    
    enum ShowError{
        struct Request {
        }
        struct Response {
            var errorMessage:NSError
            var retry:Bool
        }
        struct ViewModel {
            var errorMessage:String
            var retry:Bool
            var titlePrimaryButton:String
            var titleSecundaryButton:String
        }
    }
    
    enum GoToDetail{
        struct Request {
            var resultSearch:ResultSearch
        }
        struct Response{
        }
        struct ViewModel{
        }
    }
}

