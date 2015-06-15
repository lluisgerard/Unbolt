import Foundation
import UIKit

private typealias SocialURLS = [NSURL]

public enum SocialProfile {
    
    // MARK: - Types
    case Facebook(id:String)
    case Twitter(username:String)
    case YoutubeUser(user:String)
    case YoutubeChannel(channel:String)
    case Pinterest(user:String)
    case Instagram(user:String)
    case GooglePlus(postsWeb:String) // Example: plus.google.com/u/0/105131501111895540390/posts

    public func open() {
        let urls = self.socialURLS()
        for url in urls {
            if UIApplication.sharedApplication().canOpenURL(url) && UIApplication.sharedApplication().openURL(url) {
                break
            }
        }
    }
    
    // MARK: - Private
    private func socialURLS() -> SocialURLS {
        let strings : [String] = {
            switch self {
            case .Facebook(let id):
                return [
                    "fb://profile/\(id)",
                    "https://www.facebook.com/\(id)"
                ]
            case .Twitter(let username):
                return [
                    "tweetbot://\(username)/user_profile/\(username)",
                    "twitter://user?screen_name=\(username)",
                    "https://www.twitter.com/\(username)"
                ]
            case .YoutubeUser(let user):
                return [
                    "youtube://www.youtube.com/user/\(user)",
                    "https://www.youtube.com/user/\(user)"
                ]
            case .YoutubeChannel(let channel):
                return [
                    "youtube://www.youtube.com/channel/\(channel)",
                    "https://www.youtube.com/channel/\(channel)"
                ]
            case .Pinterest(let user):
                return [
                    "pinterest://user/\(user)/",
                    "http://www.pinterest.com/\(user)"
                ]
            case .Instagram(let user):
                return [
                    "instagram://user?username=\(user)",
                    "http://www.instagram.com/\(user)"
                ]
            case .GooglePlus(let postsWeb):
                return [
                    "gplus://\(postsWeb)",
                    "https://\(postsWeb)"
                ]
            }
        }()
        return transformToSocialURLS(strings)
    }
    
    private func transformToSocialURLS(strings: [String]) -> SocialURLS {
        var urls = SocialURLS()
        for string in strings {
            if let url = NSURL(string: string) {
                urls.append(url)
            }
        }
        return urls
    }
    
}
