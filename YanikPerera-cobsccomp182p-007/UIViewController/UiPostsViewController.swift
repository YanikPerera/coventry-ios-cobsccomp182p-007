//
//  UiPostsViewController.swift
//  YanikPerera-cobsccomp182p-007
//
//  Created by Yanik Perera on 2/25/20.
//  Copyright © 2020 Yanik Perera. All rights reserved.
//

import UIKit
import Firebase
import LocalAuthentication
import Nuke

class UiPostsViewController: UIViewController {
var posts: Event? = nil
    @IBOutlet weak var lblEventTitle: UILabel!
    @IBOutlet weak var lblEventSummery: UILabel!
    @IBOutlet weak var lblEventLocation: UILabel!
    @IBOutlet weak var lblEventDescription: UILabel!
    @IBOutlet weak var imgEventImage: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()

        if posts != nil{
            
            let url = URL(string: ((posts?.imageUrl)!))
            
            Nuke.loadImage(with: url!, into: imgEventImage)
            
            lblEventTitle.text = posts?.event_title
            lblEventDescription.text = posts?.description
            lblEventSummery.text = posts?.summery
            lblEventLocation.text = posts?.location
        }
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
