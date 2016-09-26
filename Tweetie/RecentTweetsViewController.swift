//
//  RecentTweetsViewController.swift
//  Tweetie

import UIKit


protocol RecentTweetsViewControllerInput {
    var tweetData: RecentTweets.ViewModel? { get set }
    
    func displayTweets(tweets: RecentTweets.ViewModel)
    func signedOut()
}

protocol RecentTweetsViewControllerOutput {
    func loadTweets(request: RecentTweets.Request)
    func signOut(request: RecentTweets.SignOut.Request)
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
//        fetchTweetsOnLoad()
    }

    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        refreshTweets()
    }
    
    private func configureTableView() {
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 100
    }
    
    private func fetchTweetsOnLoad() {
        let request = RecentTweets.Request()
        output.loadTweets(request)

    }
    
    private func refreshTweets() {
        let request = RecentTweets.Request()
        output.loadTweets(request)
    }
    
    @IBAction func signOutClicked(sender: AnyObject) {
        let request = RecentTweets.SignOut.Request()
        output.signOut(request)
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let tweetData = tweetData else {
            return 0
        }
        
        return tweetData.tweetCount
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        guard let tweetItem = tweetData?.tweets[indexPath.row] else {
            return TweetCell()
        }
        
        let cell = tableView.dequeueReusableCellWithIdentifier("TweetCellIdentifier") as! TweetCell
        cell.populate(tweetItem)
        
        return cell
    }
    
    private func showLogin() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let signInViewController = storyboard.instantiateViewControllerWithIdentifier("SignInViewController")
        presentViewController(signInViewController, animated: true, completion: nil)
    }
    
}

extension RecentTweetsViewController:  RecentTweetsViewControllerInput {
    
    func displayTweets(tweets: RecentTweets.ViewModel) {
        tweetData = tweets
        tableView.reloadData()
    }
    
    func displayLogin() {
        showLogin()
    }
    
    func signedOut() {
        showLogin()
    }
    
    
}
