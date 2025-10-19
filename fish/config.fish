if status is-interactive

    # ---------------------------------------------------
    # ALIAS STUFF
    # ---------------------------------------------------

    alias ll="ls -lsa"
    alias z="zoxide"
    alias hx="helix"
    # abbr -a hms 'home-manager switch -v --flake ~/.config/home-manager/#default'

    # clipboard stuff
    alias claptrap="pwd | xclip -selection clipboard"
    abbr --add clap "xclip -selection clipboard"

    # used to sudo last command
    abbr !! --position anywhere --function last_history_item

    # ---------------------------------------------------
    # DEFAULT
    # ---------------------------------------------------

    # Is already setup inside home.nix now
    # set -gx EDITOR hx

    # ---------------------------------------------------
    # PATH STUFF
    # ---------------------------------------------------

    # Add home/bin to path (needed for some fish+nix stuff)
    set PATH $HOME/bin $PATH

    # Add cargo pkg to path
    # set -x PATH $HOME/.cargo/bin
    set PATH $PATH ~/.cargo/bin

    # Add go to path
    set -x GOPATH $HOME/go
    set -x PATH $PATH $GOPATH/bin

    # Add JDK to path for Ghidra
    set -x PATH $HOME/jdk-21.0.5+11:$PATH

    # Add dotnet to path
    set -x PATH /usr/local/share/dotnet/:$PATH

    # Add Home Manager environment variables
    test -f "$HOME/.nix-profile/etc/profile.d/hm-session-vars.fish" && . "$HOME/.nix-profile/etc/profile.d/hm-session-vars.fish"

    # No idea what it does
    zoxide init fish | source

    # ---------------------------------------------------
    # SSH Agent (start once per session)
    # ---------------------------------------------------

    # File to store ssh-agent environment
    set -l agent_env_file ~/.ssh/agent_env_fish

    # Check if agent is running and socket is valid
    if not set -q SSH_AUTH_SOCK; or not test -S "$SSH_AUTH_SOCK"
        if test -f $agent_env_file
            source $agent_env_file
        end

        # If still invalid, start a new agent and save environment
        if not set -q SSH_AUTH_SOCK; or not test -S "$SSH_AUTH_SOCK"
            ssh-agent -c | tee $agent_env_file | source
        end
    end

    # Add key if it's not already loaded
    ssh-add -l >/dev/null 2>&1
    or ssh-add ~/.ssh/id_ed25519 >/dev/null

end

status --is-interactive; and pyenv init - | source
