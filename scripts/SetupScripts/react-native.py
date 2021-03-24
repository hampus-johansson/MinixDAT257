import os
import functions as f
import platform

install = input("\nDo you want install React Native? y/n \n")

if (install == "y"):
    print("\n Choose a CLI type and a project name to create your React Native project\n")

    cli_type = input("\n CLI type: \n 1. Expo \n 2. React \n ")

    # if CLI type input is incorrect
    while ((cli_type != "1") and (cli_type != "2")):
        cli_type = input("CLI type incorrect! Please choose a valid CLI type. Insert 1 for Expo, or 2 for React. ")

    project_name = input("Poject name: ")
    print("")

    if (platform.system() == "Linux"):
        # update package then install node and npm
        os.system("sudo apt update")
        os.system("sudo apt install nodejs")
        os.system("sudo apt install npm")
        print("")

    if (cli_type == "1"):
        f.expo(project_name)
    else:
        dev_platform_name = "Android Studio"
        download_source = "https://developer.android.com/studio"

        if (platform.system() == "Darwin"):
            dev_platform = input("Do you want to React Native for iOS or Android? \n 1. iOS \n 2. Android \n  ")
            if (dev_platform == "1"):
                dev_platform_name = "Xcode"
                download_source = "https://apps.apple.com/us/app/xcode/id497799835?mt=12"

        asInstalled = input("To use React CLI, you need to install " + dev_platform_name + ". \nIs it already installed? y/n ")

        if (asInstalled == "y"):
            f.react(project_name, dev_platform_name)
        else:
            print("\nYou can download from " + download_source + "\n")
