## Welcome to the HB Admin documents.

## Spotify API

To get started with the spotify API, you will first need a  key. You can get that from  [here](https://developer.spotify.com/console/get-users-currently-playing-track/)

Tick the boxes shown below, and press "Request Token":
```
user-read-currently-playing
user-read-playback-position
user-modify-playback-state
```
After getting the token use the spotikey command with your token.
```
spotikey arg
```
Almost done, now use the "spotify" command to unlock the API.
```
spotify
```

Then open the spotify app on your smart device and play a song!
You are all set up.
Enjoy!
Please note that the token only lasts one hour until you will need to renew it but until then you can use the following commands:

```
spotipause -- Pauses the current playing song.
spotiplay -- Plays/unpauses the current song.
spotilast -- Goes back to the last song.
spotinext -- Skips to the next song.
```

## Plugins

Let's make an example plugin:
```markdown
plugin = {
  author = "Syntax 64",
  name = "Test Plugin",
  commands = {
    cmd1 = {
            Name = "test",
            Arguments = 0,
            Description = "a plugin!",
            Aliases = {"testyep","analiase"},
            Function = function()
             print("joe")
          end
    }
  }
 }
return plugin
```

## Commands (Complicated Ones)

### fakechat
Fake chat uses 3 arguments:
```user chat yourmessage```
It uses the chat remote to make it look like someone else said a message, but due to the nature of the command you will need to say a message before that hence the yourmessage.


