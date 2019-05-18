//
//  Global.swift
//  PinboardPins
//
//  Created by javedmultani16 on 17/05/19.
//  Copyright © 2019 javedmultani16. All rights reserved.
//

import UIKit
import SwiftMessages



public let APP_THEME_COLOR :UIColor = COLOR_CUSTOM(117, 30,208,1)


public func displaySuccessMessage(message: String) {
    
    let success = MessageView.viewFromNib(layout: .cardView)
    success.configureTheme(.success)
    success.configureDropShadow()
    success.configureContent(title: "Success", body: message)
    success.button?.isHidden = true
    
    var successConfig = SwiftMessages.defaultConfig
    successConfig.presentationStyle = .bottom
    successConfig.duration = .seconds(seconds: 3.0)
    successConfig.presentationContext = .window(windowLevel: UIWindow.Level.normal)
    
    SwiftMessages.show(config: successConfig, view: success)
}

public func displayAlertWarning(message: String) {
    
    let warning = MessageView.viewFromNib(layout: .cardView)
    warning.configureTheme(.warning)
    warning.configureDropShadow()
    warning.configureContent(title: "Alert", body: message)
    warning.button?.isHidden = true
    
    var warningConfig = SwiftMessages.defaultConfig
    warningConfig.presentationStyle = .top
    warningConfig.duration = .seconds(seconds: 3.0)
    warningConfig.presentationContext = .window(windowLevel: UIWindow.Level.alert)
    
    SwiftMessages.show(config: warningConfig, view: warning)
}

public func displayErrorMessage(_ message: String) {
    
    let status = MessageView.viewFromNib(layout: .statusLine)
    status.backgroundView.backgroundColor = UIColor.black
    status.bodyLabel?.textColor = UIColor.white
    status.configureContent(body: message)
    var statusConfig = SwiftMessages.defaultConfig
    statusConfig.duration = .seconds(seconds: 05.0)
    statusConfig.presentationContext = .window(windowLevel: UIWindow.Level.statusBar)
    
    SwiftMessages.show(config: statusConfig, view: status)
}


func configureView(radius: CGFloat, backgroundColor: UIColor, shadowColor: CGColor, shadowOffset: CGSize, opacity: Float, view: UIView) {
    
    view.backgroundColor = backgroundColor
    view.layer.cornerRadius = radius
    view.layer.masksToBounds = false
    view.layer.shadowColor = shadowColor
    view.layer.shadowOffset = shadowOffset
    view.layer.shadowOpacity = opacity
}

func applyCornerRadiusToImageView(radius: CGFloat, imageView: UIImageView) {
    imageView.layer.cornerRadius = radius
    imageView.layer.masksToBounds = true
}
 func COLOR_CUSTOM(_ Red: Float, _ Green: Float , _ Blue: Float, _ Alpha: Float) -> UIColor {
    return  UIColor (red:  CGFloat(Red)/255.0, green: CGFloat(Green)/255.0, blue: CGFloat(Blue)/255.0, alpha: CGFloat(Alpha))
}


let serverTime : DateFormatter = {
    let dateFormater = DateFormatter()
    dateFormater.locale = Locale(identifier: "en_US_POSIX")
    dateFormater.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZZZZZ"
    dateFormater.timeZone = TimeZone(secondsFromGMT: 0)
    return dateFormater
}()


// Can Add More Globals Here
