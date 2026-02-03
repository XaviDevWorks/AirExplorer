//
//  AircraftViewModel.swift
//  AirExplorer
//
//  Created by alumne on 12/01/2026.
//


import Foundation

class AircraftViewModel: ObservableObject {
    @Published private(set) var messageError: String?
    @Published private(set) var aircrafts = [Aircraft]()
    
    func fetchIntent() {
        APIService.fetchAircrafts { result in
            switch result {
            case .failure(let error):
                DispatchQueue.main.async {
                    self.messageError = error.localizedDescription
                }
            case .success(let array):
                DispatchQueue.main.async {
                    self.aircrafts = array
                }
            }
        }
    }
}
