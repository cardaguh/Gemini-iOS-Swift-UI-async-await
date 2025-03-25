//
//  CharacterListView.swift
//  RickAndMortySwiftUI
//
//  Created by Carlos Agudelo on 24/03/25.
//

import SwiftUI

struct CharacterListView: View {
    @ObservedObject var viewModel: CharacterListViewModel
    
    var body: some View {
        NavigationView {
            List(viewModel.characters) { character in
                NavigationLink(destination: CharacterDetailView(viewModel: CharacterDetailViewModel(), characterId: character.id)) {
                    CharacterRow(character: character)
                }
            }
            .navigationTitle("Rick and Morty")
            .onAppear {
                viewModel.fetchCharacters()
            }
            .overlay {
                if viewModel.isLoading {
                    ProgressView()
                } else if let error = viewModel.error {
                    Text(error)
                }
            }
        }
    }
}

struct CharacterRow: View {
    let character: Character
    
    var body: some View {
        HStack {
            AsyncImage(url: URL(string: character.image)) { image in
                           image
                               .resizable()
                               .scaledToFit()
                       } placeholder: {
                           ProgressView()
                       }
                       .frame(width: 50, height: 50)
            Text(character.name)
                .bold()
        }
    }
}

