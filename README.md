
# My home-manager files

## Description

These files are provided as an example. I implemented a simple module system to
help split the configuration into relevant semantic units. Maybe the nixpkgs
module system could have used.

## Setup of a new PC

These instruction are for me.

 - clone this to ~/.config/nixpkgs
 - run 'home-manager switch'
 - Setup in two git-annex in the data partition, one for files and one for comics
 - Create a downloads directory there
 - Link the data partition to ~/data
 - Link : 
   + ~/data/annex/div/comics -> ~/data/comics
   + ~/div       -> ~/data/annex/div
   + ~/hobbies   -> ~/data/annex/hobbies
   + ~/irl       -> ~/data/annex/irl
   +  ~/school    -> ~/data/annex/school
   + ~/downloads -> ~/data/downloads
 - Copy the ssh keys to ~/.ssh
 - Copy the gnupg keys to ~/.gnupg
 - Copy the pass store to ~/.password-store
 - Copy the calendar files to $XDG_DATA_HOME/remind



## TODO

 - [ ] Make QT use the same theme as GTK
 - [ ] Install a GTK-2 theme
 - [ ] Make the GTK theme have the same colors as the base16 color theme
 - [ ] Configure vixen
 - [ ] Make rofi-tab-switcher work
 - [ ] Improve my mail workflow (local copy of notmuch + muchsync)
 - [ ] Setup a RSS reader
 - [ ] Setup hledger
 - [ ] Improve my remind workflow
 - [ ] Setup MPD

