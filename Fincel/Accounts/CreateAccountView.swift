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
    @Environment(\.presentationMode) var presentationMode

    
    @FetchRequest(entity: Account.entity(), sortDescriptors: [])
    private var accounts: FetchedResults<Account>
    
    @State var accountNameTextField: String = ""
    @State var accountTypeTextField: String = ""
    @State var accountBalanceTextField: String = ""
    
    var body: some View {
        NavigationView {
            
            ZStack(alignment: .bottom) {
                VStack (spacing: 25) {
                    HStack () {
                        Text("Account Name")
                            .frame(width: 150, height: 15, alignment: .leading)
                        TextField("Account Name", text: $accountNameTextField)
                            .padding(5)
                            .background(Color.gray.opacity(0.25).cornerRadius(10))
                        Spacer()
                    }
                    .frame(height: 15.0)
                    
                    HStack () {
                        Text("Account Type")
                            .frame(width: 150, height: 15, alignment: .leading)
                        TextField("Account Type", text: $accountTypeTextField)
                            .padding(5)
                            .background(Color.gray.opacity(0.25).cornerRadius(10))
                        Spacer()
                    }
                    .frame(height: 15)
                        
                    HStack () {
                        Text("Account Balance")
                            .frame(width: 150, height: 15, alignment: .leading)
                        TextField("Account Balance", text: $accountBalanceTextField)
                            .padding(5)
                            .background(Color.gray.opacity(0.25).cornerRadius(10))
                        Spacer()
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
            .edgesIgnoringSafeArea(.bottom)
            
        }
        .navigationViewStyle(.stack)
        .cornerRadius(10)
    }
    
    
    private func createAccount() {
        let newAccount = Account(context: viewContext)
        
        if accountNameTextField.isEmpty {
            return
        }
        
        newAccount.accountName = accountNameTextField
        newAccount.accountType = accountTypeTextField
        
        do {
            try viewContext.save()
        } catch {
            let nsError = error as NSError
            fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
        }
        
        
        print("Saving The New Account", newAccount)
        presentationMode.wrappedValue.dismiss()
        
        
    }
    
    
}

struct CreateAccountView_Previews: PreviewProvider {
    static var previews: some View {
        CreateAccountView()
    }
}
