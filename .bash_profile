# Prefer US English and use UTF-8
export LC_ALL="en_US.UTF-8";
export LANG="en_US";

# Ensure user-installed binaries take precedence
export PATH=/usr/local/bin:$PATH;

# NPM
NPM_PACKAGES="${HOME}/.npm-packages"
PATH="$NPM_PACKAGES/bin:$PATH"

# Unset manpath so we can inherit from /etc/manpath via the `manpath` command
unset MANPATH # delete if you already modified MANPATH elsewhere in your config
export MANPATH="$NPM_PACKAGES/share/man:$(manpath)"

# Load the shell dotfiles:
for file in ~/dotfiles/.{aliases,custom,git-completion.bash,git-prompt.sh}; do
	[ -r "$file" ] && [ -f "$file" ] && source "$file";
done;

# Custom cmd prompt
export GIT_PS1_SHOWDIRTYSTATE=1
export PS1='\w$(__git_ps1 "[%s]") 🐙  '

unset file;
# Case-insensitive globbing (used in pathname expansion)
shopt -s nocaseglob;

# Append to the Bash history file, rather than overwriting it
shopt -s histappend;

# Autocorrect typos in path names when using `cd`
shopt -s cdspell;

# Add tab completion for SSH hostnames based on ~/.ssh/config, ignoring wildcards
[ -e "$HOME/.ssh/config" ] && complete -o "default" -o "nospace" -W "$(grep "^Host" ~/.ssh/config | grep -v "[?*]" | cut -d " " -f2- | tr ' ' '\n')" scp sftp ssh;
