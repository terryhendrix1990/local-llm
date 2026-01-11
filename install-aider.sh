#!/bin/bash
set -e

# 1️⃣ Ensure ~/bin exists
mkdir -p "$HOME/bin"

# 2️⃣ Installation path
SCRIPT="$HOME/bin/aider"

# Copy aider script
echo "Installing $(dirname "$0")/aider.sh to $SCRIPT"
sudo cp "$(dirname "$0")/aider.sh" "$SCRIPT"
chmod +x "$SCRIPT"
echo "Installed aider $SCRIPT. You can run it with the command 'aider'."

# 3️⃣ Check which profiles exist
PROFILE_PATHS=()
PROFILE_NAMES=()

[[ -f "$HOME/.bash_profile" ]] && PROFILE_PATHS+=("$HOME/.bash_profile") && PROFILE_NAMES+=("~/.bash_profile")
[[ -f "$HOME/.zprofile" ]] && PROFILE_PATHS+=("$HOME/.zprofile") && PROFILE_NAMES+=("~/.zprofile")
[[ -f "$HOME/.profile" ]] && PROFILE_PATHS+=("$HOME/.profile") && PROFILE_NAMES+=("~/.profile")

# If no profiles exist, fail
if [ ${#PROFILE_PATHS[@]} -eq 0 ]; then
    echo "No existing profile found. Please create one of the following files: ~/.bash_profile, ~/.zprofile, or ~/.profile."
    exit 1
fi

# Ask user to select from existing profiles
echo "Select which profile to update PATH:"
for i in "${!PROFILE_PATHS[@]}"; do
    printf "%s) %s\n" "$((i+1))" "${PROFILE_NAMES[i]}"
done
read -p "Enter number: " choice

# Validate choice
if [[ $choice -ge 1 && $choice -le ${#PROFILE_PATHS[@]} ]]; then
    PROFILE="${PROFILE_PATHS[$((choice-1))]}"
else
    echo "Invalid choice. Please select a valid profile."
    exit 1
fi

# 4️⃣ Add ~/bin to PATH if not already
if ! grep -q 'export PATH=.*$HOME/bin' "$PROFILE"; then
    echo 'export PATH="$PATH:$HOME/bin"' >> "$PROFILE"
    echo "Added ~/bin to PATH in $PROFILE"
    echo "Installation complete. Restart your terminal or run 'source $PROFILE'."
else
    echo "~/bin is already in PATH in $PROFILE"
    echo "Installation complete."
fi

