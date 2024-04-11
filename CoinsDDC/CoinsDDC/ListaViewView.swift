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
    //@StateObject var coinsDataModel = CoinDataModel()
    @State var filtroligado = false
    @State var moedas = [
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
                Toggle(isOn: $filtroligado, label: {
                    Label("Favoritos", systemImage: "heart.fill")
                })
                ForEach(moedas) { moeda in
                    NavigationLink(destination: DetalheItemView(moeda: moeda, moedas: $moedas)) {
                        HStack {
                            Image(systemName: "heart")
                                .foregroundColor(moeda.favorito ? .blue : .gray)
                            Text(moeda.titulo)
                        }
                    }
                }
            }
            .navigationTitle("Lista de Moedas")
        }
        .listStyle(InsetGroupedListStyle()) // Aplica estilo de lista do HIG
    }
}

struct DetalheItemView: View {
    @State var isFavorite: Bool
    @Binding var moedas: [Item]
    let moedaD: Item
    
    init(moeda: Item, moedas: Binding<[Item]>) {
        self.moedaD = moeda
        self._isFavorite = State(initialValue: moeda.favorito)
        self._moedas = moedas
    }
    
    var body: some View {
        VStack {
//            Image(moedaD.imagem)
//                .resizable()
//                .aspectRatio(contentMode: .fit)
//                .frame(height: 200)
//            Text(moedaD.titulo)
//                .font(.title)
//                .fontWeight(.bold)
//                .padding()
//            Text(moedaD.descricao)
//                .padding()
            HStack {
                Spacer()
                Button(action: {
                    self.isFavorite.toggle()
                    if let index = moedas.firstIndex(where: { $0.id == moedaD.id }) {
                        var mutableItem = moedaD
                        mutableItem.favorito = self.isFavorite
                        moedas[index] = mutableItem
                    }
                }) {
                    Image(systemName: isFavorite ? "heart.fill" : "heart")
                        .foregroundColor(isFavorite ? .blue : .gray)
                        .font(.title)
            }
            }
            Spacer()
            //.padding()
        }
        //.navigationTitle(moedaD.titulo)
    }
}

#Preview{
    ListaView()
}

