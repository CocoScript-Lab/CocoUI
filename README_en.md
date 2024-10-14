
# Money Display Script

This script provides a NUI (New User Interface) that displays the player's cash, bank balance, black money, job information, rank information, and player ID in a FiveM environment. The script is based on the QBCore framework and updates player information in real-time.

**Note:** In the image, the Player ID is shown below the other boxes, but in reality, it is displayed in the bottom right corner of the screen. Of course, you can freely style it by changing the CSS.

## Features
- **Cash Display:** Displays the player's cash, bank balance, and black money.
- **Job Information:** Displays the player's job name and rank.
- **Player ID:** Displays the player's server ID.
- **Display Settings:** Allows toggling the visibility of each box based on configuration.

## Usage
### Installation of the Script:
- Place the script in the `resources` folder.
- Add `start <resource_name>` to the `server.cfg` file.

### Configuration:
- Open the `Config.lua` file and change the visibility settings for each box. The following options are available:
  - `Config.ShowCash` - Show the cash box
  - `Config.ShowBank` - Show the bank box
  - `Config.ShowBlackMoney` - Show the black money box
  - `Config.ShowJob` - Show the job box
  - `Config.ShowRank` - Show the rank box
  - `Config.ShowPlayerID` - Show the player ID box

### Commands:
- Use the `/moneyon` command to display the UI.
- Use the `/moneyoff` command to hide the UI.

## Dependencies
- QBCore

## Notes
- The script requires the QBCore framework to function properly.
- The display of the NUI may vary depending on server settings.
