# Setup steps

## MacOS setup

- Setup Apple ID, Notes, Firefox, Podman

## macOS customizations

- Show app switcher on cmd+tab on all connected displays:
  defaults write com.apple.Dock appswitcher-all-displays -bool true; killall Dock
- Reveal IP address, hostname, OS version, etc. when clicking the clock in the login window
  sudo defaults write /Library/Preferences/com.apple.loginwindow AdminHostInfo HostName
- Increase sound quality for Bluetooth headphones/headsets
  defaults write com.apple.BluetoothAudioAgent "Apple Bitpool Min (editable)" -int 40
- Disable auto-correct
  defaults write NSGlobalDomain NSAutomaticSpellingCorrectionEnabled -bool false
- Save screenshots to the Downloads
  defaults write com.apple.screencapture location -string "${HOME}/Downloads"
- Save screenshots in PNG format (other options: BMP, GIF, JPG, PDF, TIFF)
  defaults write com.apple.screencapture type -string "png"
- Show icons for hard drives, servers, and removable media on the desktop
  defaults write com.apple.finder ShowExternalHardDrivesOnDesktop -bool true
  defaults write com.apple.finder ShowHardDrivesOnDesktop -bool true
  defaults write com.apple.finder ShowMountedServersOnDesktop -bool true
  defaults write com.apple.finder ShowRemovableMediaOnDesktop -bool true
- Finder: show hidden files by default
  defaults write com.apple.finder AppleShowAllFiles -bool true
- Finder: show all filename extensions
  defaults write NSGlobalDomain AppleShowAllExtensions -bool true
- Finder: show status bar
  defaults write com.apple.finder ShowStatusBar -bool true
- Finder: show path bar
  defaults write com.apple.finder ShowPathbar -bool true
- Avoid creating .DS_Store files on network volumes
  defaults write com.apple.desktopservices DSDontWriteNetworkStores -bool true
- Automatically open a new Finder window when a volume is mounted
  defaults write com.apple.frameworks.diskimages auto-open-ro-root -bool true
  defaults write com.apple.frameworks.diskimages auto-open-rw-root -bool true
  defaults write com.apple.finder OpenWindowForNewRemovableDisk -bool true
- Empty Trash securely by default
  defaults write com.apple.finder EmptyTrashSecurely -bool true
- Show the ~/Library folder
  chflags nohidden ~/Library
- Privacy: don’t send search queries to Apple
  defaults write com.apple.Safari UniversalSearchEnabled -bool false
  defaults write com.apple.Safari SuppressSearchSuggestions -bool true
- Show the full URL in the address bar (note: this still hides the scheme)
  defaults write com.apple.Safari ShowFullURLInSmartSearchField -bool true
- Set Safari’s home page to `about:blank` for faster loading
  defaults write com.apple.Safari HomePage -string "about:blank"
- Prevent Safari from opening ‘safe’ files automatically after downloading
  defaults write com.apple.Safari AutoOpenSafeDownloads -bool false
- Enable the Develop menu and the Web Inspector in Safari
  defaults write com.apple.Safari IncludeDevelopMenu -bool true
  defaults write com.apple.Safari WebKitDeveloperExtrasEnabledPreferenceKey -bool true
  defaults write com.apple.Safari com.apple.Safari.ContentPageGroupIdentifier.WebKit2DeveloperExtrasEnabled -bool true
- Add a context menu item for showing the Web Inspector in web views
  defaults write NSGlobalDomain WebKitDeveloperExtras -bool true
- Only use UTF-8 in Terminal.app
  defaults write com.apple.terminal StringEncodings -array 4
- Don’t display the annoying prompt when quitting iTerm
  defaults write com.googlecode.iterm2 PromptOnQuit -bool false
- Disable the sensitive backswipe on trackpads
  defaults write com.google.Chrome AppleEnableSwipeNavigateWithScrolls -bool false
  defaults write com.google.Chrome.canary AppleEnableSwipeNavigateWithScrolls -bool false
- Disable the backswipe on Magic Mouse
  defaults write com.google.Chrome AppleEnableMouseSwipeNavigateWithScrolls -bool false
  defaults write com.google.Chrome.canary AppleEnableMouseSwipeNavigateWithScrolls -bool false
- Use the system-native print preview dialog
  defaults write com.google.Chrome DisablePrintPreview -bool true
  defaults write com.google.Chrome.canary DisablePrintPreview -bool true
- Expand the print dialog by default
  defaults write com.google.Chrome PMPrintingExpandedStateForPrint2 -bool true
  defaults write com.google.Chrome.canary PMPrintingExpandedStateForPrint2 -bool true
- Git clone this repo under `~/.dotfiles`
  `git clone git@github.com:krish7919/dotfiles.git -b initial-configs .dotfiles`
- Install kitty and run these commands
  ln -s ~/.dotfiles/kitty/kitty.conf  ~/.config/kitty/kitty.conf
  ln -s ~/.dotfiles/kitty/Ubuntu.conf ~/.config/kitty/Ubuntu.conf
  ln -s ~/.dotfiles/kitty/diff.conf   ~/.config/kitty/Ubuntu.conf
- Restart Kitty
- Install brew and then:
  brew update && brew upgrade
  brew cask install iterm2 OR brew cask install --appdir="/Applications" iterm2
  brew install wget
  brew install coreutils binutils diffutils gawk gzip screen watch wget jq
  brew install curl-openssl && echo 'export PATH="/opt/homebrew/opt/curl/bin:$PATH"' >> ~/.zshrc
  brew install grc python3 bash less m4 make git perl rsync unzip openssh byobu
  brew install aircrack-ng nmap
  brew install socat tcpflow tcpreplay tcptrace xz git-lfs lua pv rename ssh-copy-id tree
  brew install ed -- --with-default-names
  brew install findutils -- --with-default-names
  brew install gnu-indent -- --with-default-names
  brew install gnu-sed -- --with-default-names  
  brew install gnu-tar -- --with-default-names
  brew install gnu-which -- --with-default-names
  brew install grep -- --with-default-names
  brew install wdiff -- --with-gettext
  brew install libxml2 && brew link libxml2 --force
  brew install libxslt && brew link libxslt --force
- Install Python packages:
  pip3 install virtualenv
  pip3 install virtualenvwrapper
  pip3 install ipython
- Install asdf
  asdf plugin list all
  asdf plugin add golangci-lint
  asdf list all golangci-lint
  asdf list golangci-lint
  asdf install golangci-lint $(asdf latest golangci-lint)
  asdf set --home golangci-lint $(asdf latest golangci-lint)
  asdf plugin update --all
  asdf list
  asdf plugin add golang <https://github.com/asdf-community/asdf-golang.git>
  asdf list all golang
  asdf install golang $(asdf latest golang)
  asdf install golang 1.22.12 # for specific version
  asdf list golang
  asdf set --home golang $(asdf latest golang)
  asdf current golang
- Download iterm2 colorscheme for Ubuntu:
  wget <https://raw.githubusercontent.com/mbadolato/iTerm2-Color-Schemes/master/schemes/Ubuntu.itermcolors>
- Add `source ~/.zshrc` to `~/.zsh_profile` for macOS
- Add the new bash shell installed by brew to the list of allowed shells
  sudo bash -c 'echo /usr/local/bin/bash >> /etc/shells'
- Download script to see repository status in the shell prompt:
  wget <https://raw.githubusercontent.com/git/git/master/contrib/completion/git-prompt.sh> -O ~/.git-prompt.sh
- Set `~/Downloads` as the default location for new Finder windows:
  defaults write com.apple.finder NewWindowTargetPath -string "file://${HOME}/Downloads/"
- Install <https://github.com/juliosueiras/vim-terraform-completion> for Terraform
- Install neovim <https://github.com/neovim/neovim/wiki/Installing-Neovim>
  brew install neovim
  mkdir -p ~/.config/nvim
  ln -s ~/.dotfiles/init.vim ~/.config/nvim/init.vim
  curl -fLo ~/.vim/autoload/plug.vim --create-dirs <https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim>
  git clone <https://github.com/fatih/vim-go.git> ~/.vim/plugged/vim-go
  Open vim and run `:PlugInstall` and `:GoInstallBinaries`
- Setup Zprezto - set up zshrc
  - Open ~/.dotfiles/.zshrc and set up zprezto as per the commands at the top of the file.
  - git checkout krish-customisations and rerun the commands at the top of the file
  - ln -s ~/.dotfiles/.zshrc ~/.zshrc
- Setup VSCode - sync settings after logging into my Github account
- Create Python virtualenv
  Be in the directory under which you want the create the venv
  virtualenv -p $(which python3) venv3 OR /Users/krish.iyer/Library/Python/3.9/bin/virtualenv -p $(which python3) venv3
  . venv3.7/bin/activate
  Alias envpy3 to this directory in `.zshrc` or in the aliases file.
  Deactivate venv (after you are done): deactivate
- Edit `~/.dotfiles/.gitconfig` and add the configs to customize:

    ```toml
    [url "git@gitlab.com:{domain}/"]
        insteadOf = <https://gitlab.com/{domain}/>

    [user]
    email = <{my email}>
    name = Krish

    [core]
    editor = nvim
    excludesfile = ~/.dotfiles/.gitignore_global
        # The following line defines a global .gitattributes file.
        attributesfile = ~/.dotfiles/.gitattributes
        ignorecase = false
    ```

- Softlinks all files from `~/.dotfiles`
  ln -s ~/.dotfiles/.gitconfig ~/.gitconfig
  ln -s ~/.dotfiles/.screenrc ~/.screenrc
  ln -s ~/.dotfiles/.gitignore_global .gitignore_global
  ln -s ~/.dotfiles/.curlrc .curlrc
- TODO
    asdf kubectl
    asdf awscli
    pip3 install e3cmd
