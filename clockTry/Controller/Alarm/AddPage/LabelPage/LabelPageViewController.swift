//
//  LabelPageViewController.swift
//  clockTry
//
//  Created by Hung-Ming Chen on 2022/8/15.
//

import UIKit

class LabelPageViewController: UIViewController {

    @IBOutlet weak var LabelPageLabel: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        LabelPageLabel.placeholder = "附註："
        LabelPageLabel.text = addPageValue.pageValue.labelText
        LabelPageLabel.clearButtonMode = .whileEditing
        LabelPageLabel.returnKeyType = .done
        LabelPageLabel.delegate = self
    }
}

extension LabelPageViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        addPageValue.pageValue.labelText = LabelPageLabel.text!
        
        self.view.endEditing(true)
        self.navigationController?.popViewController(animated: true)
        
        return true
    }
}
