//
//  CharacterDetailView.swift
//  RickAndMortySwiftUI
//
//  Created by Carlos Agudelo on 24/03/25.
//

import SwiftUI

struct CharacterDetailView: View {
    @ObservedObject var viewModel: CharacterDetailViewModel
    let characterId: Int
    
    var body: some View {
        VStack {
            if let character = viewModel.character {
                ScrollView {
                    VStack(alignment: .leading) {
                        AsyncImage(url: URL(string: character.image)) { image in
                            image
                                .resizable()
                                .scaledToFit()
                        } placeholder: {
                            ProgressView()
                        }
                        .frame(width: 300, height: 300)
                        Text(character.name)
                            .font(.title)
                        InfoRow(label: "Status", value: character.status)
                        InfoRow(label: "Species", value: character.species)
                        InfoRow(label: "Gender", value: character.gender)
                        if !character.type.isEmpty {
                            InfoRow(label: "Type", value: character.type)
                        }
                        InfoRow(label: "Origin", value: character.origin.name)
                        InfoRow(label: "Location", value: character.location.name)
                    }
                }
            } else if let error = viewModel.error {
                Text(error)
            }
            else if viewModel.isLoading {
                ProgressView()
            }
        }
        .navigationTitle(viewModel.character?.name ?? "Character")
        .onAppear {
            viewModel.fetchCharacter(id: characterId)
        }
    }
}
struct InfoRow: View {
    let label: String
    let value: String
    
    var body: some View {
        HStack {
            Text("\(label):").bold()
            Text(value)
        }
        .padding(.horizontal)
    }
}
