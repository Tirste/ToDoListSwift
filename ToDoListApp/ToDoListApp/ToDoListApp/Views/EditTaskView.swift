//
//  EditTaskView.swift
//  ToDoListApp
//
//  Created by student on 01/06/2024.
//

import SwiftUI

struct EditTaskView: View {
    // Dostep do zawartosci zarzadzanej przez Core Data
    @Environment(\.managedObjectContext) private var viewContext
    // powrot do poprzedniego widoku
    @Environment(\.presentationMode) var presentationMode
    // tytul zadania
    @State private var taskTitle: String
    // stan zakonczenie zadania
    @State private var dueDate: Date
    @State private var errorMessage = ""
    @ObservedObject var task: Task
    
    // ustawienie poczwatkowej wartosci stanu na podstawie przekazanych danych
    init(task: Task) {
        self.task = task
        _taskTitle = State(initialValue: task.title ?? "")
        _dueDate = State(initialValue: task.dueDate ?? Date())
    }
    
    // walidacja
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
                //aktualizacja danych
                task.title = taskTitle
                task.dueDate = dueDate
                do {
                    //zapis do bazy
                    try viewContext.save()
                    //powrot do widoku
                    presentationMode.wrappedValue.dismiss()
                } catch {
                    errorMessage = "Wystapil problem, sprobuj ponownie."
                }
            }
            .disabled(!isTitleValid)
        }
        .navigationTitle("Edytuj zadanie")
    }
}
