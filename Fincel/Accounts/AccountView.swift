//
//  AccountView.swift
//  Fincel
//
//  Created by Bruce Beuzard IV on 6/19/22.
//

import SwiftUI
import CoreData

struct AccountView: View {
    
    @Environment(\.managedObjectContext) private var viewContext
    
    @FetchRequest(entity: Account.entity(), sortDescriptors: [NSSortDescriptor(keyPath: \Account.accountName, ascending: true)])
    private var accounts: FetchedResults<Account>
    
    @State var showCreateAccontView: Bool = false
    @State var showAccountTransactionView: Bool = false
    
//    @State var maccount: Account?
    
    var body: some View {
        ZStack {
            NavigationView {
                List {
                    ForEach(accounts) { account in
//                        let maccount = account
                        HStack {
                            Text(account.accountName!)
                            
                            if account.accountBalance >= 0 {
                                Text("$ \(String(account.accountBalance))")
                                .foregroundColor(Color.green)
                            }
                            else {
                                Text("$ \(String(account.accountBalance))")
                                .foregroundColor(Color.red)
                            }
                        }
                        
                    }
                        .onDelete(perform: { indexset in
                            
                        })
                        .onTapGesture {
                            print("Opening Transactions for")
//                            self.accounts[i]
//                            TransactionsView().account = maccount
                            showAccountTransactionView.toggle()
                            
                        }
                        
                }
                    
                    .navigationTitle("Accounts")
                    .navigationBarItems(trailing: Button("Add") { showCreateAccontView.toggle() } )
            }
                .navigationViewStyle(.stack)
                .sheet(isPresented: $showCreateAccontView) {
                    CreateAccountView()
                
                }
                .sheet(isPresented: $showAccountTransactionView) {
                    TransactionsView()
                }
            
        }
    }
    
    func deleteAccount(indexSet: IndexSet) {
//        accounts.remove(atOffset: indexSet)
    }
    
    
//    private func createAccountScreen() {
//        
//    }
}

struct AccountView_Previews: PreviewProvider {
    static var previews: some View {
        AccountView()
    }
}
