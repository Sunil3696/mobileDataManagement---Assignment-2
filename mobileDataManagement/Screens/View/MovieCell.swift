//
//  MovieCell.swift
//  mobileDataManagement
//
//  Created by Sunil Balami on 2024-07-12.
//

import UIKit

class  MovieCell : UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var criticsRating: UILabel!
    
    
    @IBOutlet weak var studios: UILabel!
    
    @IBOutlet weak var profileimageView: UIImageView!
    
    var movies : MovieEntity?{
        didSet{
              movieConfiguration()
        }
    
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func movieConfiguration(){
        guard let   movies else {return  }
        titleLabel.text  = (movies.title ?? " ")  /*+ "  " + ( movies.criticsRating ?? " ")*/ //title
        criticsRating.text =  "Studio: \(movies.studio ?? " ")"
        studios.text =  "Critics Ratings: \(movies.criticsRating ?? " ")"
        let  imageUrl  = URL.documentsDirectory.appending(components: movies.imageName ?? ""  ).appendingPathExtension("png")
        profileimageView.image = UIImage (contentsOfFile: imageUrl.path ?? "")
          
 
    }
    
}
