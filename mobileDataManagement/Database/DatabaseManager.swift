//
//  DatabaseManager.swift
//  mobileDataManagement
//
//  Created by Sunil Balami on 2024-07-10.
//
import UIKit
import CoreData

 

class DatabaseManager {
    private var  context : NSManagedObjectContext{
        return (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    }
    
    func   addMovie(_ movie : MovieModel) {
        
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
        movieEntity.imageName =  movie.imageName
        
        
        do {
            try context.save()
        }catch {
            print("Movie can not be saved: ", error)
        }
    }
    
    func  fetchMovies() -> [MovieEntity ]{
        var movies : [MovieEntity] = []
        do {
            movies =  try   context.fetch(MovieEntity.fetchRequest()  )
        }catch {
            print("Movie Fetch Error", error)
        }
        
        return movies
    }
}
