//
//  ViewControllerHome.swift
//  PasswordManager
//
//  Created by Tardes on 13/1/25.
//

import UIKit
import FirebaseFirestore





class ViewControllerHome: UIViewController,UITableViewDelegate, UITableViewDataSource {
    
    
    @IBOutlet weak var tableView: UITableView!
    
   
    
    let db = Firestore.firestore()
    var listaRegistros: [Registro] = []
    var userLogin: String = ""

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("se ha logado el usuario: \(userLogin)")
        
        tableView.dataSource = self
       
        //Vamos a leer que hay en la base de datos para mostrar en los cell
      
    }
    
    func acceso_datos_firestore(){
        
        var i=0
        
        db.collection(userLogin).getDocuments { (querySnapshot, error) in
            if let error = error {
                print("Error al obtener documentos: \(error)")
            } else {
                for document in querySnapshot!.documents {
                    // Acceder a campos específicos
                    let id = document.documentID
                    let user = document.get("user") as? String ?? ""
                    let password = document.get("password") as? String ?? ""
                    let plataforma = document.get("plataforma") as? String ?? ""
                    
                    //tengo que meterlos en la lista de registros para luego mostrar
                    // Crear un nuevo objeto Registro
                    let registro = Registro(id: id,user: user, password: password, plataforma:plataforma )
                                    
                    // Añadir el registro a la lista
                    self.listaRegistros.append(registro)
                    
                    DispatchQueue.main.async {
                        self.tableView.reloadData()
                    }

                                
                    
                    
                    // Imprimir los campos
                    print("registros de base de datos")
                    print("ID: \(id), user: \(user), password: \(password)")
                    
                    //print lista
                    print("registros añadiidos a la lista")
                    print("ID: \(self.listaRegistros[i].id), user: \(self.listaRegistros[i].user), password: \(self.listaRegistros[i].password)")
                    
                    i=i+1
                  
                    
                  
                }
            }
        }
        
        

        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listaRegistros.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! RegistrosViewCellTableViewCell
        
        let registro=listaRegistros[indexPath.row]
     
        cell.render(from:registro)
        // Configurar el closure para manejar el evento del botón
        
        
        
        return cell
    }
    
    
  
  
    @IBAction func addRegister(_ sender: Any) {
        self.performSegue(withIdentifier: "add", sender: userLogin)
        
       
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "add" {
            if let destinationVC = segue.destination as? AddRegisterViewController {
                destinationVC.userLogin = sender as! String
            }
        }
        else if segue.identifier == "detalle" {
            if let destinationVC = segue.destination as? DetalleViewController {
                if let selectedIndexPath = tableView.indexPathForSelectedRow {
                    destinationVC.registro = listaRegistros[selectedIndexPath.row]
                    destinationVC.userLogin = userLogin
                }
            }
            
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        //borra lista
        listaRegistros.removeAll()
        
        acceso_datos_firestore()
        // Recargar las celdas para reflejar cambios en la sesión
        tableView.reloadData()
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
