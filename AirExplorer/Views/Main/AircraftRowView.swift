import SwiftUI

struct AircraftRowView: View {
    let aircraft: Aircraft
    @State private var imageData: Data?
    
    var body: some View {
        HStack(spacing: 15) {
            // Imagen
            ZStack {
                if let imageURL = aircraft.imageURL, let url = URL(string: imageURL) {
                    AsyncImage(url: url) { phase in
                        switch phase {
                        case .empty:
                            ProgressView()
                        case .success(let image):
                            image
                                .resizable()
                                .scaledToFill()
                        case .failure:
                            Image(systemName: "airplane")
                                .font(.title2)
                                .foregroundColor(.blue)
                        @unknown default:
                            EmptyView()
                        }
                    }
                    .frame(width: 60, height: 60)
                    .cornerRadius(8)
                    .overlay(
                        RoundedRectangle(cornerRadius: 8)
                            .stroke(Color.gray.opacity(0.3), lineWidth: 1)
                    )
                } else {
                    // Placeholder si no hay imagen
                    ZStack {
                        RoundedRectangle(cornerRadius: 8)
                            .fill(Color.blue.opacity(0.1))
                            .frame(width: 60, height: 60)
                        
                        Image(systemName: "airplane")
                            .font(.title2)
                            .foregroundColor(.blue)
                    }
                }
            }
            
            // Información
            VStack(alignment: .leading, spacing: 4) {
                Text(aircraft.model)
                    .font(.headline)
                    .lineLimit(1)
                
                Text(aircraft.manufacturer)
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                
                if let engineType = aircraft.engineType, !engineType.isEmpty {
                    Text(engineType)
                        .font(.caption)
                        .foregroundColor(.blue)
                        .padding(.horizontal, 8)
                        .padding(.vertical, 2)
                        .background(Color.blue.opacity(0.1))
                        .cornerRadius(4)
                }
            }
            
            Spacer()
            
            Image(systemName: "chevron.right")
                .font(.caption)
                .foregroundColor(.gray)
        }
        .padding(.vertical, 8)
    }
}
