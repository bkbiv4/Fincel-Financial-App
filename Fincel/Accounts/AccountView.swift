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
    var accounts: FetchedResults<Account>
    
    @State var showCreateAccontView: Bool = false
    @State var showAccountTransactionView: Bool = false
    
//    @State var maccount: Account?
    
    var body: some View {
        ZStack {
            NavigationView {
                List {
                    ForEach(self.accounts.indices, id: \.self) { index in
//                        let maccount = account
                        HStack {
                            Text(accounts[index].accountName!)
                            
                            if accounts[index].accountBalance >= 0 {
                                Text("$ \(String(accounts[index].accountBalance))")
                                .foregroundColor(Color.green)
                            }
                            else {
                                Text("$ \(String(accounts[index].accountBalance))")
                                .foregroundColor(Color.red)
                            }
                        }
                        .onTapGesture {
                            print("Opening Transactions for  \(String(accounts[index].accountBalance))")
                            print(accounts[index])
//                            self.accounts[i]
                            TransactionsView().account = accounts[index]
                            showAccountTransactionView.toggle()
                            
                        }
                        
                    }
                        .onDelete(perform: { indexset in
                            
                        })
                        
                        
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
