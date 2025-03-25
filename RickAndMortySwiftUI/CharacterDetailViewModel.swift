//
//  CharacterDetailViewModel.swift
//  RickAndMortySwiftUI
//
//  Created by Carlos Agudelo on 24/03/25.
//

import Foundation
import SwiftUI

@MainActor
class CharacterDetailViewModel: ObservableObject {
    @Published var character: Character?
    @Published var isLoading = false
    @Published var error: String?
    
    private let apiService: ApiService
    
    init(apiService: ApiService = ApiService()) {
        self.apiService = apiService
    }
    
    func fetchCharacter(id: Int) {
        isLoading = true
        Task {
            do {
                self.character = try await self.apiService.fetchCharacter(id: id)
                self.error = nil
            } catch {
                //error = "An error occurred"
            }
            isLoading = false
        }
    }
}
