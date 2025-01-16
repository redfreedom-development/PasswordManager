//
//  DetalleViewController.swift
//  PasswordManager
//
//  Created by Tardes on 16/1/25.
//

import UIKit
import FirebaseFirestore

class DetalleViewController: UIViewController {

    @IBOutlet weak var lbPlataformaOther: UILabel!
    
    @IBOutlet weak var lbUserLogin: UILabel!
    @IBOutlet weak var imgPlataforma: UIImageView!
    
    @IBOutlet weak var txtUser: UITextField!
    
    @IBOutlet weak var txtPassword: UITextField!
    
    @IBOutlet weak var btSave: UIButton!
    
    //variables que recibo de la celda pulsada en el viewControllerHome
    var registro:Registro!
    var userLogin:String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //rellenamos los campos
        lbUserLogin.text=userLogin
       // imgPlataforma.image=UIImage(named: registro.plataforma) ?? UIImage(systemName: "envelope")
        if let platformImage = UIImage(named: registro.plataforma) {
            imgPlataforma.image = platformImage
            lbPlataformaOther.text = nil
            // Si se encuentra la imagen, no es necesario rellenar el label
        } else {
            imgPlataforma.image = UIImage(systemName: "envelope")
            // Rellenar el label con el nombre de la plataforma
            lbPlataformaOther.text = registro.plataforma
        }
        txtUser.text=registro.user
        txtPassword.text=registro.password
        txtUser.isEnabled=false
        txtPassword.isEnabled=false
        btSave.isEnabled=false

        // Do any additional setup after loading the view.
    }
    
    @IBAction func btEditar(_ sender: Any) {
        btSave.isEnabled=true
        txtPassword.isEnabled=true
    }
    
    @IBAction func btSave(_ sender: Any) {
        let db = Firestore.firestore()

        // Referencia al documento que quieres actualizar
        let documentoID = registro.id
        let referenciaDocumento = db.collection(userLogin).document(documentoID)

        // Actualiza un campo específico
        referenciaDocumento.updateData([
            "password": txtPassword.text ?? ""
        ]) { error in
            if let error = error {
                print("Error al actualizar el documento: \(error.localizedDescription)")
            } else {
                print("Campo actualizado con éxito")
                self.mostrarAlerta()
                self.txtPassword.isEnabled=false
                self.btSave.isEnabled=false
                
            }
        }

    }
    func mostrarAlerta() {
        // Crea la alerta
        let alerta = UIAlertController(title: "Info", message: "Registro guardado exitosamente", preferredStyle: .alert)
        alerta.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        
        // Encuentra la escena activa
        if let scene = UIApplication.shared.connectedScenes.first(where: { $0.activationState == .foregroundActive }) as? UIWindowScene,
           let rootViewController = scene.windows.first(where: { $0.isKeyWindow })?.rootViewController {
            
            // Presenta la alerta desde el controlador raíz
            rootViewController.present(alerta, animated: true, completion: nil)
        }
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
