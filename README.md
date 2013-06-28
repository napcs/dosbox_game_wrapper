# Game Wrapper for DOSBox

These are my scripts, written in Ruby, for taking a DOS game and wrapping it
with DOSBox for play on Windows and OSX. 

## How it works

You need a DOS game that you own. Don't ask me to help you pirate stuff. But if you have a game you bought and you want to run it, that's what this is for.
It uses DOSBox (the open-source emulator) and creates an app that you can run.
You click the icon, DOSBox loads,  the gmae runs, and when you quit, 
everything exits automatically, just like any of your other games.

I built this to play Epic Pinball cos I love that game. 

## Using with your own games


1. Create a new folder, like EpicPinball
2. Copy these files into that folder
3. Place your game's files in the `game` folder.
4. Create icons in ico and icns format and overwrite the originals. http://iconverticons.com/ is a great converter.
5. Modify the dosbox.conf.osx and dosbox.conf.win files to run your game's executable. There's lots to tweak here, and you're on your own for this. Make sure to put the game's executable at the bottom of the file!!!
6. run `ruby make_win_app.rb` to build the Windows files
7. run `ruby make_mac_app.rb` to build the Mac files
8. Optionally, create an installer for your game with InnoSetup


Don't like these steps? Patches welcome!

## Additional notes

For CD games, put the CD image and the files in the `game` folder like this:

`game\hd`  contains the files that would go on the hard drive
`game\cd`  contains the CD image

Then your configuration files would do something like this:

```

mount c game/hd

imgmount D "game/cd/x-wing.iso" -t iso

c:
call xwingcd2.bat
exit
````
 
## License

DOSBox is under the GPL. See `windows\Documentation\COPYING.txt` for the GPL license.

The rest is my code, under the MIT.

The MIT License (MIT)

Copyright (c) 2013 Brian P. Hogan

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in
all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
THE SOFTWARE.
