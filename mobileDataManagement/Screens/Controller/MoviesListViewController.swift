//
//  MoviesListViewController.swift
//  mobileDataManagement
//
//  Created by Sunil Balami on 2024-07-11.
//

import UIKit

class MoviesListViewController: UIViewController {

    @IBOutlet weak var movieTableView: UITableView!
    
    private  var movies : [MovieEntity] =  []
    private let manager =   DatabaseManager()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        movies = manager.fetchMovies()
        movieTableView.reloadData()
    }
    

//    @IBAction func addMovieButton(_ sender: UIBarButtonItem) {
//        guard let  registerVC = self.storyboard?.instantiateViewController(withIdentifier: "RegisterViewController " ) as? RegisterViewController else {  return  }
//        navigationController?.pushViewController( registerVC, animated: true  )
//    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension MoviesListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        movies.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let  cell = tableView.dequeueReusableCell(withIdentifier: "cell") else {
            return UITableViewCell ()
        }
        let movies = movies[indexPath.row]
        
        
        var content = cell.defaultContentConfiguration()
        content.text  = (movies.title ?? " ")  + "  " + ( movies.criticsRating ?? " ") //title
        content.secondaryText =  (movies.actors ?? " ")
        let  imageUrl  = URL.documentsDirectory.appending(components: movies.imageName ?? ""  ).appendingPathExtension("png")
        content.image = UIImage (contentsOfFile: imageUrl.path ?? "")
        var imagePro = content.imageProperties
        imagePro.maximumSize = CGSize(width: 80, height: 80)
        content.imageProperties = imagePro

        cell.contentConfiguration = content
        return cell
    }
    
}
