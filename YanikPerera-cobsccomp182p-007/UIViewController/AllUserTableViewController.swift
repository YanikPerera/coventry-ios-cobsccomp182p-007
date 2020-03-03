//
//  AllUserTableViewController.swift
//  YanikPerera-cobsccomp182p-007
//
//  Created by Yanik Perera on 3/3/20.
//  Copyright © 2020 Yanik Perera. All rights reserved.
//

import UIKit
import FirebaseFirestore
import FirebaseAuth
import Firebase
import LocalAuthentication


class AllUserTableViewController: UIViewController {
    var eventList : [Event] = []
    var ref: DatabaseReference!
    var window: UIWindow?
     var refEvents: DatabaseReference!
    
    @IBOutlet weak var tblTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ref = Database.database().reference()
        
        tblTableView.dataSource = self
        tblTableView.delegate = self
        getData()
        // Do any additional setup after loading the view.
    }
    

    func getData(){
        let eventsRef = ref.child("events")
        
        eventsRef.observe(.value){ snapshot in
            for child in snapshot.children.allObjects as! [DataSnapshot] {
                
                let eventDic = child.value as! NSDictionary
                
                let event_title = eventDic["event_title"] as! String
                let description = eventDic["description"] as! String
                let location = eventDic["location"] as! String
                let imageUrl = eventDic["imageUrl"] as! String
                let summery = eventDic["summery"] as! String
                let post = Event(
                    event_title: event_title,
                    description: description,
                    summery: summery,
                    location: location,
                    
                    imageUrl: imageUrl
                )
                
                self.eventList.append(post)
                
                print(child)
            }
            
            self.tblTableView.reloadData()
            
            
        }
        
    }

}
extension AllUserTableViewController: UITableViewDataSource, UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return eventList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        
        let eventCell = tableView.dequeueReusableCell(withIdentifier: "cells", for: indexPath) as! AllUserTableViewCell
        
        eventCell.selectionStyle = .none
        
        eventCell.populateData(post: eventList[indexPath.row])
        
        
        return eventCell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 300
    }
    
}

