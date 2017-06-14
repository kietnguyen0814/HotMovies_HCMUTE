//
//  HistoryTableViewController.swift
//  HotMovies_UTE
//
//  Created by Cntt03 on 6/14/17.
//  Copyright © 2017 Kiet Nguyen. All rights reserved.
//

import UIKit
import Firebase
import MBProgressHUD

class HistoryTableViewController: UITableViewController {
    
    var mDatabase: DatabaseReference!
    var histories = [History]()
    var progressDialog: MBProgressHUD!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mDatabase = Database.database().reference()
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        loadData()
    }
    
    func loadData() {
        showProgress()
        mDatabase.child("users").child(getUid()).child("booked").observe(.childAdded, with: { (snapshot) -> Void in
            let dataBookFb = snapshot.value as? [String: AnyObject]
            //get data
            let filmId = dataBookFb!["filmId"] as? String ?? ""
            let filmType = dataBookFb!["filmType"] as? String ?? ""
            let money = dataBookFb!["price"] as? Int64 ?? 0
            let seats = dataBookFb!["seat"] as? [String] ?? []
            let showTime = dataBookFb!["showTime"] as? String ?? ""
            let timestamp = dataBookFb?["timestamp"] as? String ?? ""
            //call firebase to get filmInfo
            self.mDatabase.child("films").child(filmType).child(filmId).child("filmInfo").observeSingleEvent(of: .value, with: { (snapshotInfo) in
                let dataFilmInfo = snapshotInfo.value as? [String: AnyObject]
                let filmTitle = dataFilmInfo!["filmName"] as? String ?? ""
                let releaseDay = dataFilmInfo!["openningDay"] as? String ?? ""
                //save into class
                var chairName: String = ""
                //get name of chair
                for chair in seats {
                    chairName += chair + ". "
                }
                let history: History = History(releaseDay: releaseDay, movieTitle: filmTitle, money: money, location: chairName, numberOfChair: seats.count, showTime: showTime, bookDay: timestamp)
                //save into class
                self.histories.append(history)
               // DispatchQueue.main.sync {
                    self.hideProgress()
                    self.tableView.reloadData()
                    
              //  }
                
                
            }) { (error) in
                print(error.localizedDescription)
            }
            
        })
    }
    
    func showProgress() {
        progressDialog = MBProgressHUD.showAdded(to: view, animated: true)
        progressDialog.mode = MBProgressHUDMode.indeterminate
        progressDialog.label.text = "Đang tải..."
    }
    
    func hideProgress() {
        progressDialog.hide(animated: true)
    }
    
    func getUid() -> String {
        return (Auth.auth().currentUser?.uid)!
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return histories.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "History", for: indexPath) as! HistoryTableViewCell
        let history = histories[indexPath.row]
         cell.configWithCell(history: history)
        return cell
        
    }
    
    
    @IBAction func closeClick(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
}
