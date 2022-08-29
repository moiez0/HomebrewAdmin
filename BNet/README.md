
## FAQ

#### What exploits are supported?
Synapse and Scriptware.

Only these exploits work as we use a websocket library to send/recieve data.

#### How does it work?

Firstly, BNet enables the connection of numerous ROBLOX clients to the host exploit on your computer.

BNet uses a locally hosted websocket to tunnel data between the host and bot(s)

This allows for smart command execution. 

#### How to use?

Firstly, download the latest version of the BNet program from our github.

It is open source so if you want to recompile it for yourself, you can go ahead and do so.

Then, run the program before opening any ROBLOX tabs.

After that, open the amount of ROBLOX instances you want and run the following code as you auto attach to them.:
```lua
  getgenv().Client = true
```
On the top of the Homebrew Admin so that the script recognises that the process is a BOT.

Once all the bots are ingame and you have executed the script, open the host process and set getgenv().Client = false at the top.

