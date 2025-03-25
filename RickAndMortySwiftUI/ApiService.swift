//
//  ApiService.swift
//  RickAndMortySwiftUI
//
//  Created by Carlos Agudelo on 24/03/25.
//

import Foundation

enum ApiError: Error {
    case invalidURL
    case requestFailed
    case invalidData
}

class ApiService {
    func fetchCharacters() async throws -> [Character] {
        guard let url = URL(string: "https://rickandmortyapi.com/api/character") else {
            throw ApiError.invalidURL
        }
        let (data, response) = try await URLSession.shared.data(from: url)
        guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
            throw ApiError.requestFailed
        }
        
        do {
            let decoder = JSONDecoder()
            let decodedResponse = try decoder.decode(CharactersResponse.self, from: data)
            return decodedResponse.results
        } catch {
            throw ApiError.invalidData
        }
    }
    
    func fetchCharacter(id: Int) async throws -> Character {
           guard let url = URL(string: "https://rickandmortyapi.com/api/character/\(id)") else {
               throw ApiError.invalidURL
           }
           let (data, response) = try await URLSession.shared.data(from: url)
           guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
               throw ApiError.requestFailed
           }
           
           do {
               let decoder = JSONDecoder()
               let decodedResponse = try decoder.decode(Character.self, from: data)
               return decodedResponse
           } catch {
               throw ApiError.invalidData
           }
       }
}
