//
//  DetailView.swift
//  Bookworm
//
//  Created by David Burghoff on 08.01.20.
//  Copyright © 2020 Daw33d. All rights reserved.
//

import CoreData
import SwiftUI

struct DetailView: View {
    @Environment(\.managedObjectContext) var moc
    @Environment(\.presentationMode) var presentationMode
    @State private var showingDeleteAlert = false
    let book: Book

    var body: some View {
        GeometryReader {geometry in
            VStack{
                ZStack(alignment: .bottomTrailing) {
                    Image(self.book.genre ?? "Unknown")
                        .frame(maxWidth: geometry.size.width)

                    Text(self.book.genre ?? "Fantasy")
                        .font(.caption)
                        .fontWeight(.black)
                        .padding()
                        .foregroundColor(.white)
                        .background(Color.black.opacity(0.75))
                        .clipShape(Capsule())
                        .offset(x: -5, y: -5)
                }

                Text(self.book.author ?? "Unknown Author")
                    .font(.title)
                    .foregroundColor(.secondary)

                Text(self.book.review ?? "No Review")
                .padding()
                RatingView(rating: .constant(Int(self.book.rating)))
                    .font(.largeTitle)

                Spacer()
            }
        }
        .navigationBarTitle(Text(self.book.title ?? "Unknown Book"), displayMode: .inline)
        .alert(isPresented: $showingDeleteAlert){
            Alert(title: Text("Delete Book"), message: Text("Are you sure?"), primaryButton: .destructive(Text("Delete")) {
                self.deleteBook()
                }, secondaryButton: .cancel()
            )
        }
        .navigationBarItems(trailing: Button(action: {
            self.showingDeleteAlert = true
        }){
            Image(systemName: "trash")
        })
    }
    func deleteBook() {
        moc.delete(book)

        try? self.moc.save()
        presentationMode.wrappedValue.dismiss()
    }
}

struct DetailView_Previews: PreviewProvider {
    static let moc = NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType)
    static var previews: some View {
        let book = Book(context: moc)
        book.title = "testTitle"
        book.author = "Test Author"
        book.genre = "Fantasy"
        book.rating = 4
        book.review = "This is agreat book I really enjoyed it"
        return NavigationView {
            DetailView(book: book)
        }
    }
}
