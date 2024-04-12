//
//  DetalheView.swift
//  CoinsDDC
//
//  Created by Victor Assis on 11/04/24.
//
import SwiftUI

struct DetalheItemView: View {
    @Binding var coreDataSave : CoreDataManager
    @Binding var moedaD: Item
    @StateObject var netWork = CoinDataModel()
    @State var value:String = "1"

    var body: some View {
        VStack {
            Button(action: {
                self.moedaD.favorito.toggle()
                coreDataSave.addCoin(name: moedaD.titulo, favorite: moedaD.favorito, currency: moedaD.tipo)

//                }
            }) {
                Image(systemName: moedaD.favorito ? "heart.fill" : "heart")
                    .foregroundColor(moedaD.favorito ? .red : .gray)
                    .font(.title)
            }
            .padding()
            
            TextField("1", text: $value)
                .padding()
                .keyboardType(.numberPad)
                .textFieldStyle(.roundedBorder)
            
//            if let detalhes = netWork.exchange{
//                
////                ForEach(detalhes.conversionRates, id: \.self) {i in
////                    Text(detalhes.conversionRates[i])
////                }
//            }
            List{
                if !netWork.moedasSaveN.isEmpty{
                    ForEach(0..<netWork.moedasSaveN.count){ i in
                        HStack{
                            Text("\(netWork.moedasSaveN[i])")
                            Spacer()
                            if let multiplier = Double(value){
                                Text(String(format: "$%.2f", netWork.moedasSaveV[i]*multiplier))
                            }else{
                                Text("\(netWork.moedasSaveV[i])")
                            }
                        }
                    }
                } else {
                    ProgressView()
                }
            }
        }
        .navigationTitle(moedaD.titulo)
        .onAppear(perform: {
            Task{
                do{
                    try await netWork.fecthRates(currency: moedaD.tipo)
                }
                catch{
                    print(error)
                }
            }
        })
    }
}

#Preview(){
    DetalheItemView(coreDataSave: .constant(CoreDataManager()), moedaD: .constant(Item(titulo: "", favorito: false, tipo: Currency(rawValue: "teste") ?? .AED)))
}
