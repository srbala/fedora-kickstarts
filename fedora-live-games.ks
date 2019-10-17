# fedora-live-games.ks
#
# Maintainer:
# - Darryl T. Agostinelli <dagostinelli@gmail.com>
#   https://fedoraproject.org/wiki/User:Dagostinelli
#
# Former Maintainers:
# - Bruno Wolff III <bruno@wolff.to>
#   https://fedoraproject.org/wiki/User:Bruno
#
# - Rahul Sundaram <sundaram@fedoraproject.org>
#   https://fedoraproject.org/wiki/User:Sundaram
#

%include fedora-live-xfce.ks

# The recommended part size for DVDs is too close to use for the games spin
part / --size 14336

%packages

# Wine pulls in i386 libraries under x86_86 making that spin too big.
# Also the point is to show off Fedora games, not running windows games.

-wine

# Remove libreoffice since it just got added to livecd-desktop and
# will likely put the games spin over size and it is freeze time.
-libreoffice*

# Extra screensavers isn't much help for the games spin
-xscreensaver-extras

# Allow joysticks and game pads to work
joystick-support

# games

# traditional (big)

#alienarena #Cut for size
armacycles-ad
asc
asc-music
astromenace
# beneath-a-steel-sky-cd scummvm games cut for size
boswars
bzflag
crossfire-client
extremetuxracer
# flight-of-the-amazon-queen-cd scummvm games cut for size
freeciv
freecol
freedoom
freedroidrpg
frozen-bubble
gl-117
# glob2 - currently broken
lincity-ng
tmw
#maniadrive - currently broken
#maniadrive-music - has been retired
megaglest
nethack-vultures
netpanzer
neverball
nogravity
#pinball # Would pull in fluid-soundfont-lite-patches
scorched3d
# supertux # Crashing
supertuxkart
ultimatestunts
warzone2100
wesnoth
# worminator # Would pull in fluid-soundfont-lite-patches
warmux
xmoto

# traditional (small)

abe
# alex4 # Would pull in fluid-soundfont-lite-patches
# ballz # Would pull in fluid-soundfont-lite-patches
blobwars
bombardier
cdogs-sdl
clanbomber
colossus
foobillard
glaxium
gnubg
gnugo
haxima
hedgewars
kcheckers
knights
lbrickbuster2
# liquidwar # Would pull in fluid-soundfont-lite-patches
lordsawar
# lure scummvm games cut for size
# machineball # Would pull in fluid-soundfont-lite-patches
nethack
openlierox
pachi
pioneers
quarry
# Ri-li cut for size
# rogue # recently abandoned. Someone picked it up. Waiting for approval.
# scorchwentbonkers # Would pull in fluid-soundfont-lite-patches
seahorse-adventures
solarwolf
sopwith
stormbaancoureur
ularn
xblast

# arcade classics(ish) (big)

auriferous
alienblaster
# duel3 # Would pull in fluid-soundfont-lite-patches
powermanga
# raidem # Would pull in fluid-soundfont-lite-patches
# raidem-music # Would pull in fluid-soundfont-lite-patches
trackballs
trackballs-music

# arcade classics(ish) (small)

ballbuster
CriticalMass
dd2
KoboDeluxe
# lacewing # Would pull in fluid-soundfont-lite-patches
Maelstrom
methane
njam
seahorse-adventures
shippy
tecnoballz
wordwarvi
xgalaxy
# zasx # Would pull in fluid-soundfont-lite-patches

# falling blocks games (small) 

amoebax
crack-attack
# crystal-stacker # Would pull in fluid-soundfont-lite-patches
gemdropx
gweled

# puzzles (big)
enigma
fillets-ng
pingus

# puzzles (small)

# gbrainy Removed for space - only game that pulls in mono
magicor
mirrormagic
pipenightdreams
pipepanic
pychess
rocksndiamonds
vodovod

# card games

#poker2d - dropped from F14 for being orphaned
PySolFC

# educational/simulation

bygfoot
celestia
planets
tuxpaint
tuxpaint-stamps
tuxtype2

# kde based games
taxipilot

# compilations (we are avoiding compilations, rare exceptions)
bsd-games

# utilities

games-menus

# Nothing should be downloading data to play.
-autodownloader

%end
