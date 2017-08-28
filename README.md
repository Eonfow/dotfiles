# Aliases

```
    ln -s ~/workspace/dotfiles/.bash_aliases ~/.bash_aliases
    source ~/.bashrc
    ln -s ~/workspace/dotfiles/.bash_wow_aliases ~/.bash_wow_aliases
    touch ~/.bash_work_aliases
```


# VSCode
```
    ln -f -s ~/workspace/dotfiles/.vscode/settings.json ~/.config/Code/User/settings.json

    input="/home/$USER/workspace/dotfiles/.vscode/extensions"
    while IFS= read -r var
    do
    code --install-extension "$var"
    done < "$input"
```