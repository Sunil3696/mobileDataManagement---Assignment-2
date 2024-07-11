//
//  ViewController.swift
//  mobileDataManagement
//
//  Created by Sunil Balami on 2024-07-10.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var movieName: UITextField!
    
    @IBOutlet weak var studio: UITextField!
    
    
    @IBOutlet weak var directors: UITextField!
    
    @IBOutlet weak var genre: UITextField!
    
    @IBOutlet weak var writersName: UITextField!
    
    @IBOutlet weak var actorName: UITextField!
    
    @IBOutlet weak var releasedYear: UITextField!
    
    @IBOutlet weak var movieLength: UITextField!
    
    @IBOutlet weak var descriptions: UITextField!
    
    @IBOutlet weak var mpa: UITextField!
    
    @IBOutlet weak var criticsRating: UITextField!
    
    
    private let manager = DatabaseManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func submitMovie(_ sender: UIButton) {
        var movieNames = movieName.text!;
        var studio = studio.text;
        var directors = directors.text;
        var genre = genre.text;
        var writerName = writersName.text;
        var actors = actorName.text;
        var releasedYear = releasedYear.text;
        var movieLength = movieLength.text;
        var  description = descriptions.text;
        var mpa = mpa.text;
        var criticsRating = criticsRating.text;
        
        print(movieNames)
        print(studio!)
        print(directors!)
        
        let movie = MovieModel(movieNames: movieNames,
                               studio: studio!,
                               directors: directors!,
                               writerName: writerName!,
                               actors: actors!,
                               releasedYear:releasedYear! ,
                               movieLength: movieLength!,
                               description: description!,
                               mpa: mpa!,
                               criticsRating: criticsRating!,
                               genre: genre!)
        
        manager.addMovie(movie)
    
        
    }
}
