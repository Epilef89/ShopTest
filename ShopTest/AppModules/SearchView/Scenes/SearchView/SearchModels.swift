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
            var navBarTitle:String
            var placeholderSearchView:String
            var initialMessage:String
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
        }
        struct ViewModel{
            var resultSearch:[ResultSearch]
        }
    }
    
    enum GetMoreResults{
        struct Request {
        }
        struct Response {
            var resultSearch:[ResultSearch]
        }
        struct ViewModel{
            var resultSearch:[ResultSearch]
        }
    }
    
    enum ShowError{
        struct Request {
        }
        struct Response {
            var errorMessage:NSError
        }
        struct ViewModel {
            var errorMessage:String
        }
    }
}

