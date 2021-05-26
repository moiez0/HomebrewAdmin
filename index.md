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

To make a plugin, first find your exploits workspace folder. Then open the "Admin" folder and then the "plugins"  create a text file with your code in the following layout:
```markdown
plugin = {
  author = author,
  name = pluginname,
  commands = {
    cmd1 = {
            name = name,
            args = args,
            description = desc,
            aliases = aliases,
            command = function()
             -- command
          end
    },
    -- you can add more
  }
 }
return plugin
```
The type of file (ending) can be anything as long as your exploit can read it.

Let's make an example plugin:
```markdown
plugin = {
  author = "Syntax 64",
  name = "Test Plugin",
  commands = {
    cmd1 = {
            name = "test",
            args = 0,
            description = "a plugin!",
            aliases = {"testyep","analiase"},
            command = function()
             print("joe")
          end
    },
    cmd2 = {
            name = "test2",
            args = 0,
            description = "another plugin!!",
            aliases = {},
            command = function()
             print("mama!!")
          end
    }
  }
 }
return plugin
```

## Custom UIs

To get started with your own custom UI, first put ```_G.CustomUI = true``` at the top of Homebrew Admin.
Then use the ```_G.enterframe(textbox)``` function on the text box you want to use a custom UI.
Please note that this will only make it so that every time enter is pressed it will ```getCommand``` with the args of the text of the textbox.
Place your custom UI underneath HB Admin.

## Commands (Complicated Ones)

### fakechat
Fake chat uses 3 arguments:
```user chat yourmessage```
It uses the chat remote to make it look like someone else said a message, but due to the nature of the command you will need to say a message before that hence the yourmessage.


