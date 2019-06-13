//
//  IncidentsVC.swift
//  Huachicol
//
//  Created by Mauricio Rodriguez on 06/03/19.
//  Copyright © 2019 Mauricio Rodriguez. All rights reserved.

import UIKit
import Alamofire

import Foundation

// MARK: - UsuarioElement
public struct UsuarioElement: Codable {
    public let id, titulo, descripcion, sendDate: String?
    public let punto: Punto
    public let userID: String?
    
    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case titulo, descripcion, sendDate, punto
        case userID = "userId"
    }
    
    public init () {
        self.titulo  = String()
        self.descripcion = String()
        self.id = String()
        self.punto = Punto(x: Double(), y: Double(), coordinates: [Double](), type: String())
        self.sendDate = String()
        self.userID = String()
    }
}

// MARK: - Punto
public struct Punto: Codable {
    public let x, y: Double?
    public let coordinates: [Double]?
    public let type: String?
}

typealias UsuarioRespuesta = [UsuarioElement]


class IncidentsVC: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UITextViewDelegate{
    
    var opcCollection: UICollectionView?
    var layout: UICollectionViewFlowLayout?
    var iconName = [UIImage]()
    var iconBank = [UIImage]()
    var nombreArray = [String]()
    var cancelar: UIButton?
    var options: UIView?
    var optionsRestriction: UIView?
    
    var titleArray = [String]()
    var statusArray = [String]()
    
    
    var idUser: String?
    
    @IBOutlet weak var descriptionTextView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        serviceShowDenounce()
        
        //setArrays()
        loadInterface()
    }
    
    // Método que carga los arreglos del menú de opciones
    /*func setArrays() {
        
        titleArray = ["Incendio","Robo"]
        
        statusArray = ["Pendiente","En progreso"]

    }*/
    
    // Método que carga la interfaz gráfica del controlador
    func loadInterface() {
        
        layout = UICollectionViewFlowLayout()
        layout?.itemSize = CGSize(width: wScreen * 0.85, height: hScreen * 0.15)
        layout?.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        layout?.minimumLineSpacing = 10
        layout?.minimumInteritemSpacing = 0
        
        opcCollection = UICollectionView(frame: CGRect(x: 0, y: (descriptionTextView!.frame.maxY) + hScreen * 0.05, width: wScreen * 0.86, height: hScreen * 0.65), collectionViewLayout: layout!)
        opcCollection?.center.x = view.center.x
        opcCollection?.register(IncidentsCell.self, forCellWithReuseIdentifier: "cell")
        opcCollection?.delegate = self
        opcCollection?.dataSource = self
        //opcCollection?.layer.borderWidth = 1.5
        //opcCollection?.layer.borderColor = grayClean.cgColor
        opcCollection?.backgroundColor = UIColor.clear
        opcCollection?.isScrollEnabled = true
        opcCollection?.bounces = false
        view.addSubview(opcCollection!)
    }
    
    
    //--Métodos de protocolos implementados--//
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return titleArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! IncidentsCell
        cell.optionName?.text = nil
        cell.details?.text = nil
        cell.optionBank?.text = nil
        cell.optionCard?.text = nil
        cell.layer.borderWidth = 0.9
        //cell.backgroundColor = grayCell
        cell.layer.borderColor = cleanGreen.cgColor
        cell.layer.cornerRadius = 5.0
        cell.setCell(status: titleArray[indexPath.row], name: statusArray[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    print("ver datos")
    }
    
    func serviceShowDenounce(){
        
        guard let bearerToken = Singleton.getInstance().userToken else {
            print("No podemos obtener el token")
            return
        }
        
        let headers1 = [
            "Content-Type": "application/x-www-form-urlencoded",
            "Authorization": "Bearer " + "\(bearerToken)"
        ]
        
        
        guard let email = Singleton.getInstance().emailUser else {
            print("no se pudo")
            return
        }
        
        print(email)
        
        
        Alamofire.request("https://damp-ocean-98658.herokuapp.com/api/v1/user/complains/\(email)", method: .get, encoding: URLEncoding(destination: .queryString), headers: headers1).responseJSON {
            response in
            print(response)

            guard let dataRecieved = response.data else {
                print("no se pudo parsear la respuesta")
                return
            }
            
            guard let usuarioRespuesta = try? JSONDecoder().decode(UsuarioRespuesta.self, from: dataRecieved) else {return}
            
            for item in usuarioRespuesta {
                //print(item.titulo ?? "")
                //print(item.descripcion ?? "")
                self.statusArray.append(item.titulo ?? "")
                self.titleArray.append(item.sendDate ?? "")
                //self.statusArray = [item.titulo!]
                //self.titleArray = [UsuarioElement.init().titulo!]
            }
           
            print(self.statusArray)
            print(self.titleArray)
            self.opcCollection?.reloadData()
        }
    }
    
    
    
    
    
    //--Métodos de ciclo de vida del controlador--//
    override func viewWillAppear(_ animated: Bool) {}
    override func viewWillDisappear(_ animated: Bool) {}
    override func viewDidAppear(_ animated: Bool) {}
    override func viewDidDisappear(_ animated: Bool) {}
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}



