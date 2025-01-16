//
//  RegistrosViewCellTableViewCell.swift
//  PasswordManager
//
//  Created by Tardes on 14/1/25.
//

import UIKit

class RegistrosViewCellTableViewCell: UITableViewCell {
    
    @IBOutlet weak var lbPataformaAlternativa: UILabel!
    
    @IBOutlet weak var logo: UIImageView!
    
    @IBOutlet weak var lbUser: UILabel!
    
    @IBOutlet weak var lbPassword: UILabel!
    
    private var isPasswordVisible = false // Estado de visibilidad
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
       
        // Configure the view for the selected state
    }
    func render(from registro: Registro) {
        
        lbPataformaAlternativa.text=""
        
        if let platformImage = UIImage(named: registro.plataforma) {
            logo.image = platformImage
            // Si se encuentra la imagen, no es necesario rellenar el label
        } else {
            logo.image = UIImage(systemName: "envelope")
            // Rellenar el label con el nombre de la plataforma
            lbPataformaAlternativa.text = registro.plataforma
        }

        
        lbUser.text=registro.user
        lbPassword.text=registro.password
        //ponemos puntitos a las contraseñas
        lbPassword.text = lbPassword.text?.toPasswordMask() ?? ""
        
    }
    
  
        
        
        
    
}
// Extensión para convertir un texto a formato de contraseña
extension String {
    func toPasswordMask() -> String {
        return String(repeating: "•", count: 8)
    }
}
