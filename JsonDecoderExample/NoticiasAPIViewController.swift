

import UIKit

struct Noticia: Codable {
    var title: String?
    var description: String?
}

struct Noticias: Codable {
    var articles: [Noticia]
}

class NoticiasAPIViewController: UIViewController, UITableViewDelegate, UITableViewDataSource{
    
    var noticias = [Noticia]()
    
    @IBOutlet weak var tablaNoticias: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let urlString = "https://newsapi.org/v2/top-headlines?apiKey=3fd0da6740d34b9cbda962f44683ceba&country=mx"
        
        if let url = URL(string: urlString) {
            if let data = try? Data(contentsOf: url) {
                
                parsear(json: data)
            }
        }
        
        
        
    }
    
    func parsear(json: Data) {
        let decoder = JSONDecoder()
        
        if let jsonPetitions = try? decoder.decode(Noticias.self, from: json) {
            noticias = jsonPetitions.articles
            tablaNoticias.reloadData()
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return noticias.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let celda = tablaNoticias.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        celda.textLabel?.text = noticias[indexPath.row].title
        celda.detailTextLabel?.text = noticias[indexPath.row].description ?? "No hay info"
        return celda
    }
    
}
