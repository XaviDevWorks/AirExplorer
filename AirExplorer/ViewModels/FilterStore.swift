import Foundation
import Combine

class FilterStore: ObservableObject {
    @Published var selectedManufacturer: String = "Todos"
    @Published var selectedEngineType: String = "Todos"
    @Published var maxSpeed: Int = 1000
    
    private var cancellables = Set<AnyCancellable>()
    
    init() {
        // Inicialización si es necesaria
    }
    
    func resetFilters() {
        selectedManufacturer = "Todos"
        selectedEngineType = "Todos"
        maxSpeed = 1000
    }
    
    func applyFilters(to aircrafts: [Aircraft]) -> [Aircraft] {
        return aircrafts.filter { aircraft in
            let manufacturerMatch = selectedManufacturer == "Todos" || 
                                   aircraft.manufacturer == selectedManufacturer
            let engineMatch = selectedEngineType == "Todos" || 
                             aircraft.engineType.contains(selectedEngineType)
            let speedMatch = (Int(aircraft.maxSpeedKnots ?? "0") ?? 0) <= maxSpeed
            
            return manufacturerMatch && engineMatch && speedMatch
        }
    }
}
