//
//  EventsViewController.swift
//  SeatGeekChallengeUIKit
//
//  Created by Ronald Joubert on 5/12/21.
//

import UIKit

class EventsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate {
    
    
    
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    
    
    var nameData: String?
    let vm = EventViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()

        let cellNib = UINib(nibName: "EventTableViewCell", bundle: nil)
        tableView.register(cellNib, forCellReuseIdentifier: "EventCell")
        
        searchBar.delegate = self
        
        self.vm.callNetwork(name: nameData ?? "swift")
        
        self.vm.bind { [weak self] in
            print("Callback achieved")
            DispatchQueue.main.async {
                self?.tableView.reloadData()
            }
        } errorHandler: {
            print("No events")
            self.presentSimpleAlert(title: "Error", message: "No records found", buttonTitle: "OK")
        }
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        self.vm.callNetwork(name: searchText)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.vm.count()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "EventCell", for: indexPath) as! EventTableViewCell
        
        cell.EventName.text = self.vm.artistName(index: indexPath.row)
        cell.EventLocation.text = self.vm.displayLocation(index: indexPath.row)
        cell.EventDate.text = self.vm.date(index: indexPath.row)
        cell.EventImage.image = UIImage(named: "image-not-found")
        
        return cell
    }
    

}
