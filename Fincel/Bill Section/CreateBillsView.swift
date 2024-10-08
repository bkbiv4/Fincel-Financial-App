//
//  CreateTransactionsView.swift
//  Fincel
//
//  Created by Bruce Beuzard IV on 12/7/22.
//

import SwiftUI
import CoreData


/*
 Code to Add:
 Dismiss calendarview upon selection
 
 
 
 */

struct CreateBillsView: View {
    
    @Environment(\.managedObjectContext) private var viewContext
    @Environment(\.presentationMode) var presentationMode
    
    @FetchRequest(entity: Bill.entity(), sortDescriptors: [])
    private var bills: FetchedResults<Bill>
    
    @State private var billNameTextField: String = ""
    @State private var billAmountTextField: Double = 0.00
    @State private var billRepeatOptionIndex = 0
    @State private var billDate = Date()
    @State private var transactionType = 1
    @State var bill: Bill?
    
    
    
    var billRepeatOptions = ["Never", "Daily", "Weekly", "Biweekly", "Semi-Monthly", "Monthly", "Quarterly", "Semi-Annually", "Yearly"]
    var body: some View {
        NavigationView {
            
            Form {
                Section {
                    Picker(selection: $transactionType) {
                        Text("Expense").tag(1)
                        Text("Income").tag(2)
                    } label: {
                        Text("Type")
                    }
                }
                .pickerStyle(SegmentedPickerStyle())
                .onAppear { transactionType }
                
                Section(header: Text("Bill Details")) {
                    HStack() {
                        Text("Name")
                            .frame(width: 100, height: 15, alignment: .leading)
                        TextField("Enter Name Here", text: $billNameTextField)
                            .onAppear { billNameTextField = bill?.billName ?? "" }
                            .padding(5)
                            .background(Color.gray.opacity(0.25).cornerRadius(10))
                        Spacer()
                        
                    }
                    .frame(height: 15.0)
                    //align amount to the right
                    HStack() {
                        Text("Amount")
                            .frame(width: 100, height: 15, alignment: .leading)
                        TextField("", value: $billAmountTextField, format: .currency(code: "USD"))
                            .onAppear { billAmountTextField = bill?.billAmount ?? 0.00}
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
                    .onAppear {billDate = bill?.billDate ?? Date()}
                }
                
                Section {
                    Picker(selection: $billRepeatOptionIndex, label:
                        Text("Repeat?")) {
                        ForEach(0 ..< billRepeatOptions.count, id: \.self) {
                            Text(self.billRepeatOptions[$0]).tag($0)
                        }
                    }
                        .onAppear {
                            switch bill?.billRepeat {
                            case "Daily":
                                billRepeatOptionIndex = 1
                            case "Weekly":
                                billRepeatOptionIndex = 2
                            case "Biweekly":
                                billRepeatOptionIndex = 3
                            case "Semi-Monthly":
                                billRepeatOptionIndex = 4
                            case"Monthly":
                                billRepeatOptionIndex = 5
                            case "Quarterly":
                                billRepeatOptionIndex = 6
                            case "Semi-Annually":
                                billRepeatOptionIndex = 7
                            case "Yearly":
                                billRepeatOptionIndex = 8
                            default:
                                billRepeatOptionIndex = 0

                            }
                        }
                    HStack {
                        Text("# of Repeats")
//                        TextField("",)
                    }
                    

                }
            }
            .padding()
            .navigationTitle("Create Bill")
            .navigationBarItems(
                trailing:
                    Button(action: addTransaction) {
                        Text("Save")
                    })
        }
    }
    
    private func addTransaction() {
//        newTransaction.transactionRepeat = transactionRepeatOptions[transactionRepeatOptionIndex]
        
//        guard let billName = billNameTextField else { return }

        var dateComponent = DateComponents()
        if transactionType == 1 { billAmountTextField *= -1}
        
        switch billRepeatOptions[billRepeatOptionIndex] {
        case "Daily":
            print()
        case "Weekly":
            for x in 0...144 {
                dateComponent.weekOfYear = x
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
        case "Biweekly":
            for x in 0...24 {
                dateComponent.weekOfYear = (x*2)
                let newDate = Calendar.current.date(byAdding: dateComponent, to: billDate)!
                let tuple = CoreDataManager.shared.createBill(billName: billNameTextField, billAmount: billAmountTextField, billRepeat: billRepeatOptions[billRepeatOptionIndex], billDate: newDate)
                if let error = tuple.1 {
                    print(error)
                }
                else {
                    // creation success
                    print(tuple.0!)
                }
            }
            presentationMode.wrappedValue.dismiss()
        case "Semi-Monthly":
            print()
        case "Monthly":
            for x in 0...12 {
                dateComponent.month = x
                let newDate = Calendar.current.date(byAdding: dateComponent, to: billDate)!
                let tuple = CoreDataManager.shared.createBill(billName: billNameTextField, billAmount: billAmountTextField, billRepeat: billRepeatOptions[billRepeatOptionIndex], billDate: newDate)
                
                if let error = tuple.1 {
                    print(error)
                }
                else {
                    // creation success
                    print(tuple.0!)
                }
            }
            presentationMode.wrappedValue.dismiss()
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
