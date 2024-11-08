cho "\nInstalling zsh...";
sudo dnf install zsh -y;
echo "zsh installed.";

echo "\nInstalling oh-my-zsh...";
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended;
echo "oh-my-zsh installed.";

echo "\nBacking up .zshrc file...";
cp ~/.zshrc ~/.zshrc.bak;
echo "Back up complete.";

echo "\nSetting zsh as default shell...";
chsh -s $(which zsh);
echo "Done.";

echo "\nCopying new .zshrc file...";
cp .zshrc ~/.zshrc;
echo "Done.";

echo "\nInstalling plugins (zsh-autosuggestions and zsh-syntax-highlight)...";
git clone https://github.com/zsh-users/zsh-autosuggestions "${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions";
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git "${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting";
echo "Plugins installed.";

echo "\nInstalling theme (spaceship)...";
git clone https://github.com/spaceship-prompt/spaceship-prompt.git "$ZSH_CUSTOM/themes/spaceship-prompt" --depth=1;
ln -s "$ZSH_CUSTOM/themes/spaceship-prompt/spaceship.zsh-theme" "$ZSH_CUSTOM/themes/spaceship.zsh-theme";
echo "Theme installed.";

echo "\nInstalling neovim...";
curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim-linux64.tar.gz
sudo rm -rf /opt/nvim
sudo tar -C /opt -xzf nvim-linux64.tar.gz
sudo rm -rf nvim-linux64.tar.gz
echo "neovim installed.";

echo "\nInstalling neovim packages dependencies...";
sudo dnf install ripgrep cmake gcc g++ xclip clang-tools-extra;
echo "Dependencies installed.";

echo "\nCopying neovim config...";
mkdir -p ~/.config;
cp .config/nvim ~/.config/nvim -r;
echo "Configuration copied.";

echo "\nInstalling nvm and latest LTS node...;"
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.1/install.sh | bash;
export NVM_DIR="$([ -z "${XDG_CONFIG_HOME-}" ] && printf %s "${HOME}/.nvm" || printf %s "${XDG_CONFIG_HOME}/nvm")"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" # This loads nvm;
nvm install --lts;
corepack enable;
echo "nvm and node installed.";

echo "\nInstalling typescript, tsx, eslint_d, pyright and @johnnymorganz/stylua-bin";
npm i -g typescript tsx eslind_d pyright @johnnymorganz/stylua-bin;
echo "Packages installed.";

echo "\nInstalling go and gopls...";
read -p "Enter go version (ex.: 1.23.2): " go_version;
wget "https://go.dev/dl/go${go_version}.linux-amd64.tar.gz";
sudo rm -rf /usr/local/go && sudo tar -C /usr/local -xzf go1.23.2.linux-amd64.tar.gz;
rm -rf "go${go_version}.linux-amd64.tar.gz";
go install golang.org/x/tools/gopls@latest;
echo "go and gopls installed.";

echo "\nConfiguring git...";
read -p "Enter git user email (also used in GitHub ssh key): " git_email;
read -p "Enter git user name: " git_name;
cd;
mkdir ~/.ssh
echo -ne 'id_github\n\n\n' | ssh-keygen -t ed25519 -C "${git_email}";
mv id_github id_github.pub ~/.ssh;
eval "$(ssh-agent -s)";
ssh-add ~/.ssh/id_github;
xclip -sel c < ~/.ssh/id_github.pub;
git config --global user.name "${git_name}";
git config --global user.email "${git_email}";
git config --global init.defaultBranch main;
git config --global core.editor "nvim";
echo "git configured. Go to GitHub SSH config page (https://github.com/settings/ssh/new). The key is in the clipboard.";

echo "\nInstalling Solaar and copying config...";
sudo dnf install solaar -y;
cp .config/solaar/* ~/.config/solaar/ -r;
echo "Solaar installed and configured.";

echo "\nInstalling ruff (python formatter)...";
curl -LsSf https://astral.sh/ruff/install.sh | sh
echo "Ruff installed.";

echo "\nInstalling lua-language-server...";
read -p "Enter lua lsp version (ex.: 3.11.1): " lua_lsp_ver;
wget "https://github.com/LuaLS/lua-language-server/releases/download/${lua_lsp_ver}/lua-language-server-${lua_lsp_ver}-linux-x64.tar.gz"
sudo mkdir -p /usr/local/lua-lsp;
sudo tar -C /usr/local/lua-lsp -xzf "lua-language-server-${lua_lsp_ver}-linux-x64.tar.gz";
rm -rf "lua-language-server-${lua_lsp_ver}-linux-x64.tar.gz";
echo "Lua LSP installed.";


echo "\nInstalling Gnome extensions...";
array=(
	https://extensions.gnome.org/extension/6162/solaar-extension/
)

for i in "${array[@]}"
do
	EXTENSION_ID=$(curl -s $i | grep -oP 'data-uuid="\K[^"]+')
	VERSION_TAG=$(curl -Lfs "https://extensions.gnome.org/extension-query/?search=$EXTENSION_ID" | jq '.extensions[0] | .shell_version_map | map(.pk) | max')
	wget -O ${EXTENSION_ID}.zip "https://extensions.gnome.org/download-extension/${EXTENSION_ID}.shell-extension.zip?version_tag=$VERSION_TAG"
	gnome-extensions install --force ${EXTENSION_ID}.zip
	if ! gnome-extensions list | grep --quiet ${EXTENSION_ID}; then
        	busctl --user call org.gnome.Shell.Extensions /org/gnome/Shell/Extensions org.gnome.Shell.Extensions InstallRemoteExtension s ${EXTENSION_ID}
	fi
    	gnome-extensions enable ${EXTENSION_ID}
    	rm ${EXTENSION_ID}.zip
done
echo "Gnome extensions installed.";

echo "\nInstalling Docker Desktop...";
sudo dnf -y install dnf-plugins-core;
sudo dnf-3 config-manager --add-repo https://download.docker.com/linux/fedora/docker-ce.repo;
wget https://desktop.docker.com/linux/main/amd64/docker-desktop-x86_64.rpm?utm_source=docker&utm_medium=webreferral&utm_campaign=docs-driven-download-linux-amd64;
sudo dnf install ./docker-desktop-x86_64.rpm -y;
rm ./docker-desktop-x86_64.rpm;
echo "Docker Desktop installed.";

echo "\nInstalling Insomnia...";
read -p "Enter Insomnia version (ex.: 10.1.0): " insomnia_ver;
wget "https://github.com/Kong/insomnia/releases/download/core%40${insomnia_ver}/Insomnia.Core-${insomnia_ver}.rpm";
sudo dnf install ./Insomnia.Core-${insomnia_ver}.rpm -y;
echo "Insomnia installed.";

echo "\nInitializing zsh...";
zsh;
