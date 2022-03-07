//
//  LetterViewController.swift
//  AgendaApp
//
//  Created by Angel Blanco on 6/3/22.
//

import UIKit

class LetterViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    @IBOutlet weak var pickerView: UIPickerView!
    
    private var fuentes = ["Copperplate", "Zapfino", "Thonburi", "Verdana", "TimesNewRomanPSMT", "TamilSangamMN"]
    
    @IBOutlet weak var txt_prueba: UILabel!
    
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return fuentes.count
    }
    

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return fuentes[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        txt_prueba.font = UIFont(name: fuentes[row], size: 26)
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.pickerView.delegate = self
        self.pickerView.dataSource = self
        // Do any additional setup after loading the view.
    }
    
    
    
    
    @IBAction func guardarLetra(_ sender: Any) {
        let fuente = txt_prueba.font.familyName
        
        
        let userDefault = UserDefaults.standard
        userDefault.set(fuente, forKey: "Fuente")

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
