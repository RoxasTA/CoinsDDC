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
    
    func fecthRates(currency: Currency) async throws {
        let endpoint = "https://v6.exchangerate-api.com/v6/7233a6e524fe82e82687c8a8/latest/\(currency)"
        guard let url = URL(string: endpoint) else {throw Erros.invalidURL}
        let (data, responce) = try await URLSession.shared.data(from: url)
        guard let responce = responce as? HTTPURLResponse, responce.statusCode == 200 else{
            throw Erros.invalidResponce
        }
        do{
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            self.exchange = try decoder.decode(CurrencyExchangeRate.self, from: data)
        } catch{
            print("Error: \(error)")
        }
    }
}
