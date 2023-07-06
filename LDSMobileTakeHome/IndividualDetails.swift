//
//  IndividualDetails.swift
//  LDSMobileTakeHome
//
//  Created by Ephraim Kunz on 7/5/23.
//

import Foundation
import SwiftUI

struct IndividualDetails: View {
    let individual: Individual
    
    var body: some View {
        List {
            Section {
                
            } header: {
                AsyncImage(url: individual.profilePicture) { image in
                    image
                        .resizable()
                        .scaledToFit()
                } placeholder: {
                    
                }
                .padding(.horizontal, -40)
            }
            

            Section {
                HStack {
                    Text("Affiliation", comment: "Title for affiliation row in individual details")
                    Spacer()
                    
                    Group {
                        individual.affiliation.image
                            .resizable()
                            .renderingMode(.template)
                            .scaledToFit()
                            .frame(width: 20)
                        Text(individual.affiliation.displayName)
                    }
                    .foregroundStyle(.secondary)
                }
                
                HStack {
                    Text("Birthdate", comment: "Title for birthdate row in individual details")
                    Spacer()
                    Text(individual.birthdate.formatted(date: .long, time: .omitted))
                        .foregroundStyle(.secondary)
                }
                
                HStack {
                    Text("Force Sensitive", comment: "Title for force sensitive row in individual details")
                    Spacer()
                    Image(systemName: individual.forceSensitive ? "checkmark" : "xmark")
                        .bold()
                        .foregroundStyle(individual.forceSensitive ? Color.green : Color.red)
                }
            } header: {
                Text("Statistics", comment: "Section title in event details for individual statistics")
            }
        }
        .navigationTitle(individual.fullNameText)
    }
}
