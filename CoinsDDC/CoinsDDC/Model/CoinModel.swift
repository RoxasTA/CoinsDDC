//
//  CoinModel.swift
//  CoinsDDC
//
//  Created by Victor Assis on 11/04/24.
//

import Foundation
// atributos os quais a api retorna
struct CurrencyExchangeRate: Codable, Hashable{
    let result: String
    let baseCode: String
    let conversionRates: [String: Double]
}
