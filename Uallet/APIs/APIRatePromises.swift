//
//  APIValuesPromises.swift
//  Uallet
//
//  Created by Serena Donato on 04/04/2022.
//

import Foundation

import Alamofire
import PromiseKit


class APIRatePromises{
    
    static func bitcoinRatePromises() -> Promise<Double> {
        return Promise { resolver in
            AF.request("https://api.coindesk.com/v1/bpi/currentprice.json")
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
    
    static func dolarOfficialRatePromises() -> Promise<DolarRate> {
        return Promise { resolver in
            AF.request("https://api-dolar-argentina.herokuapp.com/api/dolaroficial")
                .responseDecodable(of: APIDolarResponse.self) {
                    response in
                    if let value = response.value {
                        if let rateBuy = Double(value.compra), let rateSale = Double(value.venta){
                            let dolarRate = DolarRate(buy: rateBuy, sale: rateSale)
                            resolver.fulfill(dolarRate)
                        }else{
                            resolver.reject(APIError.ServerError)
                        }
                    } else {
                        resolver.reject(APIError.ServerError) //
                    }
                }
        }
    }
    
    static func dolarBlueRatePromises() -> Promise<DolarRate> {
        return Promise { resolver in
            AF.request("https://api-dolar-argentina.herokuapp.com/api/dolarblue")
                .responseDecodable(of: APIDolarResponse.self) {
                    response in
                    if let value = response.value {
                        if let rateBuy = Double(value.compra), let rateSale = Double(value.venta){
                            let dolarRate = DolarRate(buy: rateBuy, sale: rateSale)
                            resolver.fulfill(dolarRate)
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
