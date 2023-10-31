//
//  SearchLocationViewController.swift
//  MapMyMemories
//
//  Created by 문정호 on 2023/10/09.
//

import UIKit

protocol PassLocation: AnyObject{
    func passingLocation(addressData: Document)
}


class SearchLocationViewController: UITableViewController{
    //MARK: - Properteis
    let searchController = {
        let view = UISearchController(searchResultsController: nil)
        view.searchBar.placeholder = "장소를 입력하세요"
        return view
    }()
    
    let apiManager = APIManager()
    
    var searchResults: [Document] = []{
        didSet{
            tableView.reloadData()
        }
    }
    
    weak var delegate: PassLocation?
    
    
    //MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
        setNavigation()
    }
    
    deinit {
        print("SearchLocationVC deinit")
    }
    
    //MARK: - configure
    func configure(){
        searchController.searchResultsUpdater = self
    }
    
    //MARK: - SetNavigation
    func setNavigation() {
        self.navigationItem.searchController = searchController
        self.navigationItem.hidesSearchBarWhenScrolling = false
    }
    
}

extension SearchLocationViewController: UISearchResultsUpdating{
    func updateSearchResults(for searchController: UISearchController) {
        guard let text = searchController.searchBar.text, text != "" else {
            self.searchResults = []
            return
        }
        
        apiManager.requestAPI(type: LocationSearchModel.self, api: .kewordSearch(query: text)) { [weak self] result in
            switch result {
            case .success(let success):
                self?.searchResults = success.documents
            case .failure(let failure):
                self?.view.makeToast("네트워크 연결에 실패했습니다.")
                print(failure)
            }
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchResults.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: "Cell")
        var cellConfig = cell.defaultContentConfiguration()
        cellConfig.text = searchResults[indexPath.row].placeName
        cellConfig.secondaryText = searchResults[indexPath.row].roadAddressName
        cell.contentConfiguration = cellConfig
        
        return cell
    }
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        delegate?.passingLocation(addressData: self.searchResults[indexPath.row])
        self.navigationController?.popViewController(animated: true)
    }
    
    
}
