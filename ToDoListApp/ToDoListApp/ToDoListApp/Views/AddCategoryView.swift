//
//  AddCategoryView.swift
//  ToDoListApp
//
//  Created by student on 01/06/2024.
//

import SwiftUI

struct AddCategoryView: View {
    // Dostęp do zawartosci zarzadzanej przez Core Data
    @Environment(\.managedObjectContext) private var viewContext
    
    // Umozliwia powrot do poprzedniego widoku
    @Environment(\.presentationMode) var presentationMode
    
    // Stan przechowujacy nazwe kategorii
    @State private var categoryName = ""
    
    // Stan przechowujacy wiadomosc o bledzie
    @State private var errorMessage = ""
    
    // Walidacja nazwy kategorii
    var isNameValid: Bool {
        let isValid = categoryName.allSatisfy { $0.isLetter || $0.isWhitespace }
        
        if (!isValid) {
            errorMessage = "Nazwa kategorii moze zawierac wylacznie litery."
        }
        return isValid
    }
    
    var body: some View {
        Form {
            Section(header: Text("Nazwa kategorii")) {
                TextField("Wprowadz nazwe kategorii", text: $categoryName)
                    .onChange(of: categoryName) {
                        // Walidacja nazwy przy kazdej zmianie
                        _ = isNameValid
                    }
                if !errorMessage.isEmpty {
                    Text(errorMessage)
                        .foregroundColor(.red)
                }
            }
            Button("Zapisz") {
                let newCategory = Category(context: viewContext)
                newCategory.name = categoryName
                do {
                    // Zapis nowej kategorii w bazie danych
                    try viewContext.save()
                    // Powrot do poprzedniego widoku (po zapisaniu)
                    presentationMode.wrappedValue.dismiss()
                } catch {
                    // Wiadomosc o bledzie 
                    errorMessage = "Wystapil problem, sprobuj ponownie."
                }
            }
            // Wylaczenie przycisku (walidacja)
            .disabled(!isNameValid)
        }
      
        .navigationTitle("Nowa kategoria")
    }
}
