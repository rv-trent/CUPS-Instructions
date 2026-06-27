# Making a Wired Printer Wireless using a Raspberry Pi - Full Setup Guide

Trenton Hidenfelter, Jacob Hahn

In this guide, you will be led through the process of configuring a Raspberry Pi to transform a wired USB printer into a WiFi-enabled printer, which you can print to wirelessly from any device on your network.


The guide covers the three major steps needed: configuring your Pi, setting up the printing software, and connecting to it from the computer you want to print from. It’s intended for those with little technical experience, but should be usable for anyone with the parts required.


[Making a Wired Printer Wireless using a Raspberry Pi \- Full Setup Guide](#making-a-wired-printer-wireless-using-a-raspberry-pi---full-setup-guide)

[Setting up the Pi](#setting-up-the-pi)

[1\. Preparing the SD Card](#preparing-the-sd-card)

[2\. First time booting of your Pi](#first-time-booting-of-your-pi)

[Setting up the Printer](#setting-up-the-printer)

[1\. SSH-ing into your Pi](#ssh-ing-into-your-pi)

[2\. Setting up the Software](#setting-up-the-software)

[3\. Setting up the Printer System](#setting-up-the-printer-system)

[4\. Adding the Printer Using the Web Interface](#adding-the-printer-using-the-web-interface)

[5\. Adding the Printer to your Computer](#adding-the-printer-to-your-computer)

## 

## Setting up the Pi

\[what is going to be covered in this section, what will follow\]   
What you’ll need:

- [ ] Raspberry Pi 3 B or Zero W or better  
- [ ] Micro-SD card with full-size SD adapter  
- [ ] Appropriate cables  
      - [ ] 5V, 2.5A Micro-USB power supply  
            (Required)  
      - [ ] HDMI cable  
            (If you don’t have access to your router settings)  
      - [ ] Micro-USB to USB-A adapter  
            (Raspberry Pi Zero W, W2)  
      - [ ] Mini-HDMI to HDMI adapter  
            (HDMI cable & Raspberry Pi Zero W, W2)

1. ### Preparing the SD Card

The [Raspberry Pi Imager](https://www.raspberrypi.com/software/) is a software to prepare your SD card for use with your Raspberry Pi. Install Raspberry Pi Imager and insert the SD card into your computer, then launch the Imager program.

After launch, you will see the “Device” screen. Select the device that describes your Pi. For example, if you have a Raspberry Pi Model 3B+, select “Raspberry Pi 3” as shown. Press “Next”.

![][image13]

Now we will choose the correct operating system to run on your Pi. Start by selecting Raspberry Pi OS (other). This will bring up a second menu.

![][image26]

Under the second menu, select “Raspberry Pi OS Lite (32-bit)”. This OS will run on any required Pi model, but if you know your device supports 64-bit, you may choose “Raspberry Pi OS Lite (64-bit)”

![][image12]

After selecting your OS, you will be prompted to select your storage device to store the operating system and data. Make sure your SD card is inserted and choose it from the menu, typically listed as “SDHC Card” or similar. Ensure “Exclude system drives” is **checked**.

![][image22]

The “Customization” menu will ask you a few questions to set up your system. The first is your hostname, which is a name that your Pi uses to identify itself on your network. Choose a memorable name with no spaces or special characters, such as “PrinterPi”.


![][image29]

Next is information about your location and time zone. Be sure to choose the correct capital city for your country, as it is used to determine the proper Wi-Fi protocol to use. None of this information is stored outside of your computer and is not privacy sensitive.

![][image1]

Now you will set up a user account. Choose a username and password you will remember and write them down, as **you cannot recover them later**. This will be used to log in and run certain commands.

![][image27]

To connect your Pi to your Wi-Fi network, you can provide connection details in advance. Enter your Wi-Fi name (SSID) and the password you use to connect. If your network doesn’t require a password, choose “OPEN NETWORK”.

![][image31]

Finally, you must enable SSH, a way to control your Pi from your typical computer. Ensure the slider is on to enable SSH and “Use password authentication” is selected. Skip through the Raspberry Pi Connect screen and leave the feature disabled.

![][image6]

Congrats\! You’re now ready to write your OS and settings to your SD card. Ensure the “Customisations to apply” match the screenshot and select “Write”. A popover menu will appear, warning you that any data on the SD card will be overwritten. If you have any important data on your card that you must save, STOP NOW and move it to your computer. After waiting a few seconds, the menu will allow you to confirm your decision and will begin writing your SD card.

![][image38]

This process will take a few minutes, depending on the speed of the card. Let both the write and verify steps complete without interruption.

![][image19]

2. ### First time booting of your Pi

You are now ready to boot up your Pi for the first time\! Now, depending on if you have access to your router settings and can see device IPs through the management tab of your router, this step is going to be slightly different. If you do not have the ability to view all devices connected to your network, you will need to plug your Pi into a screen using an HDMI cable.

![][image15]

First, insert the micro-SD card into the slot on the bottom of the Pi, boxed in the image. Then, plug in the power supply. The first boot process will take around 3-5 minutes. To confirm that it is finished booting, wait for the green LED on the Pi to stop flashing for at least 10 seconds.

*If your Pi is connected with HDMI:*

If you have your Pi plugged into a screen, it will show information similar to the image below when the boot process is complete.  
The screen shows two IP addresses, and you need the second IP. An example IP is boxed in the image below. Record the IP address as you will need it for future steps\!

![][image16]

*If you have a device list:*

If you have access to the device list on your local network, for example through your router’s management page, locate the Pi there. When you obtain the IP address, record it somewhere since you will need this in later steps.

![][image20]

 Your Pi is now ready to be turned into a server for your printer\!

## Setting up the Printer

1. ### SSH-ing into your Pi

You will now need to run some commands in your command prompt to set things up. When running commands, type them exactly as written, and replace bracketed text without including the square brackets. 

To connect to your Raspberry Pi and set up its software, you’re going to connect to it through a Secure Shell, or SSH. To do this, open your command prompt as an administrator by pressing the WINDOWS key then typing in the search bar “cmd” then clicking the highlighted “Run as administrator” as seen, and run the command ssh \[Pi\_username\]@\[IP\_address\].  
Replace Pi\_username with the name of the user account that you created in Raspberry Pi Imager, and IP\_address with the IP that you found at first boot. Remember to not include the brackets in your command.

![][image33]

Please note, when it asks for your password, use the password you set for your Raspberry Pi when setting it up. You will not be able to see it while you type it. If you are asked if you want to continue with the connection due to security reasons, type ‘yes’.

![][image21]

2. ### Setting up the Software

The first command will update a software called APT, which comes pre-installed on your Raspberry Pi’s operating system. APT manages the installation of other software on your system, and updating it ensures that it has access to the latest software versions when you use it.  
To update APT, run sudo apt-get update. It may ask you for your password (as shown below), and you’ll have to enter it. Once again, you will not be able to see your password as you type it. Next, you will be installing the printing system, called CUPS, using APT. This software will allow you to access your printer over Wi-Fi.  
![][image35]

To install CUPS, run the command sudo apt-get install cups \-y.  
![][image5]

3. ### Setting up the Printer System

You are almost done with the process of entering setup commands. The next set of commands will set up permissions to allow you to access the printer from a remote computer, such as the one you are using right now.  
First, run sudo usermod \-aG lpadmin \[pi\_username\], which allows you to modify printers and their connections to the Raspberry Pi. Remember that pi\_username is the name you entered when creating your user.  
![][image4]

Next, you’re going to enable the sharing and remote access of your printers connected to the Pi by using sudo cupsctl –-share-printers –-remote-any.  
![][image5]

Almost done\! You need to enable the web interface for the printers so you can more easily add new printers and access admin settings. The command to run is sudo cupsctl WebInterface=yes.  
![][image6]

To restart the printing service and apply your changes, run sudo systemctl restart cups. You’ll be running this again later and should run it after you make any changes to CUPS through the command prompt.  
![][image7]

You are done with typing commands for a little bit and now need to open your web browser of choice. Then, type \[IP\_address\]:631 into the address bar. Do not close the command prompt window.

From the above page, you’ll go to the “Administration” tab at the top bar. If you see an error about an upgrade being required, just wait a minute and it’ll automatically bring you to the administration page. At this point, you’ll probably see a security warning, but this is a false alert from your browser and is safe to ignore. Click on “Advanced”. then the link at the bottom that says “Proceed”.

Once you proceed, you’ll see a prompt to log in. Use the credentials for your Raspberry Pi user.

Once you log in, you’ll be taken to the administration page where you can add the printer you have plugged into your Raspberry Pi. Make sure the printer is plugged into any of the USB ports of the Pi and is powered on from this point forward.

4. ### Adding the Printer Using the Web Interface

In the Administration tab, select “Find New Printers”

Next, select “Add This Printer” for whichever printer is plugged into your Raspberry Pi. In the example, it is the Canon LBP6030 printer.

You can now set a custom printer name and description if you so desire, but this is not required and you can choose to continue to the next step without entering anything. Checking “Share This Printer” is also optional because you will be setting this later through a command.

On the next page, you’ll be asked to select the printer driver. You’ll use a “raw queue”, which means the data sent to the printer is exactly what the Pi receives from your computer, without any extra processing. This will mean you’ll need to install a driver onto the client computer you are printing from so that the printer supports the data it is sent, but we’ll handle that later.

To select a raw queue as the driver, find and choose “Raw” from the “Make” dropdown menu, as shown in the first image. Click the continue button. Then, you will see a “Model” dropdown. In this menu, choose “Raw Queue (en)”.

To save the printer and driver, click the “Add Printer” button at the bottom of the options.

Now you'll navigate to the Printers tab in the top bar and select the queue for the printer you just added. Highlight and copy the bold printer name at the top of the page once the queue  has been selected. This will be the printer name you set earlier if you chose a custom one, or the default for your type of printer if you did not.

Switch back to your SSH command prompt. Using the name you just copied, run the command sudo lpadmin \-p \[printer\_name\] \-o printer-is-shared=true. This will make sure the printer is accessible remotely.  
![][image8]

Run the restart command again, and you will be done with the setup\! You can now add the printer to your local computer with the steps below.

![][image9]

5. ### Adding the Printer to your Computer

While you have your printer selected in the “Printers” tab as shown, copy the URL in the address bar, highlighted in the image. Next, open your settings and navigate to Printers & scanners using the search bar, select Add a printer or scanner, then Add a Printer Manually, then “Select a shared printer by name” and paste in the URL you just copied. Change where it says http**s**:// to http:// (no ‘s’) if it is not already.

Next you’ll be asked to select a driver. Install the driver for your printer from the manufacturer’s website if you don’t already have it installed, and choose “Have Disk”. Otherwise, select the driver for your printer if the driver is displayed in the menu. You can find the driver for your printer on the support pages for your printer.

Select OK and you’ll be all set up to use your wired printer wirelessly from your computer\! Make sure your Pi and printer are powered on and connected whenever you plan to print.

[image20]: <./images/image20.jpg>

[image13]: <./images/image13.png>

[image26]: <./images/image26.png>

[image12]: <./images/image12.png>

[image22]: <./images/image22.png>

[image29]: <./images/image29.png>

[image1]: <./images/image1.png>

[image27]: <./images/image27.png>

[image31]: <./images/image31.png>

[image6]: <./images/image6.png>

[image38]: <./images/image38.png>

[image19]: <./images/image19.png>

[image15]: <./images/image15.png>

[image16]: <./images/image16.png>

[image20]: <./images/image20.png>

[image33]: <./images/image33.png>

[image21]: <./images/image21.png>

[image35]: <./images/image35.png>

[image5]: <./images/image5.png>
