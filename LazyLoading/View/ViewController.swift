//
//  ViewController.swift
//  LazyLoading
//
//  Created by Justin Bell on 10/20/21.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource {
 
    var myTableView : UITableView = UITableView()
    var animalData : AnimalNetworkManager = AnimalNetworkManager()
    var animal:[Animal]? = nil
  
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    
        setupUI()
        loadDataOnView()
    }
    
    func setupUI () {
        self.view.addSubview(myTableView)
        myTableView.dataSource = self
        //myTableView.register(UITableViewCell.self, forCellReuseIdentifier: "myCustomTableView")
        let customNib = UINib(nibName: "AnimalCellViewController", bundle: nil)
        myTableView.register(customNib, forCellReuseIdentifier: "AnimalCell")
        myTableView.translatesAutoresizingMaskIntoConstraints = false
        myTableView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        myTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        myTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        myTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
    }
    
    func loadDataOnView() {
        animalData.getAnimals(completionHandler: {(_animalData) in
            if (_animalData?.animals != nil) {
                self.animal = _animalData?.animals
                
                DispatchQueue.main.async {
                    self.myTableView.reloadData()
                }
            }
        })
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.animal?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "AnimalCell", for: indexPath) as! AnimalCellViewController
        
        let animalObj = self.animal?[indexPath.row]
        
        cell.animalName.text = animalObj?.name
        
        //cell.textLabel?.text = self.itemsToLoad[indexPath.row]
        
        let animalImageUrl = URL(string: (animalObj?.image)!)!
        let animalImageData = try? Data(contentsOf: animalImageUrl)
        
        cell.animalImage.image = UIImage(data: animalImageData!)
        
        return cell
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
