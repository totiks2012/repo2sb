# repo2sb
This is a bash script for creating sb-modules from deb packages in Debian-based systems. An sb-module is a packaging format used in the Sandbox environment to isolate applications from the system.

Description of how the script works:

The ~/apptool directory is created and we move into it.
The script checks for the presence of the pkg2appimage file, and if it is not found, it downloads it from the GitHub repository.
The necessary dependencies are installed: imagemagick and binutils.
A temporary directory tmp is created and we move into it.
A recipe file recipe.yml is created with the package name, distribution, architecture, and package sources specified.
Using the pkg2appimage utility, packages are downloaded and an APPDIR is created.
The resource catalog is copied to ~/portapps.
The file name is determined from the desktop file and app.png is renamed.
The app.png image is added to ~/portapps/$1.AppDir.
The temporary directory tmp is deleted.
Unnecessary files and directories are removed from AppDir.
A compressed sb-module is created using the mksquashfs utility.
How to work with the script:

Copy the script to a file, for example, create_sbmodule.sh.
Make the file executable: chmod +x create_sbmodule.sh.
Run the script with the name of the deb package as an argument: ./create_sbmodule.sh package_name
After the script finishes running, an sb-module will be created in the ~/portapps directory.
