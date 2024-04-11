//
//  ConverterView.swift
//  CoinsDDC
//
//  Created by Victor Assis on 11/04/24.
//

//
//import SwiftUI
//
//struct ConverterView: View {
//    @Environment(\.managedObjectContext) var mangedObjContext
//    @State private var text1: String = ""
//    @State private var text2: String = ""
//    @State private var sliderValue: Double = 0.0
//
//    var body: some View {
//        VStack{
//            List {
//                TextField("Texto 1", text: $text1)
//                TextField("Texto 2", text: $text2)
//
//                Slider(value: $sliderValue, in: 0...1000000, step: 1.0) {
//                    Text("Slider Value: \(sliderValue)")
//                }
//            }
//            .listStyle(.plain)
//            .navigationTitle("Converter")
//
//            HStack{
//                Spacer()
//                Button("Subimit"){
//                }
//                Spacer()
//            }
//        }
//    }
//}
//#Preview {
//    ConverterView()
//}
