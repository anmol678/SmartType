//
//  ExampleVC.swift
//  SmartType
//
//  Created by Anmol Jain on 5/11/23.
//

import UIKit
import SwiftUI

class ExampleVC: UIViewController, UITextViewDelegate {
    
    var keyboardButtons: [CYRKeyboardButton] = []
    var numberView: UIInputView!
    var textView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Instantiate and configure the textView
        self.textView = UITextView(frame: self.view.bounds)
        self.textView.delegate = self
        self.view.addSubview(self.textView)
        
        let keys = ["1", "2", "3", "4", "5", "6", "7", "8", "9", "0"]
        
        self.numberView = UIInputView(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: 45), inputViewStyle: .keyboard)
        
        for keyString in keys {
            let keyboardButton = CYRKeyboardButton()
            keyboardButton.translatesAutoresizingMaskIntoConstraints = false
            keyboardButton.input = keyString
            keyboardButton.inputOptions = ["A", "B", "C", "D"]
            keyboardButton.textInput = self.textView
            self.numberView.addSubview(keyboardButton)

            self.keyboardButtons.append(keyboardButton)
        }
    
//        if let orientation = self.view.window?.windowScene?.interfaceOrientation {
//            updateConstraintsForOrientation(orientation: orientation)
//        }
        updateConstraintsForOrientation(orientation: self.interfaceOrientation)

        self.textView.inputAccessoryView = self.numberView
//
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    override func willRotate(to toInterfaceOrientation: UIInterfaceOrientation, duration: TimeInterval) {
        updateConstraintsForOrientation(orientation: toInterfaceOrientation)
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    func updateConstraintsForOrientation(orientation: UIInterfaceOrientation) {
        // Remove any existing constraints
        for constraint in self.numberView.constraints {
            self.numberView.removeConstraint(constraint)
        }

        var bindings: [String: Any] = [:]
        var visualFormatConstants: String = ""
        var metrics: [String: Any] = [:]

        // Setup our metrics based on orientation
        if orientation.isPortrait {
            metrics = [
                "margin" : 3,
                "spacing" : 6
            ]
        } else {
            metrics = [
                "margin" : 22,
                "spacing" : 5
            ]
        }

        // Build the visual format string
        for (index, button) in self.keyboardButtons.enumerated() {
            let binding = "keyboardButton\(index)"
            bindings[binding] = button

            if index == 0 {
                visualFormatConstants += "H:|-margin-[\(binding)]"
            } else if index < self.keyboardButtons.count - 1 {
                visualFormatConstants += "-spacing-[\(binding)]"
            } else {
                visualFormatConstants += "-spacing-[\(binding)]-margin-|"
            }
        }

        // Apply horizontal constraints
        let horizontalConstraints = NSLayoutConstraint.constraints(withVisualFormat: visualFormatConstants, options: [], metrics: metrics, views: bindings)
        self.numberView.addConstraints(horizontalConstraints)

        // Apply vertical constraints
        for (binding, _) in bindings {
            let format = "V:|-6-[\(binding)]|"
            let verticalConstraints = NSLayoutConstraint.constraints(withVisualFormat: format, options: [], metrics: nil, views: bindings)
            self.numberView.addConstraints(verticalConstraints)
        }

        // Add width constraint
        for (index, button) in self.keyboardButtons.enumerated() {
            if index > 0 {
                let previousButton = self.keyboardButtons[index - 1]
                let widthConstraint = NSLayoutConstraint(item: button, attribute: .width, relatedBy: .equal, toItem: previousButton, attribute: .width, multiplier: 1, constant: 0)
                self.numberView.addConstraint(widthConstraint)
            }
        }
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: textView, action: #selector(resignFirstResponder))
        self.navigationItem.setRightBarButton(doneButton, animated: true)
    }

    func textViewDidEndEditing(_ textView: UITextView) {
        self.navigationItem.setRightBarButton(nil, animated: true)
    }

    @objc func keyboardWillShow(notification: NSNotification) {
        if self.textView.isFirstResponder {
            let info = notification.userInfo!
            let kbSize: CGSize = (info[UIResponder.keyboardFrameBeginUserInfoKey] as! NSValue).cgRectValue.size
            let duration: Double = info[UIResponder.keyboardAnimationDurationUserInfoKey] as! Double

            UIView.animate(withDuration: duration) {
                self.textView.contentInset = UIEdgeInsets(top: self.textView.contentInset.top, left: self.textView.contentInset.left, bottom: kbSize.height, right: 0)
                self.textView.scrollIndicatorInsets = UIEdgeInsets(top: self.textView.contentInset.top, left: self.textView.contentInset.left, bottom: kbSize.height, right: 0)
            }
        }
    }

    @objc func keyboardWillHide(notification: NSNotification) {
        if self.textView.isFirstResponder {
            let info = notification.userInfo!
            let duration: Double = info[UIResponder.keyboardAnimationDurationUserInfoKey] as! Double

            UIView.animate(withDuration: duration) {
                self.textView.contentInset = UIEdgeInsets(top: self.textView.contentInset.top, left: self.textView.contentInset.left, bottom: 0, right: 0)
                self.textView.scrollIndicatorInsets = UIEdgeInsets(top: self.textView.contentInset.top, left: self.textView.contentInset.left, bottom: 0, right: 0)
            }
        }
    }
}

