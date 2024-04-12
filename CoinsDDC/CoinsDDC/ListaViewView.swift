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
                
                
                ForEach(0..<moedas.count , id: \.self) { i in
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
            self.moedas = []
            let coreDataFetch = coreDataSave.fetchItems()
            guard let fetched = coreDataFetch else{return}
            
            for currency in Currency.allCases{
                let item = Item(titulo: currency.rawValue, favorito: false, tipo: currency)
                moedas.append(item)
            }
            
            for item in fetched{
                if moedas.contains(where: {
                    $0.tipo.rawValue == item.currency
                }){
                    for index in 0..<self.moedas.count{
                        if moedas[index].tipo.rawValue == item.currency{
                            self.moedas[index].favorito = true
                        }
                    }
                }
            }
            
            
        })
    }
}
#Preview {
    NavigationView(content: {
        ListaView()
    })
}

