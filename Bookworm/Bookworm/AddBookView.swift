//
//  AddBookView.swift
//  Bookworm
//
//  Created by David Burghoff on 08.01.20.
//  Copyright © 2020 Daw33d. All rights reserved.
//

import SwiftUI

struct AddBookView: View {
    @Environment(\.managedObjectContext) var moc
    @Environment(\.presentationMode) var presentaitonMode

    @State private var title = ""
    @State private var author = ""
    @State private var rating = 3
    @State private var genre = "Unknown"
    @State private var review = ""

    let genres = ["Fantasy", "Horror", "Kids", "Mystery", "Poetry", "Romance", "Thriller"]

    var body: some View {
        NavigationView{
            Form{
                Section{
                    TextField("Name of book", text: $title)
                    TextField("Author's name", text: $author)
                    Picker("Genre", selection: $genre){
                        ForEach(genres, id: \.self){
                            Text($0)
                        }
                    }
                }
                Section{
                    RatingView(rating: $rating)
                    TextField("Write a Review", text: $review)
                }
                Section{
                    Button("Save"){
                        let newBook = Book(context: self.moc)
                        newBook.title = self.title
                        newBook.author = self.author
                        newBook.rating = Int16(self.rating)
                        newBook.genre = self.genre
                        newBook.review = self.review

                        try? self.moc.save()
                        self.presentaitonMode.wrappedValue.dismiss()

                    }
                }
            .navigationBarTitle(Text("Add Book"))
            }
        }
    }
}

struct AddBookView_Previews: PreviewProvider {
    static var previews: some View {
        AddBookView()
    }
}
