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
        }
        struct ViewModel{
            var resultSearch:[ResultSearch]
            var totalResultsCount:String
        }
    }
    
    enum GetMoreResults{
        struct Request {
            var retry:Bool
        }
        struct Response {
            var resultSearch:[ResultSearch]
            var totalResultsCount:Int
        }
        struct ViewModel{
            var resultSearch:[ResultSearch]
            var totalResultsCount:String
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
}

