//
//  CreateAccountView.swift
//  Fincel
//
//  Created by Bruce Beuzard IV on 6/19/22.
//

import SwiftUI
import CoreData

struct CreateAccountView: View {
    
    @Environment(\.managedObjectContext) private var viewContext
    
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Account.accountName, ascending: true)],
        animation: .default)
    private var accounts: FetchedResults<Account>
    
    @State var accountNameTextField: String = ""
    @State var accountType: String = ""
    @State var accountBalance: String = ""
    
    var body: some View {

        NavigationView {
            VStack (spacing: 25) {
                HStack () {
                    Label("Account Name", image: "")
                        .frame(width: 150, height: 15, alignment: .leading)
                    TextField("Account Name", text: $accountNameTextField)
                        .padding(5)
                        .background(Color.gray.opacity(0.25).cornerRadius(10))
                }
                .frame(height: 15.0)
                
                HStack () {
                    Label("Account Type", image: "")
                        .frame(width: 150, height: 15, alignment: .leading)
                    TextField("Account Type", text: $accountType)
                        .padding(5)
                        .background(Color.gray.opacity(0.25).cornerRadius(10))
                }
                .frame(height: 15)
                    
                HStack () {
                    Label("Account Balance", image: "")
                        .frame(width: 150, height: 15, alignment: .leading)
                    TextField("Account Balance", text: $accountBalance)
                        .padding(5)
                        .background(Color.gray.opacity(0.25).cornerRadius(10))
                }
                .frame(height: 15)
                Spacer()
            }
            .padding()
            .navigationTitle("Create Account")
            
            .navigationBarItems(
                trailing:
                    Button(action: createAccount) {
                        Text("Save".uppercased())
                    }
            )
        }
    }
    
    private func createAccount() {
        let account = ""
        
        do {
            try viewContext.save()
        } catch {
            let nsError = error as NSError
            fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
        }
        
        
        print("Saving The New Account")
        
        
    }
}

struct CreateAccountView_Previews: PreviewProvider {
    static var previews: some View {
        CreateAccountView()
    }
}
