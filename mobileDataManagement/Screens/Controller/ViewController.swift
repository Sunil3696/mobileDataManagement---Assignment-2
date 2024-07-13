//
//  ViewController.swift
//  mobileDataManagement
//
//  Created by Sunil Balami on 2024-07-10.
//

import UIKit
import PhotosUI

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
    
    @IBOutlet weak var profileImageView: UIImageView!
    
    @IBOutlet weak var registerButton: UIButton!
    
    
    private let manager = DatabaseManager()
    private var imageSelected : Bool = false
    
    var movie :   MovieEntity?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configuration()
        // Do any additional setup after loading the view.
    }
    
    
    func   configuration(){
           addGesture()
        movieDetailConfiguration()
    }
    
    
    func addGesture ()
    {
        let imageTap = UITapGestureRecognizer(target: self, action: #selector(ViewController.openGallery ))
        profileImageView.addGestureRecognizer(imageTap)
    }
    
    
    func  movieDetailConfiguration(){
        if let movie {
            navigationItem.title = "Update Movie"
            registerButton.setTitle("Update", for: .normal )
            movieName.text = movie.title
            studio.text = movie.studio
            directors.text = movie.directors
            genre.text = movie.genres
            writersName.text = movie.writers
            actorName.text = movie.actors
            releasedYear.text = movie.year
            movieLength.text = movie.length
            descriptions.text = movie.shortDescriptions
            mpa.text = movie.mpaRating
            criticsRating.text = movie.criticsRating
            let  imageUrl  = URL.documentsDirectory.appending(components: movie.imageName ?? ""  ).appendingPathExtension("png")
            profileImageView.image = UIImage (contentsOfFile: imageUrl.path ?? "")
        }else {
            navigationItem.title = "Add Movie"
            registerButton.setTitle("Add Movie", for: .normal )
        }
    }
    
    
     
    @IBAction func submitMovie(_ sender: UIButton) {
        
        if !imageSelected {
            print("Image is not selected")
            return
            
        }
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
        let imageName = UUID().uuidString
        var newMovie = MovieModel(movieNames: movieNames,
                               studio: studio!,
                               directors: directors!,
                               writerName: writerName!,
                               actors: actors!,
                               releasedYear:releasedYear! ,
                               movieLength: movieLength!,
                               description: description!,
                               mpa: mpa!,
                               criticsRating: criticsRating!,
                               genre: genre!,
                               imageName: imageName
                             )
        
         
        if let movie {
            newMovie.imageName  = movie.imageName ?? ""
            
            
            manager.updateMovie(movie: newMovie, movieEntity: movie  )
            saveImageToDirectory(imageName: movie.imageName ?? "")
            updateshowAlert()
        }else {
            saveImageToDirectory(imageName: imageName)
            manager.addMovie(newMovie )
            
            showAlert()
        }
    }
    
    func  saveImageToDirectory   (imageName : String){
//        let fileURL = URL.documentsDirectory.appending(components: imageName).appendingPathExtension("png ")
        
        let fileURL =   URL.documentsDirectory.appending(components: imageName).appendingPathExtension("png")
        if let data = profileImageView.image?.pngData() {
            do {
               try data.write(to:  fileURL )
            }catch {
                print("Saving image to directory failed", error)
            }
        }
    }
    
    
    func showAlert() {
        let alertController = UIAlertController(title: nil, message: "Movie added", preferredStyle: .alert)
        let okay = UIAlertAction(title: "Okay", style: .default)
        alertController.addAction(okay)
        present(alertController, animated: true)
    }
    func updateshowAlert() {
        let alertController = UIAlertController(title: nil, message: "Movie record updated", preferredStyle: .alert)
        let okay = UIAlertAction(title: "Okay", style: .default)
        alertController.addAction(okay)
        present(alertController, animated: true)
    }
    
    @objc func openGallery() {
        var config = PHPickerConfiguration()
        config.selectionLimit = 1
        
        let pickerVC =   PHPickerViewController(configuration: config)
        pickerVC.delegate = self
        present(pickerVC, animated:  true)
        
    }

}

extension   ViewController : PHPickerViewControllerDelegate{
    func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
        dismiss(animated: true)
        for result in results {
            result.itemProvider.loadObject(ofClass:  UIImage.self) { image, error  in
                guard let image = image as? UIImage else {return}
                DispatchQueue.main.async {
                    self.profileImageView.image = image
                    self.imageSelected = true
                }
                
                
                
                
            }
        }
    }
}
