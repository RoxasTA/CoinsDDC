//
//  ContentView.swift
//  CoinsDDC
//
//  Created by Victor Assis on 11/04/24.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Telas")) {
                    NavigationLink(destination: ListaView()) {
                        Text("Lista de Moedas")
                    }
                    
                    NavigationLink(destination: ListaView()) {
                        Text("Converter Valores")
                    }
                }
            }
            .navigationTitle("Coins")
            .listStyle(InsetGroupedListStyle())
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
