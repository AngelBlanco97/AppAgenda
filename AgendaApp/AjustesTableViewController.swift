//
//  AjustesTableViewController.swift
//  AgendaApp
//
//  Created by Angel Blanco on 6/3/22.
//

import UIKit

class AjustesTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.backgroundColor = .systemGray6
    }
    
    var sections: [Secciones] = DataModel().obtenerSecciones()
    
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return sections.count
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sections[section].items.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CeldaAjustesTableViewCell") as! CeldaAjustesTableViewCell
        cell.iconimg.layer.cornerRadius = 8
        cell.iconimg.image = UIImage(systemName: sections[indexPath.section].items[indexPath.row].icon)
        cell.iconimg.tintColor = sections[indexPath.section].items[indexPath.row].colors
        cell.txt_Contenido.text = sections[indexPath.section].items[indexPath.row].title
        return cell
    }
    
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sections[section].cabecera
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = sections[indexPath.section].items[indexPath.row].controller
        if (vc == "SizeDetailViewController") {
            performSegue(withIdentifier: "sizeDetail", sender: nil)
        }
        
        if(vc == "SizeListadoViewController") {
            performSegue(withIdentifier: "sizeListado", sender: nil)
        }
        
        if(vc == "ColorLetterViewController") {
            performSegue(withIdentifier: "colorLetter", sender: nil)
        }
        
        if(vc == "LetterViewController") {
            performSegue(withIdentifier: "letter", sender: nil)
        }
        
        if(vc == "ThemeViewController") {
            performSegue(withIdentifier: "theme", sender: nil)
        }
    }
        
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "sizeDetail" {
        }
        
        if segue.identifier == "sizeListado" {
            
        }
    }

}
