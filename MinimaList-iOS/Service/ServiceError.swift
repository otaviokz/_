//
//  ServiceError.swift
//  MinimaLists-iOS
//
//  Created by Otávio Zabaleta on 06/06/2023.
//

import Foundation

enum ServiceError: Error {
    case httpError(code: Int)
    case unknown
    case invalidData
}
