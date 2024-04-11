//
//  ListaViewView.swift
//  CoinsDDC
//
//  Created by Victor Assis on 11/04/24.
//

import SwiftUI

 struct Item: Identifiable {
     var id = UUID()
     var titulo: String
     var descricao: String
     var imagem: String
     var favorito: Bool
 }

 struct ListaView: View {
     
     @Environment(\.managedObjectContext) var mangedObjContext
     @StateObject var coinsDataModel = CoinDataModel()
     @State  var Filtroligado = false
     @State  var moedas = [
         Item(titulo: "1", descricao: "", imagem: "Imagem 1", favorito: false),
         Item(titulo: "2", descricao: "", imagem: "Imagem 2", favorito: false),
         Item(titulo: "3", descricao: "", imagem: "Imagem 3", favorito: false),
         Item(titulo: "4", descricao: "", imagem: "Imagem 4", favorito: false),
         Item(titulo: "5", descricao: "", imagem: "Imagem 5", favorito: false),
         Item(titulo: "6", descricao: "", imagem: "Imagem 6", favorito: false)
     ]
     
     var body: some View {
         NavigationView {
             List {
                 Toggle(isOn: $Filtroligado, label: {
                     Text("Favoritos")
                         .foregroundColor(.accentColor)
                 })
//                 ForEach(coinsDataModel.coins, id: .\self) { moeda in
//                     Text(moeda.code)
//                 }
//                 Text(coinsDataModel.coins.BTCBRL.code)
                 
                 ForEach(moedas.filter {!Filtroligado || $0.favorito}) { moeda in
                     NavigationLink(destination: DetalheItemView(moeda: moeda, moedas: $moedas)) {
                         HStack {
                             Image(systemName: "heart")
                                 .foregroundColor(moeda.favorito ? .yellow : .gray)
                             Text(moeda.titulo)
                         }
                     }
                 }
             }
             .listStyle(InsetListStyle())
             .navigationTitle("Lista de moedas")
         }
     }
 }

 struct DetalheItemView: View {
     @State  var isFavorite: Bool
     @Binding var moedas: [Item]
     let moedaD: Item
     
     init(moeda: Item, moedas: Binding<[Item]>) {
         self.moedaD = moeda
         self._isFavorite = State(initialValue: moeda.favorito)
         self._moedas = moedas
     }
     
     var body: some View {
         VStack {
//             Image(moedaD.imagem)
//                 .resizable()
//                 .aspectRatio(contentMode: .fit)
//                 .frame(height: 200)
//             Text(moedaD.titulo)
//                 .font(.title)
//                 .fontWeight(.bold)
//                 .padding()
//             Text(moedaD.descricao)
//                 .padding()
             Button(action: {
                 self.isFavorite.toggle()
                 CoreDataManager().saveContext()
                 if let index = moedas.firstIndex(where: { $0.id == moedaD.id }) {
                     var mutableItem = moedaD
                     mutableItem.favorito = self.isFavorite
                     moedas[index] = mutableItem
                 }
             }) {
                 Image(systemName: isFavorite ? "heart.fill" : "heart")
                     .foregroundColor(isFavorite ? .red : .gray)
                     .font(.title)
             }
             .padding()
         }
         .navigationTitle(moedaD.titulo)
     }
 }

#Preview {
    ListaView()
}

