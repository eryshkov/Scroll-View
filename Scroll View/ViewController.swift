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
        delegateAllTextFields()
        hideKeyboard()

    }
    
    func registerForNotifications() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyBoardWasShawn(_:)), name: UIResponder.keyboardDidShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyBoardDidHidden(_:)), name: UIResponder.keyboardDidHideNotification, object: nil)
    }

    @objc func keyBoardWasShawn(_ notification: NSNotification) {
//        print("\(#function) executed")
        let heightDifference: CGFloat = 5
        
        guard let info = notification.userInfo, let keyboardFrameValue = info[UIResponder.keyboardFrameBeginUserInfoKey] as? NSValue else { return }
        
        let keyboardFrame = keyboardFrameValue.cgRectValue
        let keyboardSize = keyboardFrame.size
        
        let contentInsets = UIEdgeInsets(top: 0, left: 0, bottom: keyboardSize.height + heightDifference, right: 0)
        
        scrollView.contentInset = contentInsets
        scrollView.scrollIndicatorInsets = contentInsets
    }
    
    @objc func keyBoardDidHidden(_ notification: NSNotification) {
//        print("\(#function) executed")
        let contentInsets = UIEdgeInsets.zero
        
        scrollView.contentInset = contentInsets
        scrollView.scrollIndicatorInsets = contentInsets
    }
    
}

// MARK: - Hides keyboard on RETURN Button
extension ViewController: UITextFieldDelegate{
    // Hides keyboard on RETURN Button
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
//        print("\(#function) executed")
        textField.resignFirstResponder()
        return true
    }
    
    func delegateAllTextFields() { //Must call in the viewDidLoad() for example
        for someView in getAllSubviews(rootView: scrollView) {
            if let someTextField = someView as? UITextField {
                someTextField.delegate = self
//                print("Text field detected")
            }
        }
    }
    
    func getAllSubviews(rootView: UIView) -> [UIView] {
        
        var flatArray: [UIView] = []
        flatArray.append(rootView)
        
        for subview in rootView.subviews {
            flatArray += getAllSubviews(rootView: subview)
        }
        return flatArray
    }
}

// MARK: - Hides Keyboard on Touch Outside
extension UIViewController { // Hides keyboard on Touch Outside Tap
    func hideKeyboard() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}
