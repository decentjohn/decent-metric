# decent-metric
Metric skin for Decent Espresso

Standing on the shoulders of giants: thanks to John (Insight), Damian (DSV), Sheldon (SWDark)

TODO #1 - general
- Skin colours (dark / light theme)

TODO #2 - fonts
- Remove metric_load_font if John adopts the improvements into the standard load_font function in utils.tcl
- Add new symbols for clean, empty, etc.

TODO #3 - post shot screen
- Add a post shot screen
- Show the key stats (profile, dose, yield, time, temp, date & time)
- Show the shot graph? (options to show different data?) (option to compare with historic shot?)
- Show buttons for Steam and Flush

TODO #4 - espresso screen
- Yield chart should show weight if a scale is connected
- Test functionality of GHC somehow

TODO #5 - shot history
- Display history list as a table showing the key stats (profile, dose, yield, time, temp, date & time)
- Could offer sorting and filtering?
- Could offer "tick to compare" - allow up to 2 selections



Release notes
v0.4 
- Added a timer to the Espresso page
- Rewrote Decent load_font function so that each font only needs to be included once (temporarily included as a Metric function, but hope to get adopted in utils.tcl)
- Added metric_get_font wrapper function so we can load fonts at any size on the fly.
- Swapped water and temp meters on status bar so that they are closer to corresponding meters in Espresso window
- When the water level runs out, it will stay on the most recent menu page
- Detect when DE1 is not connected and disable start buttons (also prevents temp/water warnings and shows in status text)

v0.3 15/01/2020
- Added message to status bar during heating
- Added message to status bar when tank is empty, and removed "tankempty" page so you can stay in the menus
- Disabled espresso, steam, water and flush buttons when machine status is not ready
- Gauges no longer show target if value is zero.
- Weight gauge now shows scale weight if a scale connected, or falls back to volume of water dispensed.

v0.2 10/01/2020
- Separated main menu buttons for easier targetting
- Increased size of action buttons and re-laid out settings menu
- Return to main menu when exiting sleep
- Display target Espresso temperature, pressure and flow using settings from DE1.
- Added simple smoothing algorithm to meters (average of 2 values)

v0.1 06/01/2020
- first Alpha released to Decent Diaspora
