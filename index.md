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
Then open the spotify app on your smart device and play a song!
You are all set up.
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
cmd = {
  name = cmdname,
  args = Args,
  description = desc,
  aliases = Aliases,
  command = functionhere
}
return cmd
```
The type of file (ending) can be anything as long as your exploit can read it.
Remember to return the plugin!

## Custom UIs

To get started with your own custom UI, first put ```_G.CustomUI = true``` at the top of Homebrew Admin.
Then use the ```_G.enterframe(textbox)``` function on the text box you want to use a custom UI.
Please note that this will only make it so that every time enter is pressed it will ```getCommand``` with the args of the text of the textbox.

## Commands (Complicated Ones)

# fakechat
Fake chat uses 3 arguments:
```user chat yourmessage```
It uses the chat remote to make it look like someone else said a message, but due to the nature of the command you will need to say a message before that hence the your command.



### Markdown

Markdown is a lightweight and easy-to-use syntax for styling your writing. It includes conventions for

```markdown
Syntax highlighted code block

# Header 1
## Header 2
### Header 3

- Bulleted
- List

1. Numbered
2. List

**Bold** and _Italic_ and `Code` text

[Link](url) and ![Image](src)
```
