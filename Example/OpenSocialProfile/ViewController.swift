//
//  ViewController.swift
//  OpenSocialProfile
//
//  Created by Lluis Gerard on 15/06/15.
//  Copyright (c) 2015 Lluis Gerard. All rights reserved.
//

import UIKit

let socialData =
[
    SocialProfileDescription.Twitter: ["realm","cloudkite","ashfurrow","davedelong","iwasleeg","nsbarcelona","objcio","NSHipster","NatashaTheRobot","lluisgerard"],
    SocialProfileDescription.Facebook: ["lluisgerard"],
    SocialProfileDescription.YoutubeUser: ["everyframeapainting"],
    SocialProfileDescription.YoutubeChannel: ["UC0t-zx5Gnj05dVb9AOEsMKA"],
    SocialProfileDescription.Pinterest: ["lluisgerard"],
    SocialProfileDescription.Instagram: ["lluisgerard"],
    SocialProfileDescription.GooglePlus: ["plus.google.com/u/0/105131501111895540390/posts"]
]

enum SocialProfileDescription : String {
    case Twitter = "Twitter"
    case Facebook = "Facebook"
    case YoutubeUser = "YoutubeUser"
    case YoutubeChannel = "YoutubeChannel"
    case Pinterest = "Pinterest"
    case Instagram = "Instagram"
    case GooglePlus = "GooglePlus"
}

// MARK: - ViewController
class ViewController: UIViewController {

    let data = socialData
    lazy var sections : [SocialProfileDescription] = {
        return self.data.keys.array.sorted{ $0.rawValue < $1.rawValue }
    }()

    weak var myView : GenericViewWithTable?
    override func viewDidLoad() {
        super.viewDidLoad()
        self.myView?.tableView.registerClass(GenericTableViewCell.self, forCellReuseIdentifier:GenericTableViewCell.reuseIdentifier)
        self.myView?.tableView.delegate = self
        self.myView?.tableView.dataSource = self
    }
    
    override func loadView() {
        super.loadView()
        view = {
            let view = GenericViewWithTable()
            self.myView = view
            return view
        }()
    }
    
}

// MARK: - UITableViewDelegate
extension ViewController : UITableViewDelegate {
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated:true)
        let id = self.stringAtIndexPath(indexPath)

        switch self.sections[indexPath.section] {
        case .Facebook:
            SocialProfile.Facebook(id: id).open()
        case .Twitter:
            SocialProfile.Twitter(username: id).open()
        case .YoutubeUser:
            SocialProfile.YoutubeUser(user: id).open()
        case .YoutubeChannel:
            SocialProfile.YoutubeChannel(channel: id).open()
        case .Pinterest:
            SocialProfile.Pinterest(user: id).open()
        case .Instagram:
            SocialProfile.Instagram(user: id).open()
        case .GooglePlus:
            SocialProfile.GooglePlus(postsWeb: id).open()
        }
        
    }
}

// MARK: - UITableViewDataSource
extension ViewController : UITableViewDataSource {
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.data[sections[section]]?.count ?? 0
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return self.data.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(GenericTableViewCell.reuseIdentifier, forIndexPath: indexPath) as! GenericTableViewCell
        cell.textLabel?.text = self.stringAtIndexPath(indexPath)
        return cell
    }
    
    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "\(self.sections[section].rawValue)"
    }
    
    func stringAtIndexPath(indexPath: NSIndexPath) -> String {
        if let arrayOfSection = self.data[self.sections[indexPath.section]] {
            return arrayOfSection[indexPath.item]
        }
        return ""
    }
    
}

extension NSLayoutConstraint {
    class func equal(item:AnyObject, attributes:[NSLayoutAttribute], toItem:AnyObject) -> [NSLayoutConstraint] {
        item.setTranslatesAutoresizingMaskIntoConstraints(false)
        toItem.setTranslatesAutoresizingMaskIntoConstraints(false)
        var constraints = [NSLayoutConstraint]()
        for attribute in attributes {
            constraints.append(self.equal(item, attribute:attribute, toItem:toItem, constant:0))
        }
        return constraints;
    }
    class func equal(item:AnyObject, attribute:NSLayoutAttribute, toItem:AnyObject, constant:CGFloat) -> NSLayoutConstraint {
        item.setTranslatesAutoresizingMaskIntoConstraints(false)
        toItem.setTranslatesAutoresizingMaskIntoConstraints(false)
        return NSLayoutConstraint(item:item, attribute:attribute, relatedBy: .Equal, toItem:toItem, attribute:attribute, multiplier:1, constant:constant)
    }
    
}

public class GenericViewWithTable: UIView {
    
    public lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.indicatorStyle = UIScrollViewIndicatorStyle.Black
        tableView.backgroundColor = UIColor.whiteColor()
        tableView.bounces = true
        tableView.alwaysBounceVertical = true
        tableView.separatorColor = UIColor.lightGrayColor()
        tableView.separatorStyle = UITableViewCellSeparatorStyle.SingleLine
        return tableView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setupViews()
        self.setupConstraints()
    }
    
    required public init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func setupViews() {
        self.backgroundColor = UIColor.whiteColor()
        self.addSubview(self.tableView)
    }
    
    public func setupConstraints() {
        
        self.addConstraint(NSLayoutConstraint.equal(self, attribute:.Top, toItem:self.tableView, constant:-20))
        self.addConstraints(NSLayoutConstraint.equal(self, attributes: [.Left, .Right, .Bottom], toItem:self.tableView))
        
    }
    
}

class GenericTableViewCell : UITableViewCell {
    static let reuseIdentifier = "GenericTableViewCell"
}

