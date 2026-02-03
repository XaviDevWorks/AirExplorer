//
//  FilterView.swift
//  AirExplorer
//
//  Created by alumne on 12/01/2026.
//

import SwiftUI

struct FilterView: View {
    @Binding var selectedManufacturer: String
    @Binding var selectedEngineType: String
    let manufacturers: [String]
    let engineTypes: [String]
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Fabricante")) {
                    Picker("Fabricante", selection: $selectedManufacturer) {
                        Text("Todos").tag("")
                        ForEach(manufacturers, id: \.self) { name in
                            Text(name).tag(name)
                        }
                    }
                }
                
                Section(header: Text("Tipo de motor")) {
                    Picker("Motor", selection: $selectedEngineType) {
                        Text("Todos").tag("")
                        ForEach(engineTypes, id: \.self) { engine in
                            Text(engine).tag(engine)
                        }
                    }
                }
                
                Section {
                    Button("Limpiar filtros") {
                        selectedManufacturer = ""
                        selectedEngineType = ""
                    }
                    .foregroundColor(.red)
                }
            }
            .navigationTitle("Filtros")
            .navigationBarItems(
                trailing: Button("Cerrar") {
                    presentationMode.wrappedValue.dismiss()
                }
            )
        }
    }
}
