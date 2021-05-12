//
//  EventModel.swift
//  SeatGeekChallengeUIKit
//
//  Created by Ronald Joubert on 5/12/21.
//

import Foundation

struct EventWrapper: Codable {
    var resultCount: Int
    var results: [Event]
}

struct Event: Codable {
    var events: EventDetail
    var datetime_utc: String
}

struct EventDetail: Codable {
    var venue: Venue
    var performers: Performer
}

struct Venue: Codable {
    var display_location: String
}

struct Performer: Codable {
    var name: String
    var image: String
}
