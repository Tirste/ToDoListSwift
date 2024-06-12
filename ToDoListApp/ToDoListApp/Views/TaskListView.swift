//
//  TaskListView.swift
//  ToDoListApp
//
//  Created by student on 01/06/2024.
//

import SwiftUI
import CoreData

struct TaskListView: View {
    // kategoria dla listy zadan
    var category: Category
    @FetchRequest var tasks: FetchedResults<Task>
    @Environment(\.managedObjectContext) private var viewContext
    @State private var showingEditTaskView = false
    // edytowane zadanie
    @State private var taskToEdit: Task?
    
    // pobieranie zadan z kategorii
    init(category: Category) {
        self.category = category
        self._tasks = FetchRequest(
            entity: Task.entity(),
            sortDescriptors: [NSSortDescriptor(keyPath: \Task.dueDate, ascending: true)],
            predicate: NSPredicate(format: "category == %@", category)
        )
    }
    
    var body: some View {
        //lista zadan 
        List {
            ForEach(tasks) { task in
                HStack {
                    Text(task.title ?? "")
                    Spacer()
                    // ikona wykonania zadania po zaznaczeniu 
                    if task.isCompleted {
                        Image(systemName: "checkmark.circle")
                    }
                }
                //gest dotkniecia
                .contentShape(Rectangle())
                .onTapGesture {
                    withAnimation {
                        task.isCompleted.toggle()
                        saveContext() 
                    }
                }
                // gest do usuniecia zadania
                .swipeActions(edge: .trailing) {
                    Button(role: .destructive) {
                        deleteTask(task: task)
                    } label: {
                        Label("Usun", systemImage: "trash")
                    }
                }
                // gest do edycji zadania
                .swipeActions(edge: .leading) {
                    Button {
                        taskToEdit = task
                        showingEditTaskView = true
                    } label: {
                        Label("Edytuj", systemImage: "pencil")
                    }
                    .tint(.blue)
                }
            }
        }
    
        .navigationTitle(category.name ?? "")
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                NavigationLink(destination: AddTaskView(category: category)) {
                    Image(systemName: "plus")
                }
            }
        }
        //edycja zadania (widok typu sheet)
        .sheet(isPresented: $showingEditTaskView) {
            if let taskToEdit = taskToEdit {
                EditTaskView(task: taskToEdit)
            }
        }
    }
    
    // funkcja usuwajaca zadanie
    private func deleteTask(task: Task) {
        withAnimation {
            let context = task.managedObjectContext
            context?.delete(task)
            
            do {
                try context?.save()
            } catch {
                print("Wystapil problem podczas usuwania zadania: \(error.localizedDescription)")
            }
        }
    }
    
    // zapis zawartosci 
    private func saveContext() {
        do {
            try viewContext.save()
        } catch {
            print("Wystapil problem podczas zapisu: \(error.localizedDescription)")
        }
    }
}
