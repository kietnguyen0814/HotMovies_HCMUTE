//
//  ChoosePlacesViewController.swift
//  HotMovies_UTE
//
//  Created by Duy Bùi on 6/9/17.
//  Copyright © 2017 Kiet Nguyen. All rights reserved.
//

import UIKit
import Firebase
import MBProgressHUD

class ChoosePlacesViewController: UIViewController {
    
    
    @IBOutlet weak var btnA1: DesignButton!
    @IBOutlet weak var btnB7: DesignButton!
    @IBOutlet weak var btnB8: DesignButton!
    @IBOutlet weak var btnC2: DesignButton!
    
    @IBOutlet weak var btnC10: DesignButton!
    @IBOutlet weak var btnC9: DesignButton!
    @IBOutlet weak var btnC8: DesignButton!
    @IBOutlet weak var btnC7: DesignButton!
    @IBOutlet weak var btnC5: DesignButton!
    @IBOutlet weak var btnC4: DesignButton!
    @IBOutlet weak var btnC3: DesignButton!
    @IBOutlet weak var btnC1: DesignButton!
    @IBOutlet weak var btnB10: DesignButton!
    @IBOutlet weak var btnB9: DesignButton!
    @IBOutlet weak var btnB6: DesignButton!
    @IBOutlet weak var btnB5: DesignButton!
    @IBOutlet weak var btnB4: DesignButton!
    @IBOutlet weak var btnB2: DesignButton!
    @IBOutlet weak var btnB1: DesignButton!
    @IBOutlet weak var btnA10: DesignButton!
    @IBOutlet weak var btnA9: DesignButton!
    @IBOutlet weak var btnA8: DesignButton!
    @IBOutlet weak var btnA7: DesignButton!
    @IBOutlet weak var btnA6: DesignButton!
    @IBOutlet weak var btnA5: DesignButton!
    @IBOutlet weak var btnA4: DesignButton!
    @IBOutlet weak var btnA3: DesignButton!
    @IBOutlet weak var btnC6: DesignButton!
    @IBOutlet weak var btnB3: DesignButton!
    @IBOutlet weak var btnA2: DesignButton!
    
    var mDatabase: DatabaseReference!
    var filmInfo: FilmInfo!
    var time: String = ""
    var seats = [Seat]()
    var progressDialog: MBProgressHUD!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mDatabase = Database.database().reference()
        // Do any additional setup after loading the view.
        loadData()
    }
    
    func loadData() {
        //show progress
        showProgress()
        mDatabase.child("films").child(filmInfo.filmType).child(filmInfo.filmId).child("showTimes").child(time)
            .child("seat").observe(.childAdded, with: { (snapshot) in
                //hide progress
                self.hideProgress()
                let seatInfo = snapshot.value as? [String: AnyObject]
                let seatKey = snapshot.key
                //create object seat
                let bookBy = seatInfo?["bookBy"] as? String ?? ""
                let state = seatInfo?["state"] as? Bool ?? false
                let seat = Seat.init(bookBy: bookBy, state: state, seatName: seatKey)
                
                //add to list
                self.seats.append(seat)
                //hight light seat choosed
                for seatData in self.seats {
                    if seatData.seatName == "A1" {
                        let state: Bool = seatData.state
                        if (state) {
                            self.btnA1.isUserInteractionEnabled = false
                            self.btnA1.backgroundColor = UIColor.blue
                            self.btnA1.setTitleColor(UIColor.white, for: UIControlState.normal)
                        }
                    }
                    else if seatData.seatName == "A2" {
                        let state: Bool = seatData.state
                        if (state) {
                            self.btnA2.isUserInteractionEnabled = false
                            self.btnA2.backgroundColor = UIColor.blue
                            self.btnA2.setTitleColor(UIColor.white, for: UIControlState.normal)
                        }
                    }
                    else if seatData.seatName == "A3" {
                        let state: Bool = seatData.state
                        if (state) {
                            self.btnA3.isUserInteractionEnabled = false
                            self.btnA3.backgroundColor = UIColor.blue
                            self.btnA3.setTitleColor(UIColor.white, for: UIControlState.normal)
                        }
                    }
                    else if seatData.seatName == "A4" {
                        let state: Bool = seatData.state
                        if (state) {
                            self.btnA4.isUserInteractionEnabled = false
                            self.btnA4.backgroundColor = UIColor.blue
                            self.btnA4.setTitleColor(UIColor.white, for: UIControlState.normal)
                        }
                    }
                    else if seatData.seatName == "A5" {
                        let state: Bool = seatData.state
                        if (state) {
                            self.btnA5.isUserInteractionEnabled = false
                            self.btnA5.backgroundColor = UIColor.blue
                            self.btnA5.setTitleColor(UIColor.white, for: UIControlState.normal)
                        }
                    }
                    else if seatData.seatName == "A6" {
                        let state: Bool = seatData.state
                        if (state) {
                            self.btnA6.isUserInteractionEnabled = false
                            self.btnA6.backgroundColor = UIColor.blue
                            self.btnA6.setTitleColor(UIColor.white, for: UIControlState.normal)
                        }
                    }
                    else if seatData.seatName == "A7" {
                        let state: Bool = seatData.state
                        if (state) {
                            self.btnA7.isUserInteractionEnabled = false
                            self.btnA7.backgroundColor = UIColor.blue
                            self.btnA7.setTitleColor(UIColor.white, for: UIControlState.normal)
                        }
                    }
                    else if seatData.seatName == "A8" {
                        let state: Bool = seatData.state
                        if (state) {
                            self.btnA8.isUserInteractionEnabled = false
                            self.btnA8.backgroundColor = UIColor.blue
                            self.btnA8.setTitleColor(UIColor.white, for: UIControlState.normal)
                        }
                    }
                    else if seatData.seatName == "A9" {
                        let state: Bool = seatData.state
                        if (state) {
                            self.btnA9.isUserInteractionEnabled = false
                            self.btnA9.backgroundColor = UIColor.blue
                            self.btnA9.setTitleColor(UIColor.white, for: UIControlState.normal)
                        }
                    }
                    else if seatData.seatName == "A10" {
                        let state: Bool = seatData.state
                        if (state) {
                            self.btnA10.isUserInteractionEnabled = false
                            self.btnA10.backgroundColor = UIColor.blue
                            self.btnA10.setTitleColor(UIColor.white, for: UIControlState.normal)
                        }
                    }
                    else if seatData.seatName == "B1" {
                        let state: Bool = seatData.state
                        if (state) {
                            self.btnB1.isUserInteractionEnabled = false
                            self.btnB1.backgroundColor = UIColor.blue
                            self.btnB1.setTitleColor(UIColor.white, for: UIControlState.normal)
                        }
                    }
                    else if seatData.seatName == "B2" {
                        let state: Bool = seatData.state
                        if (state) {
                            self.btnB2.isUserInteractionEnabled = false
                            self.btnB2.backgroundColor = UIColor.blue
                            self.btnB2.setTitleColor(UIColor.white, for: UIControlState.normal)
                        }
                    }
                    else if seatData.seatName == "B3" {
                        let state: Bool = seatData.state
                        if (state) {
                            self.btnB3.isUserInteractionEnabled = false
                            self.btnB3.backgroundColor = UIColor.blue
                            self.btnB3.setTitleColor(UIColor.white, for: UIControlState.normal)
                        }
                    }
                    else if seatData.seatName == "B4" {
                        let state: Bool = seatData.state
                        if (state) {
                            self.btnB4.isUserInteractionEnabled = false
                            self.btnB4.backgroundColor = UIColor.blue
                            self.btnB4.setTitleColor(UIColor.white, for: UIControlState.normal)
                        }
                    }
                    else if seatData.seatName == "B5" {
                        let state: Bool = seatData.state
                        if (state) {
                            self.btnB5.isUserInteractionEnabled = false
                            self.btnB5.backgroundColor = UIColor.blue
                            self.btnB5.setTitleColor(UIColor.white, for: UIControlState.normal)
                        }
                    }
                    else if seatData.seatName == "B6" {
                        let state: Bool = seatData.state
                        if (state) {
                            self.btnB6.isUserInteractionEnabled = false
                            self.btnB6.backgroundColor = UIColor.blue
                            self.btnB6.setTitleColor(UIColor.white, for: UIControlState.normal)
                        }
                    }
                    else if seatData.seatName == "B7" {
                        let state: Bool = seatData.state
                        if (state) {
                            self.btnB7.isUserInteractionEnabled = false
                            self.btnB7.backgroundColor = UIColor.blue
                            self.btnB7.setTitleColor(UIColor.white, for: UIControlState.normal)
                        }
                    }
                    else if seatData.seatName == "B8" {
                        let state: Bool = seatData.state
                        if (state) {
                            self.btnB8.isUserInteractionEnabled = false
                            self.btnB8.backgroundColor = UIColor.blue
                            self.btnB8.setTitleColor(UIColor.white, for: UIControlState.normal)
                        }
                    }
                    else if seatData.seatName == "B9" {
                        let state: Bool = seatData.state
                        if (state) {
                            self.btnB9.isUserInteractionEnabled = false
                            self.btnB9.backgroundColor = UIColor.blue
                            self.btnB9.setTitleColor(UIColor.white, for: UIControlState.normal)
                        }
                    }
                    else if seatData.seatName == "B10" {
                        let state: Bool = seatData.state
                        if (state) {
                            self.btnB10.isUserInteractionEnabled = false
                            self.btnB10.backgroundColor = UIColor.blue
                            self.btnB10.setTitleColor(UIColor.white, for: UIControlState.normal)
                        }
                    }
                    else if seatData.seatName == "C1" {
                        let state: Bool = seatData.state
                        if (state) {
                            self.btnC1.isUserInteractionEnabled = false
                            self.btnC1.backgroundColor = UIColor.blue
                            self.btnC1.setTitleColor(UIColor.white, for: UIControlState.normal)
                        }
                    }
                    else if seatData.seatName == "C2" {
                        let state: Bool = seatData.state
                        if (state) {
                            self.btnC2.isUserInteractionEnabled = false
                            self.btnC2.backgroundColor = UIColor.blue
                            self.btnC2.setTitleColor(UIColor.white, for: UIControlState.normal)
                        }
                    }
                    else if seatData.seatName == "C3" {
                        let state: Bool = seatData.state
                        if (state) {
                            self.btnC3.isUserInteractionEnabled = false
                            self.btnC3.backgroundColor = UIColor.blue
                            self.btnC3.setTitleColor(UIColor.white, for: UIControlState.normal)
                        }
                    }
                    else if seatData.seatName == "C4" {
                        let state: Bool = seatData.state
                        if (state) {
                            self.btnC4.isUserInteractionEnabled = false
                            self.btnC4.backgroundColor = UIColor.blue
                            self.btnC4.setTitleColor(UIColor.white, for: UIControlState.normal)
                        }
                    }
                    else if seatData.seatName == "C5" {
                        let state: Bool = seatData.state
                        if (state) {
                            self.btnC5.isUserInteractionEnabled = false
                            self.btnC5.backgroundColor = UIColor.blue
                            self.btnC5.setTitleColor(UIColor.white, for: UIControlState.normal)
                        }
                    }
                    else if seatData.seatName == "C6" {
                        let state: Bool = seatData.state
                        if (state) {
                            self.btnC6.isUserInteractionEnabled = false
                            self.btnC6.backgroundColor = UIColor.blue
                            self.btnC6.setTitleColor(UIColor.white, for: UIControlState.normal)
                        }
                    }
                    else if seatData.seatName == "C7" {
                        let state: Bool = seatData.state
                        if (state) {
                            self.btnC7.isUserInteractionEnabled = false
                            self.btnC7.backgroundColor = UIColor.blue
                            self.btnC7.setTitleColor(UIColor.white, for: UIControlState.normal)
                        }
                    }
                    else if seatData.seatName == "C8" {
                        let state: Bool = seatData.state
                        if (state) {
                            self.btnC8.isUserInteractionEnabled = false
                            self.btnC8.backgroundColor = UIColor.blue
                            self.btnC8.setTitleColor(UIColor.white, for: UIControlState.normal)
                        }
                    }
                    else if seatData.seatName == "C9" {
                        let state: Bool = seatData.state
                        if (state) {
                            self.btnC9.isUserInteractionEnabled = false
                            self.btnC9.backgroundColor = UIColor.blue
                            self.btnC9.setTitleColor(UIColor.white, for: UIControlState.normal)
                        }
                    }
                    else if seatData.seatName == "C10" {
                        let state: Bool = seatData.state
                        if (state) {
                            self.btnC10.isUserInteractionEnabled = false
                            self.btnC10.backgroundColor = UIColor.blue
                            self.btnC10.setTitleColor(UIColor.white, for: UIControlState.normal)
                        }
                    }
                    
                }
                
            })
    }
    
    func showProgress() {
        progressDialog = MBProgressHUD.showAdded(to: view, animated: true)
        progressDialog.mode = MBProgressHUDMode.indeterminate
        progressDialog.label.text = "Đang lấy thông tin ghế..."
    }
    
    func hideProgress() {
        progressDialog.hide(animated: true)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func btnA1Click(_ sender: Any) {
        self.btnA1.backgroundColor = UIColor.green
        self.btnA1.setTitleColor(UIColor.white, for: UIControlState.normal)
    }
    
    @IBAction func btnA2Click(_ sender: Any) {
    }
    
    @IBAction func btnB3Click(_ sender: Any) {
        self.btnB3.backgroundColor = UIColor.green
        self.btnB3.setTitleColor(UIColor.white, for: UIControlState.normal)
    }
    
    //event click hàng ghê C, từ C1 dến C10 có tag từ 21 đến 30
    @IBAction func btnCActionClick(_ sender: DesignButton) {
        if (sender.tag == 21){
            print("C1")
        }
        else if (sender.tag == 22) {
            
        }
        else if (sender.tag == 23) {
            print("C3")
        }
        else if (sender.tag == 24) {
            
        }
        else if (sender.tag == 25) {
            
        }
        else if (sender.tag == 26) {
            
        }
        else if (sender.tag == 27) {
            
        }
        else if (sender.tag == 28) {
            
        }
        else if (sender.tag == 29) {
            
        }
        else if (sender.tag == 30) {
            
        }
    }
    @IBOutlet weak var btnC6Click: DesignButton!
    
}
