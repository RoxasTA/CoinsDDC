//
//  ListaViewView.swift
//  CoinsDDC
//
//  Created by Victor Assis on 11/04/24.
//

import SwiftUI

struct Item: Identifiable, Hashable{
    var id = UUID()
    var titulo: String
    var favorito: Bool
    var tipo: Currency
}

struct ListaView: View {
    
    @State var coreDataSave : CoreDataManager = CoreDataManager()
    @StateObject var coinsDataModel = CoinDataModel()
    @State var moedas: [Item] = []
    @State var moedasFavoritas : [Item] = []
    
    var body: some View {
        VStack{
            List {
                
                // Montagem da lista, recebendo da estrutura item.
                ForEach(0..<moedas.count , id: \.self) { i in
                    // Leva para a detalhe view atraves de variaveis State Bading: a moeda escolhida para ser vista com seus detalhes.
                    NavigationLink {
                        DetalheItemView(coreDataSave: $coreDataSave, moedaD: $moedas[i])
                    } label: {
                        HStack {
                            Text(moedas[i].titulo)
                        }
                    }
                    
                }
                
            }
            .listStyle(InsetListStyle())
            .navigationTitle("Lista de moedas")
            //         }
        }.onAppear(perform: {
            // zera o array de moedas e da um fetch no core data
            self.moedas = []
            let coreDataFetch = coreDataSave.fetchItems()
            guard let fetched = coreDataFetch else{return}
            
            // recebe todos os casos do enum de moedas e os passa como objetos do Item.
            for currency in Currency.allCases{
                let item = Item(titulo: currency.rawValue, favorito: false, tipo: currency)
                moedas.append(item)
            }
            
        })
    }
}
#Preview {
    NavigationView(content: {
        ListaView()
    })
}

