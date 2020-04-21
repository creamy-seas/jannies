#!/usr/bin/env bash

if [ -z $(which markdown-pdf) ]; then
    echo -e "卍 Big mistake 卍\nInstall markdown-pdf: https://github.com/alanshaw/markdown-pdf"
    exit
fi

# Select plugin
PLUGIN_SELECTION=$(ls -l ~/.oh-my-zsh/plugins | awk '{print $9}' | sed 's|.oh-my-zsh/plugins/||g' | fzf)
echo "🐳 Generating for ----------$PLUGIN_SELECTION----------. Please wait like 5 seconds"

# Generate markdown
markdown-pdf -o "/tmp/zsh_readme.pdf" "$HOME/.oh-my-zsh/plugins/$PLUGIN_SELECTION/README.md" && open /tmp/zsh_readme.pdf &


