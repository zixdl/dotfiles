# Custom functions for zsh

# --- Files and directories ---
# mkdir + cd
mkcd() {
    mkdir -p "$1" && cd "$1"
}

# Copy current directory to clipboard
pwdc() {
    pwd | pbcopy
    echo "Current directory copied to clipboard: $(pwd)"
}
# --- End of Files and directories ---

# --- Finder ---
# Open current directory in Finder
finder() {
    open .
}
# --- End of Finder ---

# --- Git functions ---
# quick commit
gcm () {
    git add .
    git commit -m "$1"
}

# commit and push
gcmp () {
    git add .
    git commit -m "$1"
    git push
}

# pretty log
glog () {
    git log --oneline --graph --decorate --all
}
# --- End of Git functions ---
