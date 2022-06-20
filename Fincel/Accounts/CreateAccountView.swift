//
//  CreateAccountView.swift
//  Fincel
//
//  Created by Bruce Beuzard IV on 6/19/22.
//

import SwiftUI

struct CreateAccountView: View {
    
    @State var accountNameTextField: String = ""
    @State var accountType: String = ""
    @State var accountBalance: String = ""
    
    
    var body: some View {
        NavigationView {
            VStack (alignment: .leading, spacing: 25) {
                HStack () {
                    Label("Account Name", image: "Yerd")
                        .frame(width: 150, height: 15, alignment: .leading)
                    TextField("Account Name", text: $accountNameTextField)
                        .padding(5)
                        .background(Color.gray.opacity(0.25).cornerRadius(10))
                }
                .frame(height: 15.0)
                
                HStack () {
                    Label("Account Type", image: "Yerd")
                        .frame(width: 150, height: 15, alignment: .leading)
                    TextField("Account Type", text: $accountType)
                        .padding(5)
                        .background(Color.gray.opacity(0.25).cornerRadius(10))
                }
                .frame(height: 15)
                    
                HStack () {
                    Label("Account Balance", image: "Yerd")
                        .frame(width: 150, height: 15, alignment: .leading)
                    TextField("Account Balance", text: $accountBalance)
                        .padding(5)
                        .background(Color.gray.opacity(0.25).cornerRadius(10))
                }
                .frame(height: 15)
            }
            
        }
    }
}

struct CreateAccountView_Previews: PreviewProvider {
    static var previews: some View {
        CreateAccountView()
    }
}