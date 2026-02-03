import Foundation

struct Aircraft: Identifiable, Codable {
    let id = UUID()
    let manufacturer: String
    let model: String
    let engineType: String
    let engineThrustLbFt: String?
    let maxSpeedKnots: String?
    let cruiseSpeedKnots: String?
    let ceilingFt: String?
    let takeoffGroundRunFt: String?
    let landingGroundRollFt: String?
    let grossWeightLbs: String?
    let emptyWeightLbs: String?
    let lengthFt: String?
    let heightFt: String?
    let wingSpanFt: String?
    let rangeNauticalMiles: String?
    let imageURL: String?
    
    enum CodingKeys: String, CodingKey {
        case manufacturer, model
        case engineType = "engine_type"
        case engineThrustLbFt = "engine_thrust_lb_ft"
        case maxSpeedKnots = "max_speed_knots"
        case cruiseSpeedKnots = "cruise_speed_knots"
        case ceilingFt = "ceiling_ft"
        case takeoffGroundRunFt = "takeoff_ground_run_ft"
        case landingGroundRollFt = "landing_ground_roll_ft"
        case grossWeightLbs = "gross_weight_lbs"
        case emptyWeightLbs = "empty_weight_lbs"
        case lengthFt = "length_ft"
        case heightFt = "height_ft"
        case wingSpanFt = "wing_span_ft"
        case rangeNauticalMiles = "range_nautical_miles"
        case imageURL = "image_url"
    }
}
