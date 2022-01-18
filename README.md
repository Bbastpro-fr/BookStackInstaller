# Book Stack Installer

**BSI** is a bash script designed to **automate** the installation of Book Stack, a simple, open-source, self-hosted, easy-to-use platform for organizing and storing information.
It was created to run on **linux systems**

# Files

- .env : configuration file
- bookstack : configuration file
- BookStackInstaller.sh : script to run installation / uninstallation
- ComposerInstaller.sh : script to run ComposerPHP installation / uninstallation

## Notes

This project was realized in the school context, and is not destined to be really used. However, if you still want to use it, be sure to change the default settings!
**See the dedicated section "Configuration" and "Installation" .**


# Installation

**The installation requires root rights to operate.**
The second requirement is **git**

*1/ Get git on linux*
```bash
sudo apt install git
```
*2/ Download BSI*
```bash
git clone https://github.com/Bbastpro-fr/BookStackInstaller.git
```
*3/ Set Add execution rights*
```bash
cd BookStackInstaller
chmod +x *
```
*4/ Install Composer*
```bash
./ComposerInstaller.sh install
```
*5/ Install Book Stack*
```bash
./BookStackInstaller.sh install
```
This installation will ask you to choose for the configuration of the database, as well as for the execution of Composer.
 >It may be marked as "not recommended" to run these commands as root. **Ignore this**.

## Configuration

TO DO
