//
//  UiTabHomeViewController.swift
//  YanikPerera-cobsccomp182p-007
//
//  Created by Yanik Perera on 2/20/20.
//  Copyright © 2020 Yanik Perera. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase

class UiTabHomeViewController: UIViewController{
   // @IBOutlet weak var tblTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
       // tblTableView.dataSource = self
        
      //  loadPosts()
       // setupElements()

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    func tableView(_ tblTableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    func tableView(_ tblTableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tblTableView.dequeueReusableCell(withIdentifier: "users", for: indexPath)
        
        cell.textLabel?.text = "\(indexPath.row)"
        cell.backgroundColor = UIColor.red
        return cell
        
    }

}
func setupElements(){
    
  // tblTableView.layer.backgroundColor = UIColor.clear.cgColor
  // view.addVerticalGradientLayer(topColor: primaryColor, bottomColor: secondaryColor)
}

func loadPosts(){
    Database.database().reference().child("firstname").observe(.childAdded) { (snapshot: DataSnapshot) in
        print(snapshot.value!)
    }
}




