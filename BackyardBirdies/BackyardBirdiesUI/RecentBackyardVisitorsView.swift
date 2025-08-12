//
//  RecentBackyardVisitorsView.swift
//  BackyardBirdies
//
//  Created by patrick charlson on 21/07/2025.
//

import SwiftUI

struct RecentBackyardVisitorsView: View {
    var backyard: Backyard
    
    @State private var seeAll = false
    
    init(backyard: Backyard) {
        self.backyard = backyard
    }
    
    var events: [BackyardVisitorEvent] {
        if !seeAll {
            return Array(backyard.historicalEvents.prefix(6))
        } else {
            return backyard.historicalEvents
        }
    }
    
    var body: some View {
        ForEach(events) { event in
            HStack {
                if let bird = event.bird {
                    BirdIcon(bird: bird)
                        .frame(width: 60, height: 60)
                }
            }
        }
        
    }
}


#Preview {
    ModelPreview { backyard in
        RecentBackyardVisitorsView(backyard: backyard)
    }
}
