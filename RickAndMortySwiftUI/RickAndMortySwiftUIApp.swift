//
//  RickAndMortySwiftUIApp.swift
//  RickAndMortySwiftUI
//
//  Created by Carlos Agudelo on 24/03/25.
//

import SwiftUI

@main
struct RickAndMortySwiftUIApp: App {
    var body: some Scene {
        WindowGroup {
            CharacterListView(viewModel: CharacterListViewModel())
        }
    }
}
