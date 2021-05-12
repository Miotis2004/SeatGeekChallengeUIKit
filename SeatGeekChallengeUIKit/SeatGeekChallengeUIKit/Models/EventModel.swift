//
//  EventModel.swift
//  SeatGeekChallengeUIKit
//
//  Created by Ronald Joubert on 5/12/21.
//

import Foundation

struct EventWrapper: Codable {
    
    var events: [Event]
}

//struct Event: Codable {
//    var events: EventDetail
//    var datetime_utc: String
//}
//
//struct EventDetail: Codable {
//    var venue: Venue
//    var performers: Performer
//}
//
//struct Venue: Codable {
//    var display_location: String
//}
//
//struct Performer: Codable {
//    var name: String
//    var image: String
//}

struct Event: Codable {
    var datetime_utc: String
    var venue: Venue
    var performers: [Performers]
}

struct Venue: Codable {
    var display_location: String
}

struct Performers: Codable {
    var name: String
    var image: String
}
