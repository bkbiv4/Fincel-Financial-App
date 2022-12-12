//
//  CreateTransactionsView.swift
//  Fincel
//
//  Created by Bruce Beuzard IV on 12/7/22.
//

import SwiftUI
import CoreData

struct CreateBillsView: View {
    
    @Environment(\.managedObjectContext) private var viewContext
    @Environment(\.presentationMode) var presentationMode
    
    @FetchRequest(entity: Bill.entity(), sortDescriptors: [])
    private var bills: FetchedResults<Bill>
    
    @State private var billNameTextField: String = ""
    @State private var billAmountTextField: Double = 0.00
//    @State private var transactionTypeTextField: String = ""
//    @State private var transactionRepeatTextField: String = ""
//    @State private var transactionDatetextField: String = ""
    @State private var billRepeatOptionIndex = 0
    @State private var billDate = Date()
    
    var billRepeatOptions = ["Never", "Daily", "Weekly", "Biweekly", "Semi-Monthly", "Monthly", "Quarterly", "Semi-Annually", "Yearly"]
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Transaction Details")) {
                    HStack() {
                        Text("Name")
                            .frame(width: 100, height: 15, alignment: .leading)
                        TextField("Enter Name Here", text: $billNameTextField)
                            .padding(5)
                            .background(Color.gray.opacity(0.25).cornerRadius(10))
                        Spacer()
                    }
                    .frame(height: 15.0)

                    HStack() {
                        Text("Amount")
                            .frame(width: 100, height: 15, alignment: .leading)
                        TextField("", value: $billAmountTextField,
                            format: .currency(code: "USD"))
                            .padding(5)
                            .background(Color.gray.opacity(0.25).cornerRadius(10))
                        Spacer()
                    }
                    .frame(height: 15.0)
                    
                    DatePicker(
                        "Transaction Date",
                        selection: $billDate,
                        displayedComponents: [.date]
                    )
                }
                Section {
                    Picker(selection: $billRepeatOptionIndex, label:
                        Text("Repeat?")) {
                        ForEach(0 ..< billRepeatOptions.count, id: \.self) {
                            Text(self.billRepeatOptions[$0]).tag($0)
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
//        newTransaction.transactionRepeat = transactionRepeatOptions[transactionRepeatOptionIndex]

        var dateComponent = DateComponents()
        
        switch billRepeatOptions[billRepeatOptionIndex] {
        case "Daily":
            print()
        case "Weekly":
            print()
        case "Biweekly":
            for x in 0...24 {
                dateComponent.weekOfYear = (x*2)
                let newDate = Calendar.current.date(byAdding: dateComponent, to: billDate)!
                let tuple = CoreDataManager.shared.createBill(billName: billNameTextField, billAmount: billAmountTextField, billRepeat: billRepeatOptions[billRepeatOptionIndex], billDate: newDate)
                if let error = tuple.1 {
                    print(error)
                }
                else {
                    print(tuple.0!)
                }
            }
            presentationMode.wrappedValue.dismiss()
        case "Semi-Monthly":
            print()
        case "Monthly":
            print()
        case "Quarterly":
            print()
        case "Semi-Annually":
            print()
        case "Yearly":
            print()
        default:
            let tuple = CoreDataManager.shared.createBill(billName: billNameTextField, billAmount: billAmountTextField, billRepeat: billRepeatOptions[billRepeatOptionIndex], billDate: billDate)
            if let error = tuple.1 {
                print(error)
            }
            else {
                print(tuple.0!)
            }
            presentationMode.wrappedValue.dismiss()
            
        }
        
    }
}

struct CreateTransactionsView_Previews: PreviewProvider {
    static var previews: some View {
        CreateBillsView()
    }
}
