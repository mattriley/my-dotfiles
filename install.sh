
echo "Installing dotfiles..."

cwd=$(pwd)

ln -sf $cwd/src/.bash_profile ~/.bash_profile
ln -sf $cwd/src/.bashrc ~/.bashrc
ln -sf $cwd/src/.gitconfig ~/.gitconfig
ln -sf $cwd/src/.zshrc ~/.zshrc

echo "done."
