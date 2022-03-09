//
//  AjustesTableViewController.swift
//  AgendaApp
//
//  Created by Angel Blanco on 6/3/22.
//

import UIKit

class AjustesTableViewController: UITableViewController {

    //MARK: VIEW
    /*
     Cuando ha cargado la vista seteamos el color del fondo.
     */
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.backgroundColor = .systemGray6
    }
    
    //MARK: VARIABLES
    var sections: [Secciones] = DataModel().obtenerSecciones()
    
    
    /*
     Devolvemos la cantidad de secciones que queremos mostraar de la tabla, en este caso lo recogemos del modelo de datos "Secciones". En ese archivo encontraremos 4 secciones diferentes. (Tamaño, letra, color, y tema)
     */
    override func numberOfSections(in tableView: UITableView) -> Int {
        return sections.count
    }
    
    /*
     Recogemos la cantidad de items que hay por sección para asignarlo al numero de filas por sección.(En cada sección hay un solo apartado, salvo en el caso de tamaño, que usa dos filas.
     */
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sections[section].items.count
    }
    
    /*
     Seteamos una celda de estilo propia y le asignamos los valores que hay dentro del modelo de datos
     */
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CeldaAjustesTableViewCell") as! CeldaAjustesTableViewCell
        cell.iconimg.layer.cornerRadius = 8
        cell.iconimg.image = UIImage(systemName: sections[indexPath.section].items[indexPath.row].icon)
        cell.iconimg.tintColor = sections[indexPath.section].items[indexPath.row].colors
        cell.txt_Contenido.text = sections[indexPath.section].items[indexPath.row].title
        return cell
    }
    
    /*
     Ponemos titulo a la sección, encontrada en el modelo de datos como cabecera.
     */
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sections[section].cabecera
    }
    
    /*
     Controlamos la navegación dependiendo del item que haya clickado el usuario. Según la fila que haya pulsado, hay un dato en el de controlador propio, al que comprobamos el valor para poderse iniciar esa vista por medio de segues activados en el main. 
     */
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
}
