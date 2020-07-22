
echo "Installing dotfiles..."

cwd=$(pwd)

ln -sf $cwd/src/.bash_profile ~/.bash_profile
ln -sf $cwd/src/.bashrc ~/.bashrc

ln -sf $cwd/src/.eslintrc ~/.eslintrc
cp $cwd/src/.eslintrc ~/home/code/agileavatars-wip/

ln -sf $cwd/src/.gitconfig ~/.gitconfig
ln -sf $cwd/src/.zshrc ~/.zshrc
ln -sf $cwd/src/vscode-settings.json "$HOME/Library/Application Support/Code/User/settings.json"

echo "done."
