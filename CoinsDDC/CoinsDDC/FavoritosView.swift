//
//  ListaViewView.swift
//  CoinsDDC
//
//  Created by Victor Assis on 11/04/24.
//

import SwiftUI

struct FavoritosView: View {
    
    @State var coreDataSave : CoreDataManager = CoreDataManager()
    @StateObject var coinsDataModel = CoinDataModel()
    @State var Filtroligado = false
    @State var moedas: [Item] = []
    @State var moedasFavoritas : [Item] = []
    
    var body: some View {
        VStack{
            List {
                
                // monta a lista de moedas favoritas.
                ForEach(0..<moedas.count , id: \.self) { i in
                    // ve quais moedas são favoritas
                    if moedas[i].favorito == true{
                        // puxa as moedas favoritas
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
            }.onAppear(perform: {
                // // zera o array de moedas e da um fetch no core data
                self.moedas = []
                let coreDataFetch = coreDataSave.fetchItems()
                guard let fetched = coreDataFetch else{return}
                // recebe todos os casos do enum de moedas e os passa como objetos do Item.
                for currency in Currency.allCases{
                    let item = Item(titulo: currency.rawValue, favorito: false, tipo: currency)
                    moedas.append(item)
                }
                
                // puxa as informações do enum para as moedas marcados como favoritas.
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
}

#Preview {
    NavigationView(content: {
        ListaView()
    })
}

