//
//  NetworkManager.swift
//  SeatGeekChallengeUIKit
//
//  Created by Ronald Joubert on 5/12/21.
//

import SwiftUI

enum CustomError: Error {
    case urlFailure
    case dataFailure
    case decodeFailure
}

protocol Network {
    func loadEventList(name: String, completion: @escaping (Result<[Event], Error>) -> Void)
}

final class NetworkManager {
    static var shared = NetworkManager()
    
    let session: URLSession
    
    private init(session: URLSession = URLSession.shared) {
        self.session = session
    }
}

extension NetworkManager: Network {
    func loadEventList(name: String, completion: @escaping (Result<[Event], Error>) -> Void) {
        guard let url = URL(string: "https://api.seatgeek.com/2/events?client_id=MjE4OTUwMzZ8MTYyMDc3NDQxMS40MDEwMTA1&q=\(name)") else {
            print("Guard URL statement failed")
            completion(.failure(CustomError.urlFailure))
            return
        }

        self.session.dataTask(with: url) { (data, response, error) in
            guard let data = data else {
                completion(.failure(CustomError.dataFailure))
                return
            }

            print(data)

            do{
                let wrapper = try JSONDecoder().decode(EventWrapper.self, from: data)
                completion(.success(wrapper.events))
            } catch {
                print("Error decoding JSON")
                completion(.failure(CustomError.decodeFailure))
            }
        }.resume()
    }
    
//    func loadEventList(name: String, completion: @escaping (Result<[Event], Error>) -> Void) {
//        if let path = Bundle.main.path(forResource: "data", ofType: "json") {
//            do {
//                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
//
//                let wrapper = try JSONDecoder().decode(EventWrapper.self, from: data)
//
//                completion(.success(wrapper.events))
//            } catch {
//                print(error)
//                print("Error decoding json \(error.localizedDescription)")
//                completion(.failure(CustomError.decodeFailure))
//            }
//        }
//    }
}
