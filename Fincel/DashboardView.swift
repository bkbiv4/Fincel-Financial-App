//
//  DashboardView.swift
//  Fincel
//
//  Created by Bruce Beuzard IV on 6/18/22.
//

import SwiftUI
import UIKit

struct DashboardView: View {
    var body: some View {
        Text("Dashboard")
            .font(.title)
            .fontWeight(.black)
            .foregroundColor(Color.yellow)
        
        Text("Ma Daughter")
            .speechSpellsOutCharacters()
            .font(.callout)
            .foregroundColor(Color(UIColor.tealColor))
        
        
    }

    
}

struct Dashboard_Previews: PreviewProvider {
    static var previews: some View {
        DashboardView()
    }
}
