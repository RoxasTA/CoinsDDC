//
//  CoinDataModel.swift
//  CoinsDDC
//
//  Created by Victor Assis on 11/04/24.
//

import Foundation

var APIKEY = "7233a6e524fe82e82687c8a8"

@MainActor

class CoinDataModel: ObservableObject{
    @Published var exchange: CurrencyExchangeRate?
    
    //func fecthRates(currecy: curr)
}
