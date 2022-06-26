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
            List {}
                .navigationTitle("Account: \(account?.accountName)")
        }
        
    }
}

struct TransactionsView_Previews: PreviewProvider {
    static var previews: some View {
        TransactionsView()
    }
}
