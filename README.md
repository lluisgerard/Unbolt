# Unbolt
Simple Swift enum to open Social user ids

Just:
```
SocialProfile.Twitter(username: "lluisgerard").open()
```
This will try first Tweetbot, then Twitter, and finally will open Safari.
Other types just try to open it with the official app and if it fails, it just opens Safari.

Types:
```
    case Facebook(id:String)
    case Twitter(username:String)
    case YoutubeUser(user:String)
    case YoutubeChannel(channel:String)
    case Pinterest(user:String)
    case Instagram(user:String)
    case GooglePlus(postsWeb:String) // Example: plus.google.com/u/0/105131501111895540390/posts
```

Open the example project to see how it works on device.