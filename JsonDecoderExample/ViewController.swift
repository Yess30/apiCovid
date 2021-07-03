
import UIKit

struct Peticion: Codable {
    var title: String
    var body: String
}

struct Peticiones: Codable {
    var results: [Peticion]
}

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    var peticiones = [Peticion]()
    
    
    @IBOutlet weak var tablaJson: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        let urlString = "https://www.hackingwithswift.com/samples/petitions-1.json"
        
        if let url = URL(string: urlString) {
            if let data = try? Data(contentsOf: url) {
                
                parsear(json: data)
            }
        }
        
    }
    
    func parsear(json: Data) {
        let decoder = JSONDecoder()
        
        if let jsonPetitions = try? decoder.decode(Peticiones.self, from: json) {
            peticiones = jsonPetitions.results
            tablaJson.reloadData()
        }
    }
    
    //MARK:- Table View Methods
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return peticiones.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let celda = tablaJson	.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        celda.textLabel?.text = peticiones[indexPath.row].title
        celda.detailTextLabel?.text = peticiones[indexPath.row].body
        return celda
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
        
    }
    
}

