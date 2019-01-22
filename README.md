# squad-tactical-game
An XCOM-like, turn-based tactical game made in Ruby/Tk from a 2D, top-down perspective.

The player controls a team of five blue soldiers, with the goal being to eliminate the enemy red soldiers by attacking them 
several times.

While I did not complete the enemy AI code, I implemented the A* pathfinding algorithm, allowing players to 
select a soldier, click on a destination and have a soldier find the shortest path there around obstacles. This was 
fascinating to learn about and I hope to make use of it in further projects.

To play, make sure that you have recent versions of Ruby and Tk installed, navigate to the squad-tactical-game folder, 
and run `ruby project-1.rb`

## Controls
**Left-click on a blue soldier** - Selects that soldier, displaying his stats in the right sidebar. 
Remains selected until you press the deselect soldier button or you perform an action (ex: attacking someone)

**Right-click on the currently-selected soldier** - Shows contextual menu with some actions that soldier can take. 
Info shows a window with a short description of the soldier, Overwatch allows the soldier to shoot any enemy that moves
within a few squares during the opponent's turn, Take Cover makes the selected soldier harder to hit.

**Right-click on a soldier who isn't the selected soldier** - Shows contextual menu showing chance to hit (HC) as a percentage 
that decreases as distance increases. Click the Attack button in this menu to attempt to attack that soldier.

**End turn button in right side-menu** - When you're done with all of your moves, press this button to let the Red Team move.
One Red Soldier should move 5 squares to the right of the right-most blue soldier at the end of the prior turn.
