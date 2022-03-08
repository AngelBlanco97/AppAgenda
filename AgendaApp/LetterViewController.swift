//
//  LetterViewController.swift
//  AgendaApp
//
//  Created by Angel Blanco on 6/3/22.
//

import UIKit

class LetterViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    @IBOutlet weak var pickerView: UIPickerView!
    public let userDefault = UserDefaults.standard
    public var fuenteActual = "Verdana"
    
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
        txt_prueba.text = fuentes[row]
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.pickerView.delegate = self
        self.pickerView.dataSource = self
        setLetter()
        // Do any additional setup after loading the view.
    }
    
    func setLetter() {
        guard let font = userDefault.object(forKey: "Fuente") as? String else {return}
        self.fuenteActual = font
        txt_prueba.text = font
    }
    
    
    
    @IBAction func guardarLetra(_ sender: Any) {
        let fuente = txt_prueba.font.familyName
        userDefault.set(fuente, forKey: "Fuente")
        self.fuenteActual = fuente

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
