//
//  CharacterListViewModel.swift
//  RickAndMortySwiftUI
//
//  Created by Carlos Agudelo on 24/03/25.
//

import Foundation
import SwiftUI

@MainActor
class CharacterListViewModel: ObservableObject {
    @Published var characters: [Character] = []
    @Published var isLoading = false
    @Published var error: String?

    private let apiService: ApiService

    init(apiService: ApiService = ApiService()) {
        self.apiService = apiService
    }

    func fetchCharacters() {
        isLoading = true
        Task {
            do {
                characters = try await apiService.fetchCharacters()
                error = nil
            } catch {
                self.error = "An error occurred in project"
            }
            isLoading = false
        }
    }
}
