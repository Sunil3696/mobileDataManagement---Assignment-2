//
//  DatabaseManager.swift
//  mobileDataManagement
//
//  Created by Sunil Balami on 2024-07-10.
//

import UIKit

struct MovieModel{
    let movieNames : String
    let studio : String
    let directors : String
    let writerName : String
    let actors : String
    let releasedYear : String
    let movieLength : String
    let description : String
    let mpa : String
    let criticsRating : String
    let genre : String
    
    
    
}

class DatabaseManager {
    func addMovie(_ movie : MovieModel) {
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        
       let movieEntity = MovieEntity(context: context)
        movieEntity.title = movie.movieNames
        movieEntity.studio = movie.studio
        movieEntity.directors = movie.directors
        movieEntity.writers = movie.writerName
        movieEntity.actors = movie.actors
        movieEntity.year = movie.releasedYear
        movieEntity.length = movie.movieLength
        movieEntity.shortDescriptions = movie.description
        movieEntity.mpaRating = movie.mpa
        movieEntity.criticsRating = movie.criticsRating
        movieEntity.genres = movie.genre
        
        
        do {
            try context.save()
        }catch {
            print("Movie can not be saved: ", error)
        }
    }
}
