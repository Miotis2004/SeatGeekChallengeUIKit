//
//  EventViewModel.swift
//  SeatGeekChallengeUIKit
//
//  Created by Ronald Joubert on 5/12/21.
//

import SwiftUI

class EventViewModel {
    
    var networkManager: Network
    var eventArray: [Event]? {
        didSet {
            guard eventArray?.count ?? 0 > 0 else { return }
            self.updateHandler?()
        }
    }
    
    var updateHandler: (() -> Void)?
    var errorHandler: (() -> Void)?
    
    init(networkManager: Network = NetworkManager.shared) {
        self.networkManager = networkManager
    }
    
    func bind(updateHandler: @escaping (() -> Void), errorHandler: @escaping (() -> Void)) {
        self.updateHandler = updateHandler
        self.errorHandler = errorHandler
    }
}

extension EventViewModel {
    
    func callNetwork(name: String) {
        self.networkManager.loadEventList(name: name) { [weak self] (result) in
            switch result {
            case .success(let events):
                self?.eventArray = events
            case .failure(_):
                self?.errorHandler?()
            }
            
        }
    }
    
    func count() -> Int {
        return self.eventArray?.count ?? 0
    }
    
    func artistName(index: Int) -> String {
        guard self.count() > index else { return ""}
        return self.eventArray?[index].events.performers.name ?? "Artist name not found"
    }
    
    func displayLocation(index: Int) -> String {
        guard self.count() > index else { return ""}
        return self.eventArray?[index].events.venue.display_location ?? "Unknown Location"
    }
    
    func date(index: Int) -> String {
        guard self.count() > index else { return ""}
        return self.eventArray?[index].datetime_utc ?? "Unknown Date"
    }
    
}
