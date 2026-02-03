//
//  AircraftListView.swift
//  AirExplorer
//
//  Created by alumne on 19/01/2026.
//


import SwiftUI
import Kingfisher

struct AircraftListView: View {
    @EnvironmentObject var vm: AircraftViewModel
    @State private var searchText = ""
    
    var body: some View {
        NavigationView {
            if let error = vm.messageError {
                VStack {
                    Text("Error: \(error)")
                    Button("Reintentar") {
                        vm.fetchIntent()
                    }
                }
            } else if vm.aircrafts.isEmpty {
                VStack {
                    Text("No hay aviones")
                    Button("Cargar aviones") {
                        vm.fetchIntent()
                    }
                }
            } else {
                VStack(spacing: 8) {
                    // Simple search bar compatible with older Xcode/iOS
                    HStack {
                        Image(systemName: "magnifyingglass")
                            .foregroundColor(.secondary)
                        TextField("Buscar modelo o fabricante", text: $searchText)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .disableAutocorrection(true)
                            .autocapitalization(.none)
                        if !searchText.isEmpty {
                            Button(action: { searchText = "" }) {
                                Image(systemName: "xmark.circle.fill")
                                    .foregroundColor(.secondary)
                            }
                        }
                    }
                    .padding([.horizontal])

                    List(filteredAircrafts) { aircraft in
                        NavigationLink(destination: AircraftDetailView(aircraft: aircraft)) {
                            HStack {
                                if let urlString = aircraft.imageURL,
                                   let url = URL(string: urlString) {
                                    KFImage(url)
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 80, height: 60)
                                        .cornerRadius(8)
                                } else {
                                    Image(systemName: "airplane")
                                        .frame(width: 80, height: 60)
                                }

                                VStack(alignment: .leading) {
                                    Text(aircraft.model)
                                        .font(.headline)
                                    Text(aircraft.manufacturer)
                                        .font(.subheadline)
                                        .foregroundColor(.gray)
                                }
                            }
                        }
                    }
                }
                .navigationTitle("Aviones")
            }
        }
        .onAppear {
            if vm.aircrafts.isEmpty {
                vm.fetchIntent()
            }
        }
    }
    
    var filteredAircrafts: [Aircraft] {
        if searchText.isEmpty {
            return vm.aircrafts
        } else {
            return vm.aircrafts.filter {
                $0.model.lowercased().contains(searchText.lowercased()) ||
                $0.manufacturer.lowercased().contains(searchText.lowercased())
            }
        }
    }
}

struct AircraftListView_Previews: PreviewProvider {
    static var previews: some View {
        AircraftListView().environmentObject(AircraftViewModel())
    }
}
