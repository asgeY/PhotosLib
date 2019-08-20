//
//  NetworkService.swift
//  photoLib
//
//  Created by Anastasiia Gachkovskaya on 19/08/2019.
//  Copyright © 2019 Anastasia Gachkovskaya. All rights reserved.
//

import Foundation

class NetworkService {


    // построение запроса данных по URL

    func request(searchTerm: String, completion: @escaping (Data?, Error? ) -> Void) {
        let parametrs = self.prepareParameters(searchTerm: searchTerm)
        let url = self.url(params: parametrs)
        var request = URLRequest(url: url)
        request.allHTTPHeaderFields = prepareHeaders()
        request.httpMethod = "get"
        let task = createDataTask(from: request, completion: completion)
        task.resume()
    }

    private func prepareHeaders() -> [String:String]? {
        var headers = [String: String]()
        headers["Authorization"] = "Client-ID 050c5570c477260cb15dad9198f996ba0890b456521f591ad24cc02069acd8f4"
        return headers
    }

    private func prepareParameters(searchTerm: String?) -> [String: String] {
        var parameters = [String: String]()
        parameters["query"] = searchTerm
        parameters["page"] = String(1)
        parameters["per_page"] = String(30)
        return parameters
    }

    private func url(params: [String: String]) -> URL {
        var components = URLComponents()
        components.scheme = "https"
        components.host = "api.unsplash.com"
        components.path = "/search/photos"
        components.queryItems = params.map { URLQueryItem(name: $0, value: $1) }

        return components.url!
    }

    private func createDataTask(from request: URLRequest, completion: @escaping (Data?, Error?) -> Void) -> URLSessionDataTask {
        return URLSession.shared.dataTask(with: request, completionHandler: { (data, respone, error) in
            DispatchQueue.main.async {
                completion(data, error)
            }
        })
    }

}
