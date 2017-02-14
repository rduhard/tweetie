//
//  RecentTweetsViewController.swift
//  Tweetie

import UIKit


protocol RecentTweetsViewControllerInput {
    var tweetData: RecentTweets.ViewModel? { get set }
    
    func displayTweets(_ tweets: RecentTweets.ViewModel)
    func signedOut(_ tweets: RecentTweets.ViewModel)
}

protocol RecentTweetsViewControllerOutput {
    func loadTweets(_ request: RecentTweets.Request)
    func refreshTweets(_ request: RecentTweets.Request)
    func signOut(_ request: RecentTweets.SignOut.Request)
}

class RecentTweetsViewController: UITableViewController {
    
    var output: RecentTweetsViewControllerOutput!
    
    var tweetData: RecentTweets.ViewModel?
    let tweetCellIdentifier = "TweetCellIdentifier"
    
    override func awakeFromNib() {
        super.awakeFromNib()
        RecentTweetsConfigurator.sharedInstance.configure(self)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        configureTableView()
        fetchTweetsOnLoad()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        refreshTweets()
    }
    
    fileprivate func configureTableView() {
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 100
    }
    
    fileprivate func fetchTweetsOnLoad() {
        let request = RecentTweets.Request()
        output.loadTweets(request)

    }
    
    fileprivate func refreshTweets() {
        let request = RecentTweets.Request()
        output.refreshTweets(request)
    }
    
    @IBAction func signOutClicked(_ sender: AnyObject) {
        let request = RecentTweets.SignOut.Request()
        output.signOut(request)
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let tweetData = tweetData else {
            return 0
        }
        
        return tweetData.tweetCount
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let tweetItem = tweetData?.tweets[indexPath.row] else {
            return TweetCell()
        }
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "TweetCellIdentifier") as! TweetCell
        cell.populate(tweetItem)
        
        return cell
    }
    
    fileprivate func showLogin() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let signInViewController = storyboard.instantiateViewController(withIdentifier: "SignInViewController")
        present(signInViewController, animated: true, completion: nil)
    }
    
}

extension RecentTweetsViewController:  RecentTweetsViewControllerInput {
    
    func displayTweets(_ tweets: RecentTweets.ViewModel) {
        tweetData = tweets
        tableView.reloadData()
    }
    
    func displayLogin() {
        showLogin()
    }
    
    func signedOut(_ tweets: RecentTweets.ViewModel) {
        tweetData = tweets
        showLogin()
        tableView.reloadData()
    }
    
    
}
