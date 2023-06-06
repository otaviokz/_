//
//  ViewModelType.swift
//  MinimaLists-iOS
//
//  Created by Otávio Zabaleta on 06/06/2023.
//

import Combine
import Foundation
import SwiftUI

protocol ViewModelType: AnyObject {
    var isLoading: Bool { get set }
    var errorSubject: PassthroughSubject<ServiceError, Never> { get }
    func refresh()
    func runInTask(block: @escaping () async throws -> Void)
    func treatTaskError(_ error: Error)
}

extension ViewModelType {
    @MainActor
    func runInTask(block: @escaping () async throws -> Void) {
        Task {
            do {
                try await block()
            } catch {
                treatTaskError(error)
            }
        }
    }
    
    @MainActor
    func treatTaskError(_ error: Error) {
        if let serviceError = error as? ServiceError {
            errorSubject.send(serviceError)
        } else {
            errorSubject.send(.unknown)
        }
    }
}
