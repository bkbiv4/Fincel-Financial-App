//
//  AccountView.swift
//  Fincel
//
//  Created by Bruce Beuzard IV on 6/19/22.
//

import SwiftUI

struct AccountView: View {
    
    @Environment(\.managedObjectContext) private var viewContext
    
    @FetchRequest(entity: Account.entity(), sortDescriptors: [])
    private var accounts: FetchedResults<Account>
    
    @State var showCreateAccontView: Bool = false
    
    var body: some View {
        ZStack {
            NavigationView {
                List {
                    ForEach(accounts) { account in
                        Text("Account: \(account.accountName!)")
                    }
                }
                .navigationTitle("Accounts")
                .navigationBarItems(
                    trailing:
                        Button("Add") {
                            showCreateAccontView.toggle()
                        }
                )
            }
            .navigationViewStyle(.stack)
            
            if showCreateAccontView {
                CreateAccountView()
                    .frame(height: UIScreen.main.bounds.height * 0.5)
                    .transition(.move(edge: .bottom))
                    .animation(.easeInOut)
            }
        }
    }
    
    
    private func createAccountScreen() {
        
        
    }
}

struct AccountView_Previews: PreviewProvider {
    static var previews: some View {
        AccountView()
    }
}
