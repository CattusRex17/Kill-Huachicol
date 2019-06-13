//
//  IncidentesCell.swift
//  Huachicol
//
//  Created by Mauricio Rodriguez on 5/22/19.
//  Copyright © 2019 Mauricio Rodriguez. All rights reserved.
//

import UIKit

class IncidentsCell: UICollectionViewCell {
    
    var optionCard: UILabel?
    var optionBank: UILabel?
    var optionName: UILabel?
    var details: UILabel?
    var blueLine: UIView?
    
    func setCell(status: String, name: String) {
        
        // Alto y ancho de la celda
        let wCell = frame.width
        let hCell = frame.height
        
        optionBank = UILabel(frame: CGRect(x: wScreen * 0.06, y: wScreen * 0.03, width: wCell * 0.30, height: hScreen * 0.03))
        //optionBank?.center.x = frame.width/2
        optionBank?.text = "Titulo"
        optionBank?.textAlignment = .center
        optionBank?.font = UIFont(name: "Helvetica", size: 19)
        //optionBank?.layer.borderWidth = 1.0
        optionBank?.layer.borderColor = cleanGreen.cgColor
        addSubview(optionBank!)
        
        optionName = UILabel(frame: CGRect(x: (optionBank?.frame.maxX)! * 1.18, y: wScreen * 0.05, width: wCell * 0.55, height: hScreen * 0.03))
        //optionName?.center.x = center.x
        optionName?.text = "Fecha"
        optionName?.textAlignment = .center
        optionName?.font = UIFont(name: "Helvetica", size: 19)
        optionName?.textColor = UIColor.black
        optionName?.backgroundColor = UIColor.clear
        addSubview(optionName!)
        
        optionCard = UILabel(frame: CGRect(x: wScreen * 0.06, y: (optionBank?.frame.maxY)! * 1.2, width: wCell * 0.30, height: wScreen * 0.15))
        //optionCard?.center.x = frame.width/2
        optionCard?.text = name
        //optionCard?.layer.borderWidth = 2.0
        optionCard?.font = UIFont(name: "Helvetica", size: 18)
        //optionCard?.layer.borderColor = hardBlue.cgColor
        //optionCard?.layer.cornerRadius = 7.0
        //optionCard?.layer.borderWidth = 1
        addSubview(optionCard!)
        
        details = UILabel(frame: CGRect(x: (optionCard?.frame.maxX)! * 1.4, y: (optionName?.frame.maxY)! * 1.2, width: wCell * 0.35, height: hScreen * 0.03))
        details?.text = status
        details?.textAlignment = .center
        details?.font = UIFont(name: "Helvetica", size: 18)
        details?.textColor = UIColor.black
        details?.backgroundColor = UIColor.clear
        addSubview(details!)
    }
}



