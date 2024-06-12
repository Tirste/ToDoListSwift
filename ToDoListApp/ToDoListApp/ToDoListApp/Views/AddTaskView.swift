//
//  AddTaskView.swift
//  ToDoListApp
//
//  Created by student on 01/06/2024.
//

import SwiftUI

struct AddTaskView: View {
    // Dostep do zawartosci zarzadzanej przez Core Data
    @Environment(\.managedObjectContext) private var viewContext
    
    @Environment(\.presentationMode) var presentationMode
    
    @State private var taskTitle = ""
    
    //Stan do kontrolki data
    @State private var dueDate = Date()
    
    @State private var errorMessage = ""
    
    //kategoria do ktorej przypisane jest zadanie
    var category: Category
    
    // Walidacja
    var isTitleValid: Bool {
    
        let isValid = taskTitle.allSatisfy { $0.isLetter || $0.isWhitespace }
        
        if !isValid {
            errorMessage = "Nazwa zadania moze zawierac wylacznie litery."
        } 
        return isValid
    }
    
    var body: some View {
        Form {
            Section(header: Text("Nazwa zadania")) {
                TextField("Wprowadz nazwe zadania", text: $taskTitle)
                    .onChange(of: taskTitle) {
                        // Walidacja przy zmianie
                        _ = isTitleValid
                    }
                if !errorMessage.isEmpty {
                    Text(errorMessage)
                        .foregroundColor(.red)
                }
            }
            Section(header: Text("Data zakonczenia")) {
                DatePicker("Wybierz date", selection: $dueDate, displayedComponents: .date)
            }
            Button("Zapisz") {
                addTask()
            }
            .disabled(!isTitleValid)
        }
        .navigationTitle("Nowe zadanie")
    }
    
    // Funckja dodajaca nowe zadanie
    private func addTask() {
        withAnimation {
            // nowy obiekt w CoreData
            let newTask = Task(context: viewContext)
            newTask.title = taskTitle
            newTask.dueDate = dueDate
            newTask.category = category
            newTask.isCompleted = false
            
            do {
                // zapis do db
                try viewContext.save()
               
                presentationMode.wrappedValue.dismiss()
            } catch {
                errorMessage = "Wystapil problem, sprobuj ponownie."
            }
        }
    }
}
