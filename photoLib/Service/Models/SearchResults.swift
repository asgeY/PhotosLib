//
//  SearchResults.swift
//  photoLib
//
//  Created by Anastasiia Gachkovskaya on 20/08/2019.
//  Copyright © 2019 Anastasia Gachkovskaya. All rights reserved.
//

import Foundation

struct SearchResults: Decodable {

    let total: Int
    let results: [UnsplashPhoto]
}

struct UnsplashPhoto: Decodable {
    let width: Int
    let height: Int
    let urls: [URLKind.RawValue: String]

    enum URLKind: String {
        case raw
        case full
        case regular
        case small
        case thumb
    }

}


