import SwiftUI

struct FilterView: View {
    @EnvironmentObject var aircraftStore: AircraftStore
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        NavigationView {
            List(aircraftStore.getUniqueManufacturers(), id: \.self) { manufacturer in
                Button(action: {
                    aircraftStore.filterByManufacturer(manufacturer)
                    presentationMode.wrappedValue.dismiss()
                }) {
                    HStack {
                        Text(manufacturer)
                            .foregroundColor(.primary)
                        
                        Spacer()
                        
                        if manufacturer == "Todos" && aircraftStore.filteredAircrafts.count == aircraftStore.aircrafts.count {
                            Image(systemName: "checkmark")
                                .foregroundColor(.blue)
                        } else if manufacturer != "Todos" && aircraftStore.filteredAircrafts.allSatisfy({ $0.manufacturer == manufacturer }) {
                            Image(systemName: "checkmark")
                                .foregroundColor(.blue)
                        }
                    }
                    .padding(.vertical, 8)
                }
            }
            .listStyle(PlainListStyle())
            .navigationTitle("Filtrar por fabricante")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Cerrar") {
                        presentationMode.wrappedValue.dismiss()
                    }
                    .foregroundColor(.blue)
                }
            }
        }
    }
}
