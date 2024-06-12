//
//  EditCategoryView.swift
//  ToDoListApp
//
//  Created by student on 01/06/2024.
//

import SwiftUI

struct EditCategoryView: View {
    // Dostep do zawartosci zarzadzanej przez Core Data
    @Environment(\.managedObjectContext) private var viewContext
    
    // Umozliwia powrot do poprzedniego widoku
    @Environment(\.presentationMode) var presentationMode
    
    // Stan przechowujacy nazwe kategorii
    @State private var categoryName: String
    
    // Stan przechowujacy wiadomosc o bledzie
    @State private var errorMessage = ""
    
    // Zmienna przechowujaca edytowana kategorie
    var category: Category
    
    // Inicjalizator ustawiajacy poczatkowa nazwe kategorii
    init(category: Category) {
        self.category = category
        _categoryName = State(initialValue: category.name ?? "")
    }
    
    // Walidacja nazwy kategorii
    var isNameValid: Bool {
        // Sprawdzenie, czy nazwa kategorii zawiera tylko litery i spacje
        let isValid = categoryName.allSatisfy { $0.isLetter || $0.isWhitespace }
        
        if !isValid {
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
                    // Wyswietlanie bledu
                    Text(errorMessage)
                        .foregroundColor(.red)
                }
            }
            
            Button("Zapisz") {
                category.name = categoryName
                do {
                    // Zapis zmian do db
                    try viewContext.save()
                    //powrot do widoku
                    presentationMode.wrappedValue.dismiss()
                } catch {
                    //przykladowy blad
                    errorMessage = "Wystapil problem, sprobuj ponownie."
                }
            }
            // Wylaczenie przycisku (walidacja)
            .disabled(!isNameValid)
        }
        .navigationTitle("Edytuj kategorie")
    }
}
