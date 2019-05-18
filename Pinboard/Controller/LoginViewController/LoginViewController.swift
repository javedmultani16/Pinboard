//
//  LoginViewController.swift
//  App
//
//  Created by Javed Multani on 18/05/19.
//  Copyright © 2018 javedmultani16. All rights reserved.
//

import UIKit


class LoginViewController: UIViewController {
    
    @IBOutlet weak var imageViewRemember: UIImageView!
    @IBOutlet weak var textFieldEmail: UITextField!
    @IBOutlet weak var textFieldPassword: UITextField!
    var isRememeber = false
    @IBOutlet weak var buttonLogin: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
       
        ///APP_CONTEXT.appRootController = self.navigationController!
        self.navigationController?.setNavigationBarHidden (true, animated: false)
        self.buttonLogin.backgroundColor = APP_THEME_COLOR
        self.buttonLogin.layer.cornerRadius = 5.0
        self.buttonLogin.clipsToBounds = true
        
        //Set data if user set remember me previously
        let strRemember = HelperFunction.helper.FetchFromUserDefault(name: "isRemember")
        if strRemember == "check"{
            self.isRememeber = true
            self.textFieldEmail.text = HelperFunction.helper.FetchFromUserDefault(name: "email")
            self.textFieldPassword.text = HelperFunction.helper.FetchFromUserDefault(name: "password")
            self.imageViewRemember.image = UIImage(named: "check")
        }else{
            self.imageViewRemember.image = UIImage(named: "uncheck")
            self.isRememeber = false
            self.textFieldEmail.text = ""
            self.textFieldPassword.text = ""
        }
        
        // Do any additional setup after loading the view.
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
    
    @IBAction func buttonHandlerRememberMe(_ sender: Any) {
        if self.isRememeber{
            self.imageViewRemember.image = UIImage(named: "uncheck")
             HelperFunction.helper.storeInUserDefaultForKey(name: "isRemember", val: "uncheck")
        }else{
            self.imageViewRemember.image = UIImage(named: "check")
             HelperFunction.helper.storeInUserDefaultForKey(name: "isRemember", val: "check")
        }
        self.isRememeber = !self.isRememeber
       
        
    }
    @IBAction func buttonHandlerSignup(_ sender: Any) {
        let signupVC = UIStoryboard(name: "Pinboard", bundle:nil).instantiateViewController(withIdentifier: "SignupViewController") as! SignupViewController
        self.navigationController?.pushViewController(signupVC, animated: true)
   
    }
    @IBAction func buttonHandlerLogin(_ sender: Any) {
        let homeVC = UIStoryboard(name: "Pinboard", bundle:nil).instantiateViewController(withIdentifier: "PinboardPinsViewController") as! PinboardPinsViewController
        self.navigationController?.pushViewController(homeVC, animated: true)
        
    }
    
    
}
