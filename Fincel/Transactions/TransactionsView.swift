//
//  TransactionsView.swift
//  Fincel
//
//  Created by Bruce Beuzard IV on 6/25/22.
//

import SwiftUI
import CoreData

struct TransactionsView: View {
    
    @State var account: Account?
    
    var body: some View {
        NavigationView {
            List {
                
            }
            .navigationBarItems(
                trailing:
                    Button(action: addTranscation) {
                        Text("Add")
                })                                 
        }
        
    }
    
    private func addTranscation() {
        
    }
}

struct TransactionsView_Previews: PreviewProvider {
    static var previews: some View {
        TransactionsView()
    }
}
