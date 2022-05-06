//
//  OnBoardingVC.swift
//  DoorcastRebase
//
//  Created by Codebele 09 on 04/05/22.
//

import UIKit

class OnBoardingVC: UIViewController {
    
    static var newInstance: OnBoardingVC? {
        let storyboard = UIStoryboard(name: Storyboard.dashboard.name,
                                      bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: self.className()) as? OnBoardingVC
        return vc
    }
    
    @IBOutlet weak var CommonNavBarView: UIView!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var logoutImg: UIImageView!
    @IBOutlet weak var logoutBtn: UIButton!
    @IBOutlet weak var allTasksView: UIView!
    @IBOutlet weak var allTasksLabel: UILabel!
    @IBOutlet weak var allTasksBtn: UIButton!
    @IBOutlet weak var CompanyTV: UITableView!
    
    
    // To get organization from model
    var crewOrganisations: GetOrganizationsModel?
    var viewModel : GetOrganizations!
    
    // for logout api
    var logoutdata : LogoutModel!
    var logoutModel : LogoutViewModel!
    
 
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        usernameLabel.text = SessionManager.loginInfo?.data?.fullname?.uppercased() ?? ""
        
        CompanyTV.backgroundColor = .white
        view.backgroundColor = .white
        updateColor()
        updateFonts()
        allTasksLabel.text = "TASK SUMMARY"
        allTasksLabel.textAlignment = .center
        
        dateLabel.text =  Date().MonthDateDayFormatter?.uppercased()

        CompanyTV.allowsSelection = true
        CompanyTV.delegate = self
        CompanyTV.dataSource = self
        
        CompanyTV.register(CompanyTVCell.self, forCellReuseIdentifier: "CompanyTVCell")
        CompanyTV.register(UINib(nibName: "CompanyTVCell", bundle: nil), forCellReuseIdentifier: "CompanyTVCell")
        
        print("Home Login info = \(SessionManager.loginInfo?.data?.accesstoken)")
        viewModel = GetOrganizations(self)
        viewModel.getOrganizationApi()
        
        logoutModel = LogoutViewModel(self)
    }
     
    func updateFonts() {
        // to add fonts
        allTasksLabel.font = UIFont.oswaldMedium(size: 22)
        dateLabel.font = UIFont.oswaldRegular(size: 18)
        usernameLabel.font = UIFont.oswaldRegular(size: 18)
        
        
    }

    func updateColor() {
        // to add colors
        allTasksLabel.textColor = UIColor.AppBackgroundColor
        allTasksView.backgroundColor = UIColor.ThemeColor
        dateLabel.textColor = UIColor.white
        usernameLabel.textColor = UIColor.white
        
        
    }

    @IBAction func logoutBtnIsTapped(_ sender: Any) {
        // func to be executed when logged out
        print("logoutttt.....")
        logoutModel.logoutApi()
        SessionManager.logoutUser()
        self.showLogin()
    }
    
    @IBAction func allTasksBtnIsTapped(_ sender: Any) {
    }
    
}

extension OnBoardingVC: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return crewOrganisations?.data?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = CompanyTV.dequeueReusableCell(withIdentifier: "CompanyTVCell", for: indexPath) as! CompanyTVCell
        cell.titleLabel.text = crewOrganisations?.data?[indexPath.row].organization_name
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
         print("chaitraaa")
  
        // to move to next screen and move id's to next screen 
        
        let storyBoard: UIStoryboard = UIStoryboard(name: "Dashboard", bundle: nil)
        let vc = storyBoard.instantiateViewController(withIdentifier: "CrewPropertiesVC") as! CrewPropertiesVC
        UserDefaults.standard.set(crewOrganisations?.data?[indexPath.row].organization_id ?? "", forKey: "type")
        vc.type =  crewOrganisations?.data?[indexPath.row].organization_id ?? ""
        vc.orgname = crewOrganisations?.data?[indexPath.row].organization_name ?? ""
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: true, completion: nil)
        
        print(crewOrganisations?.data?[indexPath.row].organization_id ?? "")
        
   }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }

}
extension OnBoardingVC : GetOrganizationsModelProtocol, LogoutViewModelProtocol {
    func logoutSuccess(logoutResponse: LogoutModel) {
        
      // api of logout
        DispatchQueue.main.async {
            SessionManager.logoutUser()
            self.showLogin()
        }
    }
    func organizationDetails(response: GetOrganizationsModel) {
        // api for organization
        print("Organization details = \(response)")
        crewOrganisations = response
        print("org name = \(response.data?.first?.organization_name ?? "")")
        
        
        DispatchQueue.main.async {
            self.CompanyTV.reloadData()
        }
        
        
    }
    
}
