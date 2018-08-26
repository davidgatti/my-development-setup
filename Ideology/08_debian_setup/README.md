# Debian Setup

### One time

- remove the PATH reset in /etc/sudoers. It's likely a rule called secure_path - remove this line to allow Sudoers to use their default PATHs and not be replaced by the safe ones

### For each user

- sudo curl -o- https://raw.githubusercontent.com/creationix/nvm/v0.33.6/install.sh | bash

# Auto Installer

```
sh -c "$(curl -fsSL https://raw.githubusercontent.com/davidgatti/my-development-setup/master/14_debian_setup/install.sh)"
```