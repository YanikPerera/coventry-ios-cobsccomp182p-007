//
//  AllUserTableViewCell.swift
//  YanikPerera-cobsccomp182p-007
//
//  Created by Yanik Perera on 3/3/20.
//  Copyright © 2020 Yanik Perera. All rights reserved.
//

import UIKit
import Nuke

class AllUserTableViewCell: UITableViewCell {
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblSummery: UILabel!
    @IBOutlet weak var lblLocation: UILabel!
    
    @IBOutlet weak var lblDescription: UILabel!
    
    @IBOutlet weak var lmgImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    func populateData(post: Event)  {
        
        lblTitle.text = post.event_title
        lblDescription.text = post.description
        lblSummery.text = post.summery
        lblLocation.text = post.location
        
        let imgUrl = URL(string: post.imageUrl!)
        
        Nuke.loadImage(with: imgUrl!, into: lmgImageView)
        
    }
}

