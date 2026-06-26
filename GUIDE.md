# Making a Wired Printer Wireless using a Raspberry Pi - Full Setup Guide

Trenton Hidenfelter, Jacob Hahn

In this document you will be led through the process of setting up a Raspberry Pi to transform a USB printer into a wireless printer.

[Making a Wired Printer Wireless using a Raspberry Pi \- Full Setup Guide](#making-a-wired-printer-wireless-using-a-raspberry-pi---full-setup-guide)

[Setting up the Pi](#setting-up-the-pi)

[1\. Preparing the SD Card](#preparing-the-sd-card)

[2\. Modifying the config files](#modifying-the-config-files)

[3\. First time booting of your Pi](#first-time-booting-of-your-pi)

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

After selecting your OS, you will be prompted to select your storage device to store the operating system and data. Make sure your SD card is inserted and choose it from the menu, typically listed as “SDHC Card” or similar. Ensure “Exclude system drives” is **checked**.

The “Customization” menu will ask you a few questions to set up your system. The first is your hostname, which is a name that your Pi uses to identify itself on your network. Choose a memorable name with no spaces or special characters, such as “PrinterPi”.

Next is information about your location and time zone. Be sure to choose the correct capital city for your country, as it is used to determine the proper Wi-Fi protocol to use. None of this information is stored outside of your computer and is not privacy sensitive.

Now you will set up a user account. Choose a username and password you will remember and write them down, as **you cannot recover them later**. This will be used to log in and run certain commands.

To connect your Pi to your Wi-Fi network, you can provide connection details in advance. Enter your Wi-Fi name (SSID) and the password you use to connect. If your network doesn’t require a password, choose “OPEN NETWORK”.

Finally, you must enable SSH, a way to control your Pi from your typical computer. Ensure the slider is on to enable SSH and “Use password authentication” is selected. Skip through the Raspberry Pi Connect screen and leave the feature disabled.

Congrats\! You’re now ready to write your OS and settings to your SD card. Ensure the “Customisations to apply” match the screenshot and select “Write”. A popover menu will appear, warning you that any data on the SD card will be overwritten. If you have any important data on your card that you must save, STOP NOW and move it to your computer. After waiting a few seconds, the menu will allow you to confirm your decision and will begin writing your SD card.

This process will take a few minutes, depending on the speed of the card. Let both the write and verify steps complete without interruption.

2. ### Modifying the config files

Before inserting the SD card into the Raspberry Pi, there are some text files that need to be modified. Open the SD card’s folders on your computer and locate and open config.txt.  
At the end of the document, below where it says \[all\], add *dtoverlay=dwc2* . Save and close that file and locate the file cmdline.txt.

In the file cmdline.txt, after the word “rootwait”, add *modules-load=dwc2,g\_ether* . Save and close that file then eject the SD card from your computer. You are now all set to get your Raspberry Pi up and running so proceed to the next step\!

3. ### First time booting of your Pi

You are now ready to boot up your Pi for the first time\! Now, depending on if you have access to your router settings and can see device IPs through the management tab of your router, this step is going to be slightly different. If you do not have the ability to view all devices connected to your network, you will need to plug your Pi into a screen using an HDMI cable.

First, insert the micro-SD card into the slot on the bottom of the Pi, boxed in the image. Then, plug in the power supply. The first boot process will take around 3-5 minutes. To confirm that it is finished booting, wait for the green LED on the Pi to stop flashing for at least 10 seconds.

*If your Pi is connected with HDMI:*

If you have your Pi plugged into a screen, it will show information similar to the image below when the boot process is complete.  
The screen shows two IP addresses, and you need the second IP. An example IP is boxed in the image below. Record the IP address as you will need it for future steps\!

*If you have a device list:*

If you have access to the device list on your local network, for example through your router’s management page, locate the Pi there. When you obtain the IP address, record it somewhere since you will need this in later steps.

![][image20]

 Your Pi is now ready to be turned into a server for your printer\!

## Setting up the Printer

1. ### SSH-ing into your Pi

You will now need to run some commands in your command prompt to set things up. When running commands, type them exactly as written, and replace bracketed text without including the square brackets. 

To connect to your Raspberry Pi and set up its software, you’re going to connect to it through a Secure Shell, or SSH. To do this, open your command prompt as an administrator by pressing the WINDOWS key then typing in the search bar “cmd” then clicking the highlighted “Run as administrator” as seen, and run the command ssh \[Pi\_username\]@\[IP\_address\].  
Replace Pi\_username with the name of the user account that you created in Raspberry Pi Imager, and IP\_address with the IP that you found at first boot. Remember to not include the brackets in your command.

Please note, when it asks for your password, use the password you set for your Raspberry Pi when setting it up. You will not be able to see it while you type it. If you are asked if you want to continue with the connection due to security reasons, type ‘yes’.

2. ### Setting up the Software

The first command will update a software called APT, which comes pre-installed on your Raspberry Pi’s operating system. APT manages the installation of other software on your system, and updating it ensures that it has access to the latest software versions when you use it.  
To update APT, run sudo apt-get update. It may ask you for your password (as shown below), and you’ll have to enter it. Once again, you will not be able to see your password as you type it. Next, you will be installing the printing system, called CUPS, using APT. This software will allow you to access your printer over Wi-Fi.  
![][image2]

To install CUPS, run the command sudo apt-get install cups \-y.  
![][image3]

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
*![][image8]*

Run the restart command again, and you will be done with the setup\! You can now add the printer to your local computer with the steps below.

![][image9]

5. ### Adding the Printer to your Computer

While you have your printer selected in the “Printers” tab as shown, copy the URL in the address bar, highlighted in the image. Next, open your settings and navigate to Printers & scanners using the search bar, select Add a printer or scanner, then Add a Printer Manually, then “Select a shared printer by name” and paste in the URL you just copied. Change where it says http**s**:// to http:// (no ‘s’) if it is not already.

Next you’ll be asked to select a driver. Install the driver for your printer from the manufacturer’s website if you don’t already have it installed, and choose “Have Disk”. Otherwise, select the driver for your printer if the driver is displayed in the menu. You can find the driver for your printer on the support pages for your printer.

Select OK and you’ll be all set up to use your wired printer wirelessly from your computer\! Make sure your Pi and printer are powered on and connected whenever you plan to print.

[image20]: <./images/image20.jpg>

[image13]: <./images/image13.png>

[image26]: <./images/image26.png>

[image2]: <data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAYAAAAB8CAIAAADvgvA+AAAEd0lEQVR4Xu3YsYscZRzH4e1d0IixCFiEIwRS2GhikU4I+AfElAELbYTYKKSyCVqlPCQWV1jkGos0hkBAAleIhCts0qVM5T9x/m7fu/fem90zJuTuK8nzFMPMO++8cxuYT3Zn9uTJkw8BTtyf23/NLl++PB0GOH4Vn1k/WFtbm78Bzp07N/wLAEkHAZo+qa+v4eMDx25zc7O2Ozs70xMrA3T9+vVr165dunTp/Pnzs9lseHJXq3XHw0ePHtX26dOntb1///7jx49r58KFC31CO3Uyxvt2w8ffU3/zdAh4RTYXpqMLKwI0O2x4cnftLExGqinfLYzjXWWon639mlyX1GHt9zmTw1fizp07z549m46+eIAePnw4HQJehRUBeuuw4cl9TQwfH0haEaDX3vDxgaTpLyyAEyNAQMxzAnTqi+nIS3vvl+nIS/voqyfToVW2t7enQ8D/yUGA3v9jrxG1PfX17mE5/dvu9p3P56d/3R15+7ODabXT5vSRNrO8+/1i/Pfd8Tpbi7z7497ktlQd1qnaWV6q3fHWrVtXr16dr2rNJ9/8vTx4796927dv11W1f/fu3StXrmxtbbUAbS+Mk2tCGxl3yjinLh/P1sq1rbtMps33M9cn13ZjY2Mc6Yuvr6+3pQ4uhjfboQCVU9/ubltH5vspaYe9EU1Fqukjfb9dNdED1PcrQM3yUlWQs2fP7h0ctvbpDxWgDz7+cjJeT3sPUEtAe/5rqUmAauUHDx60CRcvXuyD45xek9bBpgLU97s+sy1Vt67QzBcL1q3bnLb45M8ApgF6oyx/nekqFi1S/9G/LAUc5TnvgEYn8x/48l2O+ir0opZXBrJWBKge1PbM9180W1tbbbxNaIfLlr8y9EvGa2vZ7f2fS218TMMkE9sL88VPm9r2H0TjtDbYRm7evLn8ZWRylxs3bozj448s4CStCFB1ZHu/QeOr3PYGpLZHPbE9Vb0yban5sGa7dnxHUyM9Df0uy9pr4PmQpK5WqPVr8X6q3X1cdj68DOp3rG2v1VH3BY7PigABnAwBAmIECIgRICBGgIAYAQJiBAiIESAgRoCAGAECYgQIiBEgIEaAgBgBAmIECIgRICBGgIAYAQJiBAiIESAgRoCAGAECYgQIiBEgIEaAgBgBAmIECIgRICBGgIAYAQJiBAiIESAgRoCAGAECYgQIiBEgIEaAgBgBAmIECIgRICBGgIAYAQJiBAiIESAgRoCAGAECYgQIiBEgIEaAgBgBAmIECIgRICBGgIAYAQJiBAiIESAgRoCAGAECYgQIiBEgIEaAgBgBAmIECIgRICBGgIAYAQJiBAiIESAgRoCAGAECYgQIiBEgIEaAgBgBAmIECIgRICBGgIAYAQJiBAiIESAgRoCAGAECYgQIiBEgIEaAgBgBAmIECIgRICBGgIAYAQJiBAiIESAgRoCAGAECYgQIiBEgIEaAgBgBAmIECIgRICBGgIAYAQJiBAiIESAgRoCAmNmZM2emYwDHr+Iz29jYmA4DHL/1n37+Bx6jrOCnW7XlAAAAAElFTkSuQmCC>

[image3]: <data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAYAAAABUCAIAAAAEfXdlAAAC30lEQVR4Xu3XsUodaRjHYS/grJuE6B1so7BNEIvUSi7AbWxkmzSphcUijZDKZgkraVOIRQqbFUFYBIsUYpvOxivJvud8Oo6zCpE1+RPzPMhh5p3vfM4E5oeZWlxc/BXgm6v4TPXPRz+A/vMCWVcBGr6pD1fv8YGvbmNjoz5XV1eHF24M0PT09FRP780dzc3NfZ7oD+v05OSkDtbX1/vzsr+/v7u7e3Z2tj5Rk3ZaX1leXq6r3coaXn3tntTdDkcTvccfOzo6Oj8/r8/BvDk8PFxbWxtO4ce2cWl44Y5uCNCD13t8IOkiQPPz88PX9OGqh73+jwBkXPsfFsC3dOcAzX4cTjpPXo8e/35xUGY+XL/8H49+G06+xPM/Pj97+Wk4vcnp6elw9P+srKwMR7fb2dkZjnru/d7ge3QVoCrL0/ejn34Zf7Z2PH41mvl7fNpK0dIz+8940k5r2c8vxgdP3lysr5/RZYBKrWyL67Ptf22rj+P9Lw4ut2o2Nzdve9srQPXTn9TKetv39vYWFhbqoN7tpaWl4+Pj9pKfTvTX16Xav9a0xd2w/xtr3l2tS1tbW92wWzOaVKZNunndRvtW3Uzbs93AwcHBaLJDDfsHnW7zWtn93nbQ7XmjtjN8j+78FxDAfREgIEaAgBgBAmIECIgRICBGgIAYAQJiBAiIESAgRoCAGAECYgQIiBEgIEaAgBgBAmIECIgRICBGgIAYAQJiBAiIESAgRoCAGAECYgQIiBEgIEaAgBgBAmIECIgRICBGgIAYAQJiBAiIESAgRoCAGAECYgQIiBEgIEaAgBgBAmIECIgRICBGgIAYAQJiBAiIESAgRoCAGAECYgQIiBEgIEaAgBgBAmIECIgRICBGgIAYAQJiBAiIESAgRoCAGAECYgQIiBEgIEaAgBgBAmIECIgRICBGgIAYAQJiBAiIESAgRoCAGAECYgQIiBEgIGbqr+13wxnA1/fn2+1/ASisZU7UxbXKAAAAAElFTkSuQmCC>

[image4]: <data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAYAAAABECAIAAAAHq3X+AAAEMklEQVR4Xu3Xv27TUBiGcV9AjYoK6kIS/pSmzHTjLlDbSHADDEggRaqYYGIGESFGGNiYunEDIETdwhUglq4ggVDHcuyTz7iv4zYh+SiI56dP1qljn9LiPEqTbre7cq493bSa5opNdc38C9Mef1Yqi9+aTnW6I6c15pyPszzFXG5dmO0stS6Onvb/PiE+SbfVjvPoybPtnQ/lvM9237zbrj0rE8zBwcHD+w/iIiir9PXLF8lT8fjW3wPMsVP+3socVNdjTf0/bkZzKCvHJKY1TmWGcZk+McutC8u1TEw0SzLtOPoGc51LjXOpmPp5uaB6TXnm0NzYuBFnf3+//urR8+P7t7i4e/tOOC41zKEAJUmyt7eXFBYXF/v9fji/UkxekFb+YL18/iI+YTevr8VjEZd88XFnN0ztQSzuLRafP32Kx6JB+VZxUV4Q5uPOTpEn2UQ/W40ztbfrXzUxFnER15oGyUS9F9Uz8pL/aFbqiTnUGq3J0TN9YsrRdkw0oxIz49DU6tAUixOYGQaoaX4FaMyJPVoZdab2jDL/1mhHJCgjJvZi4r50ZvRBZjiXp/67ySqjdZhoau2oj779mGSuwdnHqZ5qNv84Pfu28fqJtjratVtP9NQovUGmp05IlmV66kgTXz/o6Sng77PYIEnTvA6n+vmxGpFYjepxYS0/nn41vCZdS+eLexfepmf66emradxqeHttq3jjyK2CuNU4rt17LWfCm3BzKwuLcEzT/A05yLJ0dTO+2qvsHK5M09Xql/HGIO0NykW4N+wTd8i/THtbm6tx57pBkYyw1XCRbVVfjd+u/Kbh25fJKPcMt2xlWby9/EHyiysZjTusbuabh2vL83G36jH8iHO2w1zx76/+BoAToeExjZ+AAGBWyuI8LRAgAH8OAQJwYsribGxsrK+vEyAAf05ZHEGAALjT8BgCBMCdhscQIADuNDyGAAFwp+ExBAiAOw2PIUAA3Gl4DAEC4E7DYwgQAHcaHkOAALjT8BgCBMCdhscQIADuNDyGAAFwp+ExBAiAOw2PIUAA3Gl4DAEC4E7DYwgQAHcaHkOAALjT8BgCBMCdhscQIADuNDyGAAFwp+ExBAiAOw2PIUAA3Gl4DAEC4E7DYwgQAHcaHkOAALjT8BgCBMCdhscQIADuNDyGAAFwp+ExBAiAOw2PIUAA3Gl4DAEC4E7DYwgQAHcaHkOAALjT8BgCBMCdhscQIADuNDyGAAFwp+ExBAiAOw2PIUAA3Gl4DAEC4E7DYwgQAHcaHkOAALjT8BgCBMCdhscQIADuNDyGAAFwp+ExBAiAOw2PIUAA3Gl4DAEC4E7DYwgQAHcaHkOAALjT8BgCBMCdhscQIADuNDyGAAFwp+ExBAiAOw2PIUAA3Gl4DAEC4E7DYwgQAHcaHkOAALjT8Jik0+notQAwUxqeQojPTwgVsS2lG0OWAAAAAElFTkSuQmCC>

[image5]: <data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAYAAAAA/CAIAAABmToj8AAACuUlEQVR4Xu3WoU9VURzA8fcHPKdzIjMSDODmxpgzmGEGmAX/AAlGGpvJQjEQCRgIBigGiozk2AgGpDEbhY1KYmT8wXlcL0cdwoDfJp9PuDv3nHPPu7yN715n5NnzpwA3LuLTaW66t0brGwAy/SFA4+PjnU6nv79/YmIiBq3/3O7+/v7Ozs7R0VG5XV1djWvcjo2NLSwszMzMxMzQ0FD7kcPDw9gwc2JzczN27u3tra+vb29vx+Z4Ksbt/VeoepNG688/Fi+wu7sb12q+iPeP6/DwcL0At9iHU/XC3y0vL9dTfwzQf6/15wOZzvzAAbhJ5wTowad65uG3eqYRS2W170u373P3zuN6tXLvdT3zL0be/njx7ujR0Kt64TdbW1v11KVMTk6WwYUOXFpaqqcurjrkSs68JgcHB/UUnOdXgJp8NIP773vjUooyefdlb/DgY28prqVT0Z0iHiyqM6ujjk/4ejo4PaoYHR0dGBjo3Zw1/OZ7BKg9Mz09HWko+zc2Nkom4rqyshKDuDYFKeK27Iml+KByW2bW1taaysRR5YTFxcUYx2Bubu7cBsWGkokmFvPz87Ozs+Uj2ofHab1nTkxNTcXO5t26J0eVcbs7MRM7y6C9p/0l/E378Gbc/nKa1Xi98inVe8b57a+oDMoGAeISzvkFBHB9BAhII0BAGgEC0ggQkEaAgDQCBKQRICCNAAFpBAhII0BAGgEC0ggQkEaAgDQCBKQRICCNAAFpBAhII0BAGgEC0ggQkEaAgDQCBKQRICCNAAFpBAhII0BAGgEC0ggQkEaAgDQCBKQRICCNAAFpBAhII0BAGgEC0ggQkEaAgDQCBKQRICCNAAFpBAhII0BAGgEC0ggQkEaAgDQCBKQRICCNAAFpBAhII0BAGgEC0ggQkEaAgDQCBKTpDA4+qecArl/E5yfAACpvA3ZCpgAAAABJRU5ErkJggg==>

[image6]: <data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAYAAAABICAIAAABwabWFAAAERUlEQVR4Xu3Wv24cVRiG8S29UgYp4l+HvQG5o8rKDQUllbuEle8BQRFplQK4BRArREtoEcXW9BHFyEg0UCV3ECQQtTkzx+949j2zu7bYzzHx89On1eTMmWNb2nmU0Xg8fmdyb/sc7GjKk7dOeUg55VPllE8x2+ddzeDi7ZjJ0Eq5uHl9cHFw/1XX+3fLFZsNt+zxwW3r1i9zd2XeSztTfEbd+/nVN9/99sezbn759fcffvo5/O0tM7GrZJSn7erkq8z+6my+O7jnfzX2DR5cfOWm/+5tnQ2b191at97d6t/tv+SDi+XdwQPbOZPPv/hy+Nn1x37y6WcbTu42pwBN8qQAnZycHB8fHx0djUajvb29w8PD7u7p6WlzcTD5/smT/YNJmocPP86f6ffLK2nStu5W/tXTVzB/pnn2/Hn+fPHiz3SRjsq3msP9q9z8rI1Tfvu3T/m2b5jy8atOeeZVZ9055c+6SdN97dat377pv7Q7H4uCrRfv/MCt8tnVad9TXxweHZgClBv0z99/+Z7eXASom/1rHsUrTxGagbFHto2/vdcw+ZUr13c7/dd7cLF/6zKLeX1wcd3+lzr5Szy42N3yb/ytm8uHZsOGDbf+24zuAECwt9cYVVX1WppHVdr01tNm6937zfWbX7efP15cv/6g+bybV55W1YMqrVT3q7SSNrzxqDkn3arax8ujzh8sjso/Oh/VPCMfPD5Ln9OPPuxW3n98dnhvZU81W+SL+bJOn7NFXVVTXczOb00vHqnrlf31YnZ+US+6o5JZ+4cky7q5m6XN3fWdds9yPl3UdXdCd5E+q+m8+aym0/R7LJr17qj0VH68blfyr9c/PF1P58t8nf+c9M90UbeaDct5/ut6R53vB24mD4/wP6BXSo5U7hRwc3h4hAABCNcV59sWAQJwfQgQgJemK44hQADCeXiEAAEI5+ERAgQgnIdHCBCAcB4eIUAAwnl4hAABCOfhEQIEIJyHRwgQgHAeHiFAAMJ5eIQAAQjn4RECBCCch0cIEIBwHh4hQADCeXiEAAEI5+ERAgQgnIdHCBCAcB4eIUAAwnl4hAABCOfhEQIEIJyHRwgQgHAeHiFAAMJ5eIQAAQjn4RECBCCch0cIEIBwHh4hQADCeXiEAAEI5+ERAgQgnIdHCBCAcB4eIUAAwnl4hAABCOfhEQIEIJyHRwgQgHAeHiFAAMJ5eIQAAQjn4RECBCCch0cIEIBwHh4hQADCeXiEAAEI5+ERAgQgnIdHCBCAcB4eIUAAwnl4hAABCOfhEQIEIJyHRwgQgHAeHiFAAMJ5eIQAAQjn4RECBCCch0cIEIBwHh4hQADCeXiEAAEI5+ERAgQgnIdHCBCAcB4eIUAAwnl4hAABCOfhEQIEIJyHRwgQgHAeHiFAAMJ5eIQAAQjn4RECBCCch0cIEIBwHh4hQADCeXhkNB6PfS8A7JSHp5Xi8y8TQ3fKl5fe9wAAAABJRU5ErkJggg==>

[image7]: <data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAYAAAABFCAIAAADM96ZbAAAD/klEQVR4Xu3XQWtcVRjG8fsBcsFSQzadqW1Tm67NzoVL91IMtF9BsBAIXUi/QpsGcamIO3GRneAmK3Fx05ZudFGCm2wrVCTLeuaeeW5unpOpk5l5jcH/j5fL6Zk7ZyZ05k9S7e3trV0ZzjeDSXNb018zF2GG089abzHTXO3PrVNnMOW8l+f9Oebm4NpiZ3Vw/fQZ/t8nxae6NRjmefTkqxe/HXTzy7Nfv/3hp+KzMvN4m0jSQicnoL+efYr/u5nnRFn+uTLThmb+ylzrpuzFlLPan2E3/h2Lmxuzzw1NuTOe1fb6Rh5+8bC/X67Lzfuffd6tVyfPiQBVVXV4eFi1VlZWNjc30/5aO+lNjBZXht99/U3+eN375E6+jh5qF8/3n6YpPoXtc9vF7wcH+frHq1f5qLzobkjzfH+/zZMd4vGaZopv6X9qhr1FXnsILAplHfo79lD8eFPKvpwIjUfk7TNnX/rj4TjTFIm5vvDKFHWYFItzmLuf3s1zdHRUPvr2+evP13mRSlQ+2s1xgKac3KO103aKzyhzscY7YkE5ZXIvztyXq4v4LeZ4bs79d5Mq43U40xTtKMe/fky1BADBViao6rpOD9d3Rtfln0fXbPlxu9O7Xm7vuax70lPeaZ+bdt7drC99UOejxk8vjrr0/cSjknxUZ/njl8t1vf7gTX9ztF9/9OGDH/s7W7vN1nqdrmm9sdPU61vjxcZOvmFn48TJTdOkazq728knLOnOut7I++mEdFr6Z7q52dFme37WbWbHr9i+xHgzPbfZTYtdbTbN+LZusVS8yfzjLOl9jn6cdtG9RP4pgIvCwyP8BgQgXFecL1sECMC/hwABODcECMC56YpjCBCAcB4eIUAAwnl4hAABCOfhEQIEIJyHRwgQgHAeHiFAAMJ5eIQAAQjn4RECBCCch0cIEIBwHh4hQADCeXiEAAEI5+ERAgQgnIdHCBCAcB4eIUAAwnl4hAABCOfhEQIEIJyHRwgQgHAeHiFAAMJ5eIQAAQjn4RECBCCch0cIEIBwHh4hQADCeXiEAAEI5+ERAgQgnIdHCBCAcB4eIUAAwnl4hAABCOfhEQIEIJyHRwgQgHAeHiFAAMJ5eIQAAQjn4RECBCCch0cIEIBwHh4hQADCeXiEAAEI5+ERAgQgnIdHCBCAcB4eIUAAwnl4hAABCOfhEQIEIJyHRwgQgHAeHiFAAMJ5eIQAAQjn4RECBCCch0cIEIBwHh4hQADCeXiEAAEI5+ERAgQgnIdHCBCAcB4eIUAAwnl4hAABCOfhEQIEIJyHRwgQgHAeHiFAAMJ5eIQAAQjn4RECBCCch0cIEIBwHh4hQADCeXik2t7e9nsBYKE8PK0Un78BGqDQnMGIPxAAAAAASUVORK5CYII=>

[image8]: <data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAYAAAAA6CAIAAAA2gxlPAAACWElEQVR4Xu3XL24bQRQHYB9gQVNF5QEBJY2Ci0OL0lNUCqoloxLTgAKDFERVgY8QBUYKKPIRAnOF4Ha8r55MJiat0jyp/T4wmn078/aP5Z/sycHBwRuAZ1fCZ1IPhv9G8waAP/Fjoz/xm7YE0OSh5pu7FlftKjc3N2WcTqdtPU6V8eLiYjqKeSwuyryuvL29LfV6+CRKz7Ozs766LYCurq760sbh4eHd3V1fBZ7ClgD65zWPD2Tqf+AAPJv7AHr1fT3uflmPOx+H3W/ryctP6/HF+/sFMYbdz/eVWBNi186HX4ftxrZVu6Vt1Xr97uvb2YN/fEVXOT4+3tvbK5P5fF7G5XJ5fX1dJqvVKhbE4WOXl5ddpW5ZbQybtuUq7YKwHA3bWj0We8sYDctka8+q1KN5WX90dDSMVymT2WwW91b7DOOdRLFuL5XSP559Pop6rCmnomcV9a553MAwdjg5OalNWvUlnJ+fd6fitdR6XKLeQDcPi8Wi1oem+bD5IOqnGadOT0/r4u59tu8nRPOuODSPGVajOq8jT84vICCNAALSCCAgjQAC0gggII0AAtIIICCNAALSCCAgjQAC0gggII0AAtIIICCNAALSCCAgjQAC0gggII0AAtIIICCNAALSCCAgjQAC0gggII0AAtIIICCNAALSCCAgjQAC0gggII0AAtIIICCNAALSCCAgjQAC0gggII0AAtIIICCNAALSCCAgjQAC0gggII0AAtIIICCNAALSCCAgjQAC0gggII0AAtIIICCNAALSCCAgzWR/f7+vAfx9JXx+AhJdISArld0YAAAAAElFTkSuQmCC>

[image9]: <data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAYAAAABSCAIAAADSJJR4AAAEtElEQVR4Xu3YT2tcVRzG8XkBc6GlhkBipn+TtKsKzUa6cBV8A8KAvgF3CgOhK125tjQRl7pw5ypZScAuJYsovgApvoIKiut45p55bm+fc6fMOPObVvP98GM4OXPmJiFzvwzpnZ2dvXv/nbtvD+aZrVnmHvN/mMHsU7xPZpzrNrvlbM0+N/LsLDQ3t5c9d8Zzy2dweWfv/oMUn97drUGa3a3BR8MPyyneK3NNLlF7TZ5WMIOuha1fNflP1iyWMZ6YqbnZmj03i1cmzc2ltKaOi6a4096Qud01rf3b9Uw26/3xl+X6jk62181FmjPtw+0fw6a3W9cnzZdPvh6NRhsbG/v7+ycnJ71azlOaX3/+Jb+Zfjw9zYsvPvs8Ly4uLvLi92fP8rF0pjn23Tff5gPp2TR58cfz5/kK+al8uH7HvxSp9OzT09N7RbwuWb/maMe0yX+LmPGgdM4in2iKavzrWSg36kszfi9FTJGMfMOvetKdWG7OMn//9We52Z4XAfr0k1E5zbPjRuQYNe88tal4R65ymiR1bs4xxW0/dcrD7Z167Xd++8vgHASNB6WdlY6+NJ9lZm3NDT2W1Zh3FqrMdsxnmaIjneM352WYXv2Hn1RmkXndJWJmnOt6bC86srJATTpn8q+ZxSuzXc+Clcmj1ngvZp8iIm9cU261xjbLw6ufXn+KtceVb0135XG19tPU83Nd6tUefvzEt7oMD899a9nOk8Oh7wLosj5Fr6rGdag+GD+2I5Kr0X68Vp+5pjPpJVfq16adt0bV1QdVvtTk5cWlrn4/9VJJvlRj7f3f1qpq79FFe3O8X7338NEP7Z2D4/ODvSo99uvuVHsHk8XwMB84HL505dSN9Jiu3ezkK/R1sqomWUlXSFdLX6bDTWvy9TML0IvvWH+LyWZ67flxWhxrM3XLFv3ih8y/Tl8/5/jXqRfNt8i/BfBf4eGRqZ+AAGBZPDxCgACEa4rzVY0AAVgdAgTgtWmKYwgQgHAeHiFAAMJ5eIQAAQjn4RECBCCch0cIEIBwHh4hQADCeXiEAAEI5+ERAgQgnIdHCBCAcB4eIUAAwnl4hAABCOfhEQIEIJyHRwgQgHAeHiFAAMJ5eIQAAQjn4RECBCCch0cIEIBwHh4hQADCeXiEAAEI5+ERAgQgnIdHCBCAcB4eIUAAwnl4hAABCOfhEQIEIJyHRwgQgHAeHiFAAMJ5eIQAAQjn4RECBCCch0cIEIBwHh4hQADCeXiEAAEI5+ERAgQgnIdHCBCAcB4eIUAAwnl4hAABCOfhEQIEIJyHRwgQgHAeHiFAAMJ5eIQAAQjn4RECBCCch0cIEIBwHh4hQADCeXiEAAEI5+ERAgQgnIdHCBCAcB4eIUAAwnl4hAABCOfhEQIEIJyHRwgQgHAeHiFAAMJ5eIQAAQjn4RECBCCch0cIEIBwHh4hQADCeXiEAAEI5+ERAgQgnIdHCBCAcB4eIUAAwnl4hAABCOfhEQIEIJyHRwgQgHAeHiFAAMJ5eIQAAQjn4RECBCCch0cIEIBwHh4hQADCeXiEAAEI5+ERAgQgnIdHCBCAcB4eIUAAwnl4pHd0dLS5uenHAWB5PDzr6zs7Oyk+/wBdwvs/Mgv02AAAAABJRU5ErkJggg==>
