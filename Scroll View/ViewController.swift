//
//  ViewController.swift
//  Scroll View
//
//  Created by Evgeniy Ryshkov on 04/10/2018.
//  Copyright © 2018 Evgeniy Ryshkov. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var scrollView: UIScrollView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        registerForNotifications()

    }

    func registerForNotifications() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyBoardWasShawn(_:)), name: UIResponder.keyboardDidShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyBoardWasShawn(_:)), name: UIResponder.keyboardDidShowNotification, object: nil)
    }

    @objc func keyBoardWasShawn(_ notification: NSNotification) {
        let heightDifference: CGFloat = 3
        
        guard let info = notification.userInfo, let keyboardFrameValue = info[UIResponder.keyboardFrameBeginUserInfoKey] as? NSValue else { return }
        
        let keyboardFrame = keyboardFrameValue.cgRectValue
        let keyboardSize = keyboardFrame.size
        
        let contentInsets = UIEdgeInsets(top: 0, left: 0, bottom: keyboardSize.height + heightDifference, right: 0)
        
        scrollView.contentInset = contentInsets
        scrollView.scrollIndicatorInsets = contentInsets
    }
    
    @objc func keyBoardWillBeHidden(_ notification: NSNotification) {
        let contentInsets = UIEdgeInsets.zero
        
        scrollView.contentInset = contentInsets
        scrollView.scrollIndicatorInsets = contentInsets
    }
    
}

