//
//  CanadaListViewController.swift
//  WiproAssignment
//
//  Created by chiranjeevi macharla on 12/03/20.
//  Copyright © 2020 chiranjeevi macharla. All rights reserved.
//

import UIKit
import SDWebImage


class CanadaListViewController: UITableViewController {
    
    var canadaViewModel = CanadaViewModel()
    let cellId = "cellId"
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        tableView.refreshControl = refreshcontrol
        
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 100
        tableView.register(ProductsTableViewCell.self, forCellReuseIdentifier: cellId)
        tableView.allowsSelection = false
        self.tableView.separatorStyle = UITableViewCell.SeparatorStyle.singleLine
        //  self.view.backgroundColor = .red
        
        // Do any additional setup after loading the view.
    }
    
    internal let refreshcontrol : UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        let title = NSLocalizedString("pullToRefresh", comment: "pullToRefresh")
        refreshControl.attributedTitle = NSAttributedString(string: title)
        refreshControl.addTarget(self, action: #selector(refreshOptions(sender:)), for: UIControl.Event.valueChanged)
        return refreshControl
    }()
    
    override func viewWillAppear(_ animated: Bool) {
        // intial return a funtion for refresh the content of information from APi
        retrieveCanadaInformation()
    }
    
    @objc private func refreshOptions(sender: UIRefreshControl) {
        // Performed a actions to refresh the content of information from APi
        retrieveCanadaInformation()
    }
    
    private func retrieveCanadaInformation() {
        
        canadaViewModel.fetchDataFromApi(successBlock: { (ProductList, title) in
            DispatchQueue.main.async{
                [weak self] in
                guard let weakSelf = self else { return }
                self!.navigationItem.title = title
                weakSelf.tableView.reloadData()
                weakSelf.refreshcontrol.endRefreshing()
                weakSelf.tableView.beginUpdates()
                weakSelf.tableView.endUpdates()
            }
        }) { (errorString) in
            presentAlert(self, title: StaticString.error, buttonTitle: StaticString.cancel, message: errorString) { (UIAlertAction) in
                self.refreshcontrol.endRefreshing()
            }
        }
        
    }
    
}



/*
 // MARK: - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
 // Get the new view controller using segue.destination.
 // Pass the selected object to the new view controller.
 }
 */

/* new feed back points are updated ProductsTableViewCell
 1. Font increament
 2. placeholder image
 */

extension CanadaListViewController{
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! ProductsTableViewCell
        
        let currentLastItem = canadaViewModel.datalist[indexPath.row]
        cell.textLabel?.text = currentLastItem.title
        cell.textLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        cell.detailTextLabel?.text = currentLastItem.description
        cell.detailTextLabel?.font = UIFont.systemFont(ofSize: 18)
        cell.detailTextLabel?.numberOfLines = 0
        let url = URL(string: currentLastItem.imageHref!)
        cell.imageView?.contentMode = .scaleAspectFit
        cell.imageView?.sd_setImage(with: url, placeholderImage:imageFunction(image: #imageLiteral(resourceName: "placeholder"), sizeValues: CGSize(width: 60, height: 60)), options: .continueInBackground, completed: { (image, error, cacheType, url) in
            if ( image != nil){
                cell.imageView!.image = imageFunction(image: image!, sizeValues: CGSize(width: 60, height: 60))
            }
         
        })
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return canadaViewModel.datalist.count
    }
    
    override func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
}

