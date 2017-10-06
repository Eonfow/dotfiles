# Aliases
```
ln -s ~/workspace/dotfiles/.bash_aliases ~/.bash_aliases
ln -s ~/workspace/dotfiles/.bash_wow_aliases ~/.bash_wow_aliases
touch ~/.bash_work_aliases
source ~/.bashrc
```

#NVM
```
curl -o- https://raw.githubusercontent.com/creationix/nvm/v0.33.5/install.sh | bash
nvm install v8
nvm use v8
source ~/.bashrc
npm completion > ~/.npm_completion
echo ". ~/.npm_completion" >> ~/.bashrc
source ~/.bashrc
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