# Zsh instead of Bash

<div align="center">
	<img src="https://raw.githubusercontent.com/davidgatti/my-development-setup/master/08_Zsh_instead_of_Bash/images/zsh.png">
</div>

Bash is the default shell basically everywhere but everywher-ness doesn't mean beter-ness. One of the most powerful aspect of Zsh is the auto-completion feature that is not just helping you with the `cd` command, but Zsh will also for example auto-complete the parameters of a command or even propose which processes to kill.

Bellow I created a script that will automatically perform the switch. Please take a moment to go over the [install.sh](https://github.com/davidgatti/my-development-setup/blob/master/08_Zsh_instead_of_Bash/install.sh) before running this command - destruction might apply.

# Auto Installer

```
sh -c "$(curl -fsSL https://raw.githubusercontent.com/davidgatti/my-development-setup/master/08_Zsh_instead_of_Bash/install.sh)"
```