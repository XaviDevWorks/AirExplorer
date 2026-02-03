import SwiftUI

struct AircraftDetailView: View {
    let aircraft: Aircraft
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                // Imagen principal
                ZStack(alignment: .bottomLeading) {
                    if let imageURL = aircraft.imageURL, let url = URL(string: imageURL) {
                        AsyncImage(url: url) { phase in
                            switch phase {
                            case .empty:
                                ProgressView()
                                    .frame(height: 200)
                                    .frame(maxWidth: .infinity)
                                    .background(Color.gray.opacity(0.2))
                            case .success(let image):
                                image
                                    .resizable()
                                    .scaledToFill()
                                    .frame(height: 200)
                                    .clipped()
                            case .failure:
                                Color.blue.opacity(0.1)
                                    .frame(height: 200)
                                    .overlay(
                                        Image(systemName: "airplane")
                                            .font(.system(size: 60))
                                            .foregroundColor(.blue)
                                    )
                            @unknown default:
                                EmptyView()
                            }
                        }
                    } else {
                        // Placeholder
                        Color.blue.opacity(0.1)
                            .frame(height: 200)
                            .overlay(
                                Image(systemName: "airplane")
                                    .font(.system(size: 60))
                                    .foregroundColor(.blue)
                            )
                    }
                    
                    // Overlay con información
                    VStack(alignment: .leading, spacing: 5) {
                        Text(aircraft.model)
                            .font(.largeTitle)
                            .fontWeight(.bold)
                            .foregroundColor(.white)
                            .shadow(color: .black, radius: 2)
                        
                        Text(aircraft.manufacturer)
                            .font(.title2)
                            .foregroundColor(.white)
                            .shadow(color: .black, radius: 2)
                    }
                    .padding()
                    .background(
                        LinearGradient(
                            gradient: Gradient(colors: [.black.opacity(0.7), .clear]),
                            startPoint: .bottom,
                            endPoint: .top
                        )
                    )
                }
                
                // Especificaciones
                VStack(alignment: .leading, spacing: 15) {
                    Text("Especificaciones Técnicas")
                        .font(.title2)
                        .fontWeight(.bold)
                        .padding(.bottom, 5)
                    
                    Group {
                        DetailRow(title: "Tipo de motor", value: aircraft.engineType)
                        DetailRow(title: "Empuje del motor", value: aircraft.engineThrustLbFt, unit: "lb-ft")
                        DetailRow(title: "Velocidad máxima", value: aircraft.maxSpeedKnots, unit: "knots")
                        DetailRow(title: "Velocidad de crucero", value: aircraft.cruiseSpeedKnots, unit: "knots")
                        DetailRow(title: "Techo de servicio", value: aircraft.ceilingFt, unit: "ft")
                        DetailRow(title: "Carrera de despegue", value: aircraft.takeoffGroundRunFt, unit: "ft")
                        DetailRow(title: "Carrera de aterrizaje", value: aircraft.landingGroundRollFt, unit: "ft")
                        DetailRow(title: "Alcance", value: aircraft.rangeNauticalMiles, unit: "NM")
                        DetailRow(title: "Peso bruto", value: aircraft.grossWeightLbs, unit: "lbs")
                        DetailRow(title: "Peso vacío", value: aircraft.emptyWeightLbs, unit: "lbs")
                        DetailRow(title: "Longitud", value: aircraft.lengthFt, unit: "ft")
                        DetailRow(title: "Altura", value: aircraft.heightFt, unit: "ft")
                        DetailRow(title: "Envergadura", value: aircraft.wingSpanFt, unit: "ft")
                    }
                }
                .padding()
                .background(Color(.systemGray6))
                .cornerRadius(10)
                .padding(.horizontal)
                
                Spacer(minLength: 50)
            }
        }
        .navigationBarBackButtonHidden(true)
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                Button(action: {
                    presentationMode.wrappedValue.dismiss()
                }) {
                    HStack(spacing: 4) {
                        Image(systemName: "chevron.left")
                        Text("Atrás")
                    }
                    .foregroundColor(.blue)
                }
            }
        }
    }
}

struct DetailRow: View {
    let title: String
    let value: String?
    let unit: String
    
    init(title: String, value: String?, unit: String = "") {
        self.title = title
        self.value = value
        self.unit = unit
    }
    
    var body: some View {
        HStack(alignment: .top) {
            Text(title)
                .fontWeight(.medium)
                .foregroundColor(.secondary)
                .frame(width: 150, alignment: .leading)
            
            Spacer()
            
            if let value = value, !value.isEmpty {
                Text("\(value) \(unit)")
                    .fontWeight(.semibold)
                    .multilineTextAlignment(.trailing)
            } else {
                Text("No disponible")
                    .foregroundColor(.gray)
                    .italic()
            }
        }
        .padding(.vertical, 3)
    }
}
