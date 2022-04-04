//
//  APIValuesPromises.swift
//  Uallet
//
//  Created by Serena Donato on 04/04/2022.
//

import Foundation

import Alamofire
import PromiseKit


class APIValuesPromises{
    
    static func bitcoinRatePromises() -> Promise<Double> {
        return Promise { resolver in
            AF.request("http://api.coindesk.com/v1/bpi/currentprice.json")
                .responseDecodable(of: APIBitcoinResponse.self) {
                    response in
                    if let value = response.value {
                        let rate = value.bpi.usd.rateFloat
                        resolver.fulfill(rate)
                    } else {
                        resolver.reject(APIError.ServerError)
                    }
                }
        }
    }
    
    static func dolarOfficialBuyRatePromises() -> Promise<Double> {
        return Promise { resolver in
            AF.request("http://api-dolar-argentina.herokuapp.com/api/dolaroficial")
                .responseDecodable(of: APIDolarResponse.self) {
                    response in
                    if let value = response.value {
                        if let rateBuy = Double(value.compra){
                            resolver.fulfill(rateBuy)
                        }else{
                            resolver.reject(APIError.ServerError)
                        }
                    } else {
                        resolver.reject(APIError.ServerError) //
                    }
                }
        }
    }
    
    static func dolarOfficialSaleRatePromises() -> Promise<Double> {
        return Promise { resolver in
            AF.request("http://api-dolar-argentina.herokuapp.com/api/dolaroficial")
                .responseDecodable(of: APIDolarResponse.self) {
                    response in
                    if let value = response.value {
                        
                        if let rateSale = Double(value.venta){
                            resolver.fulfill(rateSale)
                        }else{
                            resolver.reject(APIError.ServerError)
                        }
                    } else {
                        resolver.reject(APIError.ServerError) //
                    }
                }
        }
    }
    
    
    static func dolarBlueSaleRatePromises() -> Promise<Double> {
        return Promise { resolver in
            AF.request("http://api-dolar-argentina.herokuapp.com/api/dolarblue")
                .responseDecodable(of: APIDolarResponse.self) {
                    response in
                    if let value = response.value {
                        
                        if let rateSale = Double(value.venta){
                            resolver.fulfill(rateSale)
                        }else{
                            resolver.reject(APIError.ServerError)
                        }
                    } else {
                        resolver.reject(APIError.ServerError) //
                    }
                }
        }
    }
    
    
    static func dolarBlueBuyRatePromises() -> Promise<Double> {
        return Promise { resolver in
            AF.request("http://api-dolar-argentina.herokuapp.com/api/dolarblue")
                .responseDecodable(of: APIDolarResponse.self) {
                    response in
                    if let value = response.value {
                        
                        if let rateSale = Double(value.venta){
                            resolver.fulfill(rateSale)
                        }else{
                            resolver.reject(APIError.ServerError)
                        }
                    } else {
                        resolver.reject(APIError.ServerError) //
                    }
                }
        }
    }
}
