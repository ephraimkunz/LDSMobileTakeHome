//
//  IndividualCell.swift
//  LDSMobileTakeHome
//
//  Created by Ephraim Kunz on 7/5/23.
//

import Foundation
import SwiftUI

struct IndividualCell: View {
    let individual: Individual
    
    var body: some View {
        NavigationLink {
            IndividualDetails(individual: individual)
        } label: {
            HStack {
                AsyncImage(url: individual.profilePicture) { image in
                    image
                        .resizable()
                        .scaledToFit()
                } placeholder: {
                    ProgressView()
                }
                .clipShape(RoundedRectangle(cornerRadius: 4))
                .frame(width: 60, height: 60)

                VStack(alignment: .leading) {
                    individual.fullNameText
                        .fontWeight(.medium)
                    
                    HStack {
                        individual.affiliation.image
                            .resizable()
                            .renderingMode(.template)
                            .foregroundStyle(.primary)
                            .scaledToFit()
                            .frame(width: 15)
                        
                        Text(individual.affiliation.displayName)
                    }
                    .font(.caption)
                }
            }
        }
    }
}
