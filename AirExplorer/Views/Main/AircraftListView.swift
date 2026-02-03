import SwiftUI

struct AircraftListView: View {
    @EnvironmentObject var aircraftStore: AircraftStore
    @EnvironmentObject var authStore: AuthStore
    @State private var showingFilter = false
    
    var body: some View {
        VStack {
            // Barra de búsqueda
            HStack {
                Image(systemName: "magnifyingglass")
                    .foregroundColor(.gray)
                
                TextField("Buscar por modelo o fabricante...", text: $aircraftStore.searchText)
                
                if !aircraftStore.searchText.isEmpty {
                    Button(action: {
                        aircraftStore.searchText = ""
                    }) {
                        Image(systemName: "xmark.circle.fill")
                            .foregroundColor(.gray)
                    }
                }
                
                Button(action: {
                    showingFilter.toggle()
                }) {
                    Image(systemName: "line.3.horizontal.decrease.circle")
                        .foregroundColor(.blue)
                }
            }
            .padding(10)
            .background(Color(.systemGray6))
            .cornerRadius(10)
            .padding(.horizontal)
            .padding(.top)
            
            // Contenido
            if aircraftStore.isLoading {
                LoadingView()
            } else if let error = aircraftStore.error {
                ErrorView(error: error, retryAction: {
                    aircraftStore.loadAircrafts()
                })
            } else if aircraftStore.filteredAircrafts.isEmpty {
                VStack(spacing: 20) {
                    Image(systemName: "airplane")
                        .font(.system(size: 60))
                        .foregroundColor(.gray)
                    
                    Text("No se encontraron aviones")
                        .font(.headline)
                        .foregroundColor(.secondary)
                    
                    if !aircraftStore.searchText.isEmpty {
                        Text("Intenta con otro término de búsqueda")
                            .font(.caption)
                            .foregroundColor(.gray)
                    }
                }
                .padding(.top, 100)
            } else {
                List(aircraftStore.filteredAircrafts) { aircraft in
                    NavigationLink(destination: AircraftDetailView(aircraft: aircraft)) {
                        AircraftRowView(aircraft: aircraft)
                    }
                }
                .listStyle(PlainListStyle())
                .refreshable {
                    aircraftStore.loadAircrafts()
                }
            }
        }
        .navigationTitle("✈️ AirExplorer")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button("Cerrar sesión") {
                    authStore.logout()
                }
                .foregroundColor(.red)
            }
        }
        .sheet(isPresented: $showingFilter) {
            FilterView()
        }
        .onAppear {
            if aircraftStore.aircrafts.isEmpty {
                aircraftStore.loadAircrafts()
            }
        }
    }
}
