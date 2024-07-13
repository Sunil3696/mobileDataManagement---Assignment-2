//
//  MoviesListViewController.swift
//  mobileDataManagement
//
//  Created by Sunil Balami on 2024-07-11.
//

import UIKit

class MoviesListViewController: UIViewController {
    let csvParser = CSVParser()
    @IBOutlet weak var movieTableView: UITableView!
    
    private  var movies : [MovieEntity] =  []
    private let manager =   DatabaseManager()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        movieTableView.register(UINib(nibName: "MovieCell", bundle: nil), forCellReuseIdentifier: "MovieCell")
          
        // Do any additional setup after loading the view.
    }
    
   
    @IBAction func importBUttonpressed(_ sender: UIBarButtonItem) {
        if UserDefaults.standard.bool(forKey: "CSVImported") {
                   print("CSV data already imported.")
                   return
               }
               
               guard let url = Bundle.main.url(forResource: "movies", withExtension: "csv") else {
                   print("Failed to find the CSV file.")
                   return
               }
               importCSV(from: url)
               UserDefaults.standard.set(true, forKey: "CSVImported")
        
    }
    func importCSV(from url: URL) {
        do {
            let csvData = try String(contentsOf: url, encoding: .utf8)
            print("CSV data: \(csvData)")
            
            let csvParser = CSVParser()
            let moviesData = csvParser.parseCSV(csvData)
            print("Parsed data: \(moviesData)")
            
            for movieData in moviesData {
                let movie = MovieModel(
                    movieNames: movieData["titles"] ?? "",
                    studio: movieData["studio"] ?? "",
                    directors: movieData["directors"] ?? "",
                    writerName: movieData["writers"] ?? "",
                    actors: movieData["actors"] ?? "",
                    releasedYear: movieData["year"] ?? "",
                    movieLength: movieData["length"] ?? "",
                    description: movieData["shortDescription"] ?? "",
                    mpa: movieData["mpaRating"] ?? "",
                    criticsRating: movieData["criticsRating"] ?? "",
                    genre: movieData["genres"] ?? "",
                    imageName: movieData["imageName"] ?? ""
                )
                manager.addMovie(movie)
            }
            
            movies = manager.fetchMovies()
            movieTableView.reloadData()
            
        } catch {
            print("Failed to import CSV: \(error)")
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        movies = manager.fetchMovies()
        movieTableView.reloadData()
    }
    

//    @IBAction func addMovieButton(_ sender: UIBarButtonItem) {
//        guard let  registerVC = self.storyboard?.instantiateViewController(withIdentifier: "RegisterViewController " ) as? ViewController else {  return  }
//        navigationController?.pushViewController( registerVC, animated: true  )
//    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected   object to the new view controller.
    }
    */
    func  addUpdateMovieNavigation (movie : MovieEntity?  = nil  ){
        guard let  registerVC = self.storyboard?.instantiateViewController(withIdentifier: "RegisterViewController" ) as? ViewController else {  return  }
        registerVC.movie = movie
               navigationController?.pushViewController( registerVC, animated: true  )
    }

}



extension MoviesListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        movies.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let  cell = tableView.dequeueReusableCell(withIdentifier: "MovieCell") as? MovieCell  else {
            return UITableViewCell ()
        }
        let movies = movies[indexPath.row]  
        cell.movies = movies
        return cell
         
    }
    
}
extension MoviesListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let update =   UIContextualAction(style: .normal, title: "View/Update") {_,_,_ in
            self.addUpdateMovieNavigation(movie : self.movies[indexPath.row])
        }
        update.backgroundColor = .systemIndigo
        
        let delete = UIContextualAction(style: .destructive, title: "Delete") {_,_,_ in
            self.manager.deleteMovies(movieEntity: self.movies[indexPath.row ])
            self.movies.remove(at: indexPath.row)
            self.movieTableView.reloadData()
        }
        return UISwipeActionsConfiguration(actions: [update, delete]   )
    }
}



 
