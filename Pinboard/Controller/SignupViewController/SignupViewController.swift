//
//  SignupViewController.swift
//  App
//
//  Created by Javed Multani on 18/05/19.
//  Copyright © 2018 javedmultani16. All rights reserved.
//

import UIKit


class SignupViewController: UIViewController {

    @IBOutlet weak var textFieldFirstName: UITextField!
    @IBOutlet weak var textFieldLastName: UITextField!
    @IBOutlet weak var textFieldEmail: UITextField!
    @IBOutlet weak var textFieldPassword: UITextField!
    @IBOutlet weak var textFieldMobile: UITextField!
    @IBOutlet weak var buttonGender: UIButton!
    @IBOutlet weak var buttonSignup: UIButton!
    
    var selectedGender = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        self.buttonGender.setTitle("Select Gender", for: .normal)
        self.buttonSignup.layer.cornerRadius = 5.0
        self.buttonSignup.clipsToBounds = true
        self.buttonSignup.backgroundColor = APP_THEME_COLOR
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
      self.navigationController?.navigationBar.isHidden = true
    }
    //MARK: - button action
    @IBAction func buttonHandlerSignup(_ sender: Any) {
      self.navigationController?.popViewController(animated: true)
    }
    //this button action handle gender selection
    @IBAction func buttonHandlerGender(_ sender: Any) {
    }
    //go back to login screen
    @IBAction func buttonHandlerSignin(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
   
}
