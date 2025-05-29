# Mobile Space Dock #

A ship for endless sky game, that allows for local outfitter "Navy Mobile Space Dock Outfitter" deployment on planets 
and stations lacking outfitter (or a spaceport). Be warned, this is not a late-game combat vessel. Rather a fragile
utility vessel that needs a careful handling later in the game.   

To obtain the ship be sufficiently proficient in combat (way above average) and watch for the mixed messages in news
concerning new Navy capital ship projects from Navy Design Bureau or admiral Connors. The golden rule is to believe only
in news that have been officially denied! There will be the only chance to obtain the vessel so be careful.

version: 0.9\
ES compatible: 10.12

### Technical note ###
The mission to deploy/pack dock is in form of preprocessed planet list from "map planets.txt" from endless sky source. 
Each mission id defined of one empty planet/station. If you have bash

Mission file generation is done via bash script and jinja2 templates for Job Board missions for planets with spaceport
and landing pop-up conversations for barren planets.

The mod does not deploy sprites around the object and does not use the latest code updates as "to sell". Also, it 
ignores the 

    source
      attributes outfitter

in location selection, so it ignores any game instance changes due to story progression.

### Issues ###
* Log section cannot be cleaned and written in the same "to accept" instance. This results in empty log section. Thus
each time you deploy/pack, your MSD log get additional entry in Deployment section.
* Action of adding and removing outfitter are not cancelling each other. THus after repeated deployment, your save will 
contain multiple repeated entries with the same plane name: planet add outfitter \n planet remove outfitter ... And so 
on. 
* Cannot add sprite. Would be coo, but the event allows for adding object sprite, but not nested objects. In case of
this ship, it should always be added nested and orbiting some planet. 
* Swizzle is obviously working wrong.

### ToDo ###
* Add proper graphics instead of gimp-cleaned screenshots of Felipe Castro Space Dock.
* Add x2 HiDPI variants.
* Add sprite on deployment.
* Consider some consumables of monetary cost of deployment to balance again enormous advantages.
* Clean outfitter list to bare minimum.
* Think on optional missions to obtain outfit templates to add them to "Navy Mobile Space Dock outfitter"
* The initial mission could be harder and even have some negative consequences such as reputation with Republic, bounty, 
fine or story with a legal battle to keep it. Again, to balance the advantages.
* Make final news after acquisition mission to fade after some time. Having them appear till the end of game is immersion
breaking.
