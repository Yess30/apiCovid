//
//  CovidViewController.swift
//  JsonDecoderExample
//
//  Created by Mac19 on 03/07/21.
//

import UIKit

struct CovidEst: Codable {
    let country:String
    let cases:Int64
}

class CovidViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var covidCas = [CovidEst]()
    @IBOutlet weak var tablaCovid: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let urlString = "https://corona.lmao.ninja/v3/covid-19/countries"
        
        if let url = URL(string: urlString) {
            if let data = try? Data(contentsOf: url) {
                parsear(json: data)
            }
        }
        
    }
    
    func parsear(json: Data) {
        let decoder = JSONDecoder()
        if let jsonPeticion = try? decoder.decode([CovidEst].self, from: json) {
            print("peticiones \(jsonPeticion.count)")
            covidCas = jsonPeticion
            tablaCovid.reloadData()
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return covidCas.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let celda = tablaCovid.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        celda.textLabel?.text = covidCas[indexPath.row].country
        celda.detailTextLabel?.text = "\(covidCas[indexPath.row].cases)"
        
        return celda
    }
    
}
