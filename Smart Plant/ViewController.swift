//
//  ViewController.swift
//  Smart Plant
//
//  Created by Fellipe Souto on 18/04/20.
//  Copyright © 2020 Fellipe Souto. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    
    let plants: [String] = ["Alecrim"]
    let plantsImg: [String] = ["biquinho.jpg"]
    
    let cellReuseIdentifier = "PlantTableViewCell"
    let cellSpacingHeight: CGFloat = 5
    
    var infoPlant: NSDictionary = [:]
    
    @IBOutlet var tableView: UITableView!
    
    let urlJson = "http://192.168.15.22/"

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.registerTableViewCells()
        self.parseJSONPlant(URLPlant: urlJson)
    }
    
    func parseJSONPlant(URLPlant: String)
    {
        guard let url = URL(string: URLPlant) else {return}
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
        guard let dataResponse = data,
                  error == nil else {
                  print(error?.localizedDescription ?? "Response Error")
                  return }
            do{
                let jsonResponse = try JSONSerialization.jsonObject(with: dataResponse, options: [])
                
                self.infoPlant = jsonResponse as! NSDictionary
                print(self.infoPlant)
                
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
                
             } catch let parsingError {
                print("Error", parsingError)
           }
        }
        task.resume()
    }
    
    // Set the spacing between sections
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return cellSpacingHeight
    }

    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        return 150.0;
    }
    
    func tableView(_ tableView: UITableView,
                   numberOfRowsInSection section: Int) -> Int {
        
        if self.infoPlant.count > 0 {
            return 1
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView,
                   cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: cellReuseIdentifier) as? PlantTableViewCell {
            
            let soloStatus = self.infoPlant["solo_status0"] as? String
            let sensorValue = self.infoPlant["sensor0"] as? String
            let arStatus = self.infoPlant["humidity"] as? String
            let tempStatus = self.infoPlant["temperature"] as? String
            
            cell.namePlant.text = "Alecrim"
            cell.statusSolo.text = "Estado do solo: " + soloStatus!
            cell.umidadeSolo.text = "Umidade do solo: " + sensorValue!
            cell.umidadeAr.text = "Umidade relativa do ar: " + arStatus!
            cell.tempAr.text = "Temperatura: " + tempStatus!
            
            return cell
        }
        
        return UITableViewCell()
    }
    
    private func registerTableViewCells() {
        let textFieldCell = UINib(nibName: cellReuseIdentifier, bundle: nil)
        self.tableView.register(textFieldCell, forCellReuseIdentifier: cellReuseIdentifier)
    }
    
    @IBAction func atualizarTabela()
    {
        self.parseJSONPlant(URLPlant: urlJson)
    }

}

