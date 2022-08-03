//
//  Singleton.swift
//  SeSACTMDBProject
//
//  Created by 권민서 on 2022/08/03.
//

import Foundation

class Genre {
    static let shared = Genre()
    var genre: [Int: String] = [:]
}
