import Foundation

struct User: Identifiable, Codable {
    var id = UUID()
    var name: String
    var email: String
    var password: String
    
    static let empty = User(name: "", email: "", password: "")
}
