//
//  SizeDetailViewController.swift
//  AgendaApp
//
//  Created by Angel Blanco on 6/3/22.
//

import UIKit

class SizeDetailViewController: UIViewController {

    @IBOutlet weak var txt_prueba: UILabel!
    @IBOutlet weak var stepper: UIStepper!
    @IBOutlet weak var btn_guardar: UIButton!
    @IBOutlet weak var input_size: UITextField!
    
    
    private var valueSize: Int = 15
    
    override func viewDidLoad() {
        super.viewDidLoad()
        input_size.text = txt_prueba.font.pointSize.description
        txt_prueba.font = UIFont(name: "Arial", size: 15)
        stepper.value = 15
        stepper.maximumValue = 25
        
        // Do any additional setup after loading the view.
    }
   
    @IBAction func valuechanged(_ sender: UIStepper) {
        input_size.text = Int(sender.value).description
        self.valueSize = Int(sender.value)
        txt_prueba.font = UIFont(name: "Arial", size: CGFloat(Int(sender.value)))
    }
    
    
    @IBAction func guardar(_ sender: Any) {
        let userDefault = UserDefaults.standard
        userDefault.set(self.valueSize, forKey: "SizeDetail")
        self.navigationController?.popViewController(animated: true)
    }
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
