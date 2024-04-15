//
//  CoinDataModel.swift
//  CoinsDDC
//
//  Created by Victor Assis on 11/04/24.
//

import Foundation

// chave da API
var APIKEY = "7233a6e524fe82e82687c8a8"

// evita erros da API
@MainActor
class CoinDataModel: ObservableObject{
    var exchange: CurrencyExchangeRate? {
        didSet{
            moedasSaveN = []
            moedasSaveV = []
            if let exchange = exchange{
                for (key, value) in exchange.conversionRates{
                    moedasSaveN.append(key)
                    moedasSaveV.append(value)
                }
            }
        }
    }
    @Published var moedasSaveN: [String] = []
    @Published var moedasSaveV: [Double] = []
    
    // faz o retorno da API e ve a resposta da API
    func fecthRates(currency: Currency) async throws {
        let endpoint = "https://v6.exchangerate-api.com/v6/7233a6e524fe82e82687c8a8/latest/\(currency)"
        guard let url = URL(string: endpoint) else {throw Erros.invalidURL}
        let (data, responce) = try await URLSession.shared.data(from: url)
        guard let responce = responce as? HTTPURLResponse, responce.statusCode == 200 else{
            throw Erros.invalidResponce
        }
        do{
            // decodifica o arquivo JSON
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            self.exchange = try decoder.decode(CurrencyExchangeRate.self, from: data)
        } catch{
            print("Error: \(error)")
        }
    }
}
