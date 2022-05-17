//
//  DetailView.swift
//  Bookworm
//
//  Created by Lucas Chae on 5/17/22.
//

import SwiftUI

struct DetailView: View {
    
    let book: Book
    
    // hold our Core Data managed object context
    // Managed objects must be created inside a managed object context.
    @Environment(\.managedObjectContext) var managedObjectContext
    // hold our dismiss action
    @Environment(\.dismiss) var dismiss
    
    @State private var deleteAlert = false
    
    var body: some View {
        ScrollView {
            ZStack {
                Text(book.genre ?? "Fantasy")
                    .font(.caption)
                    .fontWeight(.black)
                    .padding(8)
                    .foregroundColor(.white)
                    .background(.black.opacity(0.75))
                    .clipShape(Capsule())
                    .offset(x: -5, y: -5)
            }
            
            Text(book.author ?? "Unknown author")
                .font(.title)
                .foregroundColor(.secondary)
            Text(book.review ?? "No review")
                .padding()
            RatingView(rating: .constant(Int(book.rating)))
        }
        .navigationTitle(book.title ?? "Unknown book")
        .navigationBarTitleDisplayMode(.inline)
        .alert("Delete book?", isPresented: $deleteAlert) {
            Button("Delete", role: .destructive, action: deleteBook)
            Button("Cancel", role: .cancel) { }
        } message: {
            Text("Are you sure?")
        }
        .toolbar {
            Button {
                deleteAlert = true
            } label: {
                Label("Delete this book", systemImage: "trash")
            }
        }
    }
    
    func deleteBook() {
        // We should call the delete() method on a managed object context instead.
        managedObjectContext.delete(book)
    }
}

