//
//  EventsTableViewCell.swift
//  YanikPerera-cobsccomp182p-007
//
//  Created by Yanik Perera on 2/25/20.
//  Copyright © 2020 Yanik Perera. All rights reserved.
//

import UIKit
import Nuke


class EventsTableViewCell: UITableViewCell {

    @IBOutlet weak var imgEventCell: UIImageView!
    @IBOutlet weak var lblEventTitle: UILabel!
    @IBOutlet weak var lblEventDescription: UILabel!
    @IBOutlet weak var lblEventSummary: UILabel!
    @IBOutlet weak var lblEventLocation: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    func getData(post: Event)  {
        
        lblEventTitle.text = post.event_title
        lblEventDescription.text = post.description
        lblEventSummary.text = post.summery
        lblEventLocation.text = post.location
        
        let imgUrl = URL(string: post.imageUrl!)
        
        Nuke.loadImage(with: imgUrl!, into: imgEventCell)
        
    }
}
