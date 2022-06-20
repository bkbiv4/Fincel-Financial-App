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
    @State var accountBalance: String = "0.0"
    
    
    var body: some View {
        VStack (alignment: .leading, spacing: 0) {
            
            HStack () {
                Label("Account Name", image: "Yerd")
                    .frame(width: 150, height: 15, alignment: .leading)
                TextField("Account Name", text: $accountNameTextField)
                    .foregroundColor(Color.green)
                    .background(Color.blue.opacity(0.25))
            }
            
            HStack () {
                Label("Account Type", image: "Yerd")
                    .frame(width: 150, height: 15, alignment: .leading)
                TextField("Account Type", text: $accountType)
                    .foregroundColor(Color.green)
                    .background(Color.blue.opacity(0.25))
            }
                
            HStack () {
                Label("Account Balance", image: "Yerd")
                    .frame(width: 150, height: 15, alignment: .leading)
                TextField("Account Balance", text: $accountBalance)
                    .foregroundColor(Color.green)
                    .background(Color.blue.opacity(0.25))
            }
                
        }
    }
}

struct CreateAccountView_Previews: PreviewProvider {
    static var previews: some View {
        CreateAccountView()
    }
}
