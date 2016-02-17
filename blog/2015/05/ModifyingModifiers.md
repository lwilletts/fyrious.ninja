# Modifying Modifiers
## 2015-05-29

So, you've got your brand new lightweight window manager going.
Chances are, you're using at least some keyboard hotkeys to manage
it, whether it's a tiling, floating or dynamic window manager.
Before trying to find shortcuts and combinations that work for you
and your workflow, I recommend looking at rebinding the modifier
keys around your keyboard.


A lightweight solution I've found to doing this is with xmodmap.
While it allows remapping of keys to create your own layout when
using X, it also allows you to change the modifiers. To start,
create a file with your favourite text editor and put this at the
the top of the file:

    clear lock
    clear control
    clear mod1
    clear mod2
    clear mod3
    clear mod4
    clear mod5

Next we can choose what keys we want represented by mod[1-5] and
add our control keys back:

    add control = Control_L Control_R
    add mod1    = Alt_L
    add mod2    = Alt_R
    add mod3    = Hyper_L
    add mod4    = Super_L Super_R
    add mod5    = Num_Lock
    keycode 37  = Hyper_L
    keycode 66  = Control_L
    keycode 105 = Control_L
    keycode 133 = Control_L

Unfortunately due to my keyboard (QuickFire TK) I need Num_Lock to be
bound else I can't switch between my number pad and the more useful
functions like the insert and delete keys. My examples also show
where I bind Hyper_L and Control_L (Hyper_L goes to the normal
position of Control_L and Control_L replaces CapsLock and a couple
of other keys), but on other systems the keycodes might vary.


For future reference, you can save all your current keybindings
into a file like so:

    $ xmodmap -pke > keybindings.txt


Save the file and put it in a location of your choosing. To load it
consistently when you start X11, just place the following into
your ~/.xinitrc:

    xmodmap /path/to/file

After you've done all this, you can then either use your window
manager configuration file to bind the modifiers to combinations, or run a
separate keybind program like sxhkd to use your now remapped
modifiers. One tiny limitation I've found is that X apparently only
has support for a maximum of 5 modifier keys, but that, at least
for me, covers all of my modifiers.
