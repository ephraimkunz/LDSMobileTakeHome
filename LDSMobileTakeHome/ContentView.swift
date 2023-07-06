//
//  ContentView.swift
//  LDSMobileTakeHome
//
//  Created by Ephraim Kunz on 7/5/23.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    @Environment(\.modelContext) private var modelContext
    @Query(sort: \.id) private var individuals: [Individual]
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(individuals) { individual in
                    IndividualCell(individual: individual)
                }
            }
            .navigationTitle(Text("Individuals", comment: "Nav title for main individual list"))
            .refreshable {
                await fetchAndReplaceExistingModels()
            }
        }
        .task {
            // There's a bug right now where enums are not persisted properly (https://stackoverflow.com/questions/76476806/how-to-persist-custom-enum-with-swiftdata).
            // Ideally, we'd only fetch here when there was no data stored, like this:
//            if individuals.isEmpty {
//                await fetchAndSaveModels()
//            }
            
            // Instead, to work around the bug, we'll clear out what we have and refetch each time
            await fetchAndReplaceExistingModels()
        }
    }
    
    func fetchAndReplaceExistingModels() async {
        if let success = try? modelContext.delete(model: Individual.self), success {
            await fetchAndSaveModels()
        }
    }
    
    func fetchAndSaveModels() async {
        if let individuals = await NetworkManager.shared.fetchIndividuals() {
            for individual in individuals {
                modelContext.insert(individual)
            }
            
            try? modelContext.save()
        }
    }
}

#Preview {
    ContentView()
        .modelContainer(for: Individual.self, inMemory: true)
}
