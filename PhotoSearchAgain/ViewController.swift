//
//  ViewController.swift
//  PhotoSearchAgain
//
//  Created by Felipe Ignacio Zapata Riffo on 27-07-21.
//

import UIKit
import SDWebImage
import SafariServices

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate {
    
    @IBOutlet weak var tableView:UITableView?
    @IBOutlet weak var searchBar:UISearchBar?
    
    
 
    var results2 : [ImagesResult] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView?.delegate = self
        tableView?.dataSource = self
        let nib = UINib(nibName: "PhotoSearchTableViewCell", bundle: nil)
        tableView?.register(nib, forCellReuseIdentifier: "PhotoSearchTableViewCell")
        tableView?.rowHeight = 250
        searchBar?.delegate = self
        
        tableView?.reloadData()
    }
    
     
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return results2.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell =  tableView.dequeueReusableCell(withIdentifier: "PhotoSearchTableViewCell", for: indexPath) as! PhotoSearchTableViewCell
        
        let img =  results2
        if let dataImg = img[indexPath.row].thumbnail{
        cell.imageView_?.sd_setImage(with: URL(string: dataImg))
        }
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let data = results2[indexPath.row].thumbnail
        print(data!)

       
    }
    
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        guard let text = searchBar.text else {
            return
        }
        results2 = []
        print("\(text)")
        tableView?.reloadData()
        fetchPhotos(query: text)
      
        }

    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        print("searchText \(String(describing: searchBar.text))")
        }
    
    func fetchPhotos(query:String){
        
        let urlString = "https://serpapi.com/search.json?q=\(query)&tbm=isch&ijn=0&api_key=fca737073fa8af4e7dc7cb9aa8e9d2997adb47614a6e3b4820918fc20f7195e0"
        
       guard let url = URL(string: urlString) else {
           return
       }
       let task = URLSession.shared.dataTask(with: url) { data, _, error in
           guard let data = data, error == nil else {
               return
           }
            var results:APIResponse?
           do{
               let jsonResult = try JSONDecoder().decode(APIResponse.self, from: data)
               DispatchQueue.main.async {
                self.results2 = jsonResult.imagesResults
                self.tableView?.reloadData()
                
               // print(self.results2)
               }
             
           }
           catch {
               print(error)
           }
       }
       task.resume()
    }


}

