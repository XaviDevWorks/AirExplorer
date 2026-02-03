//
//  AircraftDetailView.swift
//  AirExplorer
//
//  Created by alumne on 19/01/2026.
//


import SwiftUI
import Kingfisher

struct AircraftDetailView: View {
    let aircraft: Aircraft
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                // Imagen
                if let urlString = aircraft.imageURL,
                   let url = URL(string: urlString) {
                    KFImage(url)
                        .resizable()
                        .scaledToFit()
                        .frame(maxWidth: .infinity)
                        .cornerRadius(12)
                } else {
                    Image(systemName: "airplane")
                        .resizable()
                        .scaledToFit()
                        .frame(height: 200)
                        .frame(maxWidth: .infinity)
                }
                
                // Info básica
                VStack(alignment: .leading, spacing: 8) {
                    Text(aircraft.model)
                        .font(.largeTitle)
                        .fontWeight(.bold)
                    Text(aircraft.manufacturer)
                        .font(.title2)
                        .foregroundColor(.gray)
                    Text("Motor: \(aircraft.engineType)")
                        .font(.subheadline)
                        .foregroundColor(.gray)
                }
                
                Divider()
                
                // Especificaciones
                VStack(alignment: .leading, spacing: 12) {
                    Text("Especificaciones")
                        .font(.headline)
                    
                    if let speed = aircraft.maxSpeedKnots {
                        infoRow(title: "Velocidad máxima", value: "\(speed) kts")
                    }
                    if let cruise = aircraft.cruiseSpeedKnots {
                        infoRow(title: "Velocidad crucero", value: "\(cruise) kts")
                    }
                    if let ceiling = aircraft.ceilingFt {
                        infoRow(title: "Techo", value: "\(ceiling) ft")
                    }
                    if let range = aircraft.rangeNauticalMiles {
                        infoRow(title: "Alcance", value: "\(range) mn")
                    }
                }
                
                Divider()
                
                // Dimensiones
                VStack(alignment: .leading, spacing: 12) {
                    Text("Dimensiones")
                        .font(.headline)
                    
                    if let length = aircraft.lengthFt {
                        infoRow(title: "Largo", value: "\(length) ft")
                    }
                    if let height = aircraft.heightFt {
                        infoRow(title: "Alto", value: "\(height) ft")
                    }
                    if let wingspan = aircraft.wingSpanFt {
                        infoRow(title: "Envergadura", value: "\(wingspan) ft")
                    }
                }
                
                Divider()
                
                // Pesos
                VStack(alignment: .leading, spacing: 12) {
                    Text("Pesos")
                        .font(.headline)
                    
                    if let gross = aircraft.grossWeightLbs {
                        infoRow(title: "Peso bruto", value: "\(gross) lbs")
                    }
                    if let empty = aircraft.emptyWeightLbs {
                        infoRow(title: "Peso vacío", value: "\(empty) lbs")
                    }
                }
            }
            .padding()
        }
        .navigationTitle(aircraft.model)
        .navigationBarTitleDisplayMode(.inline)
    }
    
    func infoRow(title: String, value: String) -> some View {
        HStack {
            Text(title)
                .foregroundColor(.gray)
            Spacer()
            Text(value)
                .fontWeight(.medium)
        }
    }
}

struct AircraftDetailView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            AircraftDetailView(aircraft: Aircraft(
                id: "1",
                manufacturer: "Boeing",
                model: "737",
                engineType: "Jet",
                engineThrustLbFt: nil,
                maxSpeedKnots: "500",
                cruiseSpeedKnots: "450",
                ceilingFt: "41000",
                takeoffGroundRunFt: nil,
                landingGroundRollFt: nil,
                grossWeightLbs: "177000",
                emptyWeightLbs: nil,
                lengthFt: "116",
                heightFt: "40",
                wingSpanFt: "117",
                rangeNauticalMiles: "3850",
                imageURL: nil
            ))
        }
    }
}
