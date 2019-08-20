//
//  NetworkDataFetcher.swift
//  photoLib
//
//  Created by Anastasiia Gachkovskaya on 20/08/2019.
//  Copyright © 2019 Anastasia Gachkovskaya. All rights reserved.
//

import Foundation

class NetworkDataFetcher {

    var networkService = NetworkService()

    func fetchImages(searchTerm: String, completion: @escaping (SearchResults?) -> ()) {
        networkService.request(searchTerm: searchTerm) { (data, error) in
            if let error = error {
                print("Error received requesting data: \(error.localizedDescription) ")
                completion(nil)
            }
            let decoded = self.decodeJSON(type: SearchResults.self, from: data)
            completion(decoded)
        }
    }

    func decodeJSON<T: Decodable>(type: T.Type, from: Data?) -> T? {
        let decoder = JSONDecoder()
        guard let data = from else {return nil}

        do {
            let objects = try decoder.decode(type.self, from: data)
            return objects
        } catch let jsonError {
            print("Failed to decode JSON", jsonError)
            return nil
        }
    }


}
