//
//  Registro.swift
//  PasswordManager
//
//  Created by Tardes on 14/1/25.
//

import Foundation

class Registro {
    // Propiedades de la clase
    var id: String
    var user: String
    var password: String
    var plataforma: String

    // Inicializador para configurar las propiedades
    init(id: String,user: String, password: String, plataforma: String) {
        self.id = id
        self.user = user
        self.password = password
        self.plataforma = plataforma
    }

    // Método para mostrar la información del usuario de forma segura
    func mostrarUsuario() {
        print("Usuario: \(user)")
    }
}
