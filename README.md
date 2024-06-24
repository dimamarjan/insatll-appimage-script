# install_appimage.sh

## Description
The `install_appimage.sh` script is used to install AppImage applications on your system. AppImage is a format for distributing portable software on Linux without needing superuser permissions to install the application.

## Usage
1. Make the script executable:
   ```bash
   chmod +x install_appimage.sh
   ```

2. Run the script with the AppImage file as an argument:
   ```bash
   ./install_appimage.sh path/to/your/appimage path/to/your/icon app_name
   ```

3. Follow the on-screen instructions to complete the installation.


## Adding an Alias

To simplify the usage of this script, you can create an alias for it. An alias allows you to run the script with a simple command.

1. Open your shell configuration file:
    - For bash, open `~/.bashrc`.
    - For zsh, open `~/.zshrc`.

2. Add the Alias:
    Add the following line to the end of the file:

    ```bash
    alias installappimage='/path/to/install_appimage.sh'
    ```

    Replace `/path/to/install_appimage.sh` with the actual path to the script.

3. Apply the Changes:
    Reload your shell configuration:

    ```bash
    source ~/.bashrc
    ```

    or

    ```bash
    source ~/.zshrc
    ```


## Example
### Now you can use the script with the alias:

```bash
installappimage /path/to/your/AppImage /path/to/your/icon.png app_name
```

### This makes it easier to run the script without needing to type the full path every time.


#### This `README.md` provides a clear description of the script, its usage, and how to set up an alias for easier use.

