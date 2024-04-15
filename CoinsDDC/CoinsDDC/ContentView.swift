//
//  ContentView.swift
//  CoinsDDC
//
//  Created by Victor Assis on 11/04/24.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        // Definisam da navegação
        NavigationView {
            // Estrutura de lista feita por seções
            Form {
                Section(header: Text("Telas")) {
                    NavigationLink(destination: ListaView()) {
                        Text("Lista de Moedas")
                    }
                    
                    NavigationLink(destination: FavoritosView()) {
                        Text("Favoritos")
                    }
                }
            }
            .navigationTitle("Coins")
            // Estilo da lista
            .listStyle(InsetGroupedListStyle())
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
