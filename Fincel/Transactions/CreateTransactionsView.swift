//
//  CreateTransactionsView.swift
//  Fincel
//
//  Created by Bruce Beuzard IV on 12/7/22.
//

import SwiftUI


struct CreateTransactionsView: View {
    
    @Environment(\.managedObjectContext) private var viewContext
    @Environment(\.presentationMode) var presentationMode
    
    @FetchRequest(entity: Transaction.entity(), sortDescriptors: [])
    private var transactions: FetchedResults<Transaction>
    
    @State private var transactionNameTextField: String = ""
    @State private var transactionAmountTextField: Double = 0.00
//    @State private var transactionTypeTextField: String = ""
//    @State private var transactionRepeatTextField: String = ""
//    @State private var transactionDatetextField: String = ""
    @State private var transactionRepeatOptionIndex = 0
    @State private var transactionDate = Date()
    
    var transactionRepeatOptions = ["Never", "Daily", "Weekly", "Biweekly", "Monthly", "Semi-Monthly", "Semi-Annually", "Yearly"]
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Transaction Details")) {
                    HStack() {
                        Text("Name")
                            .frame(width: 100, height: 15, alignment: .leading)
                        TextField("Enter Name Here", text: $transactionNameTextField)
                            .padding(5)
                            .background(Color.gray.opacity(0.25).cornerRadius(10))
                        Spacer()
                    }
                    .frame(height: 15.0)

                    HStack() {
                        Text("Amount")
                            .frame(width: 100, height: 15, alignment: .leading)
                        TextField("", value: $transactionAmountTextField,
                            format: .currency(code: "USD"))
                            .padding(5)
                            .background(Color.gray.opacity(0.25).cornerRadius(10))
                        Spacer()
                    }
                    .frame(height: 15.0)
                    
                    DatePicker(
                        "Transaction Date",
                        selection: $transactionDate,
                        displayedComponents: [.date]
                    )
                }
                Section {
                    Picker(selection: $transactionRepeatOptionIndex, label:
                        Text("Repeat?")) {
                        ForEach(0 ..< transactionRepeatOptions.count) {
                            Text(self.transactionRepeatOptions[$0]).tag($0)
                        }
                    }
                }
            }
            .padding()
            .navigationTitle("Create Transaction")
            .navigationBarItems(
                trailing:
                    Button(action: addTransaction) {
                        Text("Save")
                    })
        }
    }
    
    private func addTransaction() {
        print("Saving Transaction")
        let newTransaction = Transaction(context: viewContext)
    }
}

struct CreateTransactionsView_Previews: PreviewProvider {
    static var previews: some View {
        CreateTransactionsView()
    }
}
