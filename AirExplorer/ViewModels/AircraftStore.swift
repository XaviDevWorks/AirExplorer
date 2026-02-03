import SwiftUI
import Combine

class AircraftStore: ObservableObject {
    @Published var aircrafts: [Aircraft] = []
    @Published var filteredAircrafts: [Aircraft] = []
    @Published var isLoading = false
    @Published var error: APIError?
    @Published var searchText = ""
    
    private var cancellables = Set<AnyCancellable>()
    
    init() {
        // Observar cambios en searchText
        $searchText
            .debounce(for: .milliseconds(300), scheduler: RunLoop.main)
            .sink { [weak self] text in
                self?.filterAircrafts(text)
            }
            .store(in: &cancellables)
    }
    
    func loadAircrafts() {
        isLoading = true
        error = nil
        
        APIService.shared.fetchAircrafts { [weak self] result in
            DispatchQueue.main.async {
                self?.isLoading = false
                switch result {
                case .success(let aircrafts):
                    self?.aircrafts = aircrafts
                    self?.filteredAircrafts = aircrafts
                case .failure(let error):
                    self?.error = error
                }
            }
        }
    }
    
    func filterAircrafts(_ text: String) {
        if text.isEmpty {
            filteredAircrafts = aircrafts
        } else {
            filteredAircrafts = aircrafts.filter {
                $0.model.localizedCaseInsensitiveContains(text) ||
                $0.manufacturer.localizedCaseInsensitiveContains(text)
            }
        }
    }
    
    func filterByManufacturer(_ manufacturer: String) {
        if manufacturer == "Todos" {
            filteredAircrafts = aircrafts
        } else {
            filteredAircrafts = aircrafts.filter { $0.manufacturer == manufacturer }
        }
    }
    
    func getUniqueManufacturers() -> [String] {
        var manufacturers = Set(aircrafts.map { $0.manufacturer })
        manufacturers.insert("Todos")
        return Array(manufacturers).sorted()
    }
}
