# timenode
Auto install script for TimeIsMoney (TIM)


# TimeIsMoney (TIM) Masternode Install Script
# Use this script on a fresh install of Ubuntu 16.04 (not lower)

# This guide is meant for setting up a HOT/COLD SETUP WITH LINUX.


# STEP 1 - Sending Collateral Coins

0. Download the latest wallet from : https://github.com/rmcpartner/timeismoneycrypto/releases and install it.
1. Open your Windows wallet - MAKE SURE IT IS SYNCED 
2. Go to Tools -> Debug Console
3. Type: getaccountaddress MN# (# is your masternode number you want to use)
4. In the Debug Console Type: masternode genkey
5. Send 1000 TIM to this address 
6. Type: masternode outputs (This can take a few minutes before an output is shown)
7. Save your TX ID (The first number) and your Index Number (Second number, either a 1 or 0)
8. Save your generated key as well as this will be needed in your VPS as your private key
9. Save these in a notepad
10. Close the wallet


# STEP 2 - Setting up your Linux VPS (Read all instructions and follow prompts closely)

1. Connect to your linux vps AS ROOT (AWS USERS USE sudo -i TO LOGIN AS ROOT), copy and paste the following line into your VPS.  Double click to highlight the entire line, copy it, and right click into Putty or Shift + Insert to paste.
```
cd && sudo apt-get install p7zip-full -y && sudo apt-get -y install git && sudo git clone https://github.com/LEGENDSTER/timenode.git && cd timenode/ && sudo bash install.sh && cd 

```
2. follow the prompts carefully!

# STEP 3 - Editing your Windows Config File

1. Open your wallet
2. Go to Tools -> Open Masternode Configuration File
3. Enter the following on one single line after the example configuration
```<alias> <ip>:11334 <private_key> <tx_id> <index>```
4. It should look something like this:
``` mn1 127.0.0.2:11334 93HaYBVUCYjEMeeH1Y4sBGLALQZE1Yc1K64xiqgX37tGBDQL8Xg 572ae2c7135a8da2c1dbf2866240ec209a113f2851104c4e3e9b83e6cb7f0b3d 1```
5. Save and close the file and restart your wallet.

# STEP 4 - Starting the Masternode

1. In your wallet, go to Tools -> Debug Console
2. Enter ```masternode start-alias <alias>``` with ```<alias>``` being the name of your masternode from Part 3
3. Enjoy!  You can start this process over again for another MN on a fresh Linux VPS!

# Part 5 - Checking Masternode Status

1. After running the command in step 4, go back to your VPS
2. Enter ```cd``` to get back to your root directory
3. Enter ```timeismoney-cli mnsync status``` A synced wallet will show sync status value as true and assets as 999.
4. Enter ```timeismoney-cli masternode status``` : It should show your vin, service (IP), public key and activation status.
5. This will tell you the status of your masternode, any questions, please ask the developers.

# CONSIDER SENDING SOME TIPS TO : TfQRT6o71jhETKw3cdQWLjkqQMrBKTK6ga
