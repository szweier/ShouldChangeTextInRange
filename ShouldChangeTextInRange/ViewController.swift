//
//  ViewController.swift
//  ShouldChangeTextInRange
//
//  Created by Steven Zweier on 3/24/19.
//  Copyright © 2019 Steven Zweier. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    var textBasedOnShouldChangeTextIn = ""
    private let textView = UITextView()
    private let validate = UIButton()
    private let reset = UIButton()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        validate.backgroundColor = .blue
        view.addSubview(validate)
        validate.setTitle("Validate", for: .normal)
        validate.addTarget(self, action: #selector(validateText), for: .touchUpInside)
        
        reset.backgroundColor = .red
        view.addSubview(reset)
        reset.setTitle("Reset", for: .normal)
        reset.addTarget(self, action: #selector(resetText), for: .touchUpInside)
        
        textView.delegate = self
        view.addSubview(textView)
        textView.becomeFirstResponder()
        
        let stack = UIStackView(arrangedSubviews: [validate, reset, textView])
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .vertical
        stack.spacing = 10
        view.addSubview(stack)
        stack.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        stack.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        stack.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        stack.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
    }
    
    private var validated: String {
        if textView.text == textBasedOnShouldChangeTextIn {
            return "They match!"
        }
        return "These do not match"
    }
    
    @objc private func resetText() {
        textView.text = ""
        textBasedOnShouldChangeTextIn = ""
    }
    
    @objc private func validateText() {
        let alert = UIAlertController(title: "Validation",
                                      message: """
TextView.text = \(textView.text ?? "")\n
Text from shouldChangeTextIn = \(textBasedOnShouldChangeTextIn)\n
\(validated)
""", preferredStyle: .alert)
        alert.addAction(.init(title: "Dismiss", style: .default, handler: { [weak self] _ in
            self?.dismiss(animated: true, completion: nil)
        }))
        present(alert, animated: true, completion: nil)
    }
}

extension ViewController: UITextViewDelegate {
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        textBasedOnShouldChangeTextIn = String((textBasedOnShouldChangeTextIn as NSString).replacingCharacters(in: range, with: text))
        return true
    }
}

