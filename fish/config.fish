if status is-interactive
    # ---------------------------------------------------
    # PATH STUFF
    # ---------------------------------------------------

    fish_add_path $HOME/bin
    # Rust apps installed with cargo
    fish_add_path $HOME/.cargo/bin
    # Go apps installed with go (having a GOPATH is not mandatory anymore)
    fish_add_path $HOME/go/bin
    # Used for Ghidra
    fish_add_path $HOME/jdk-21.0.5+11
    # Used for Unity (might delete at some point) 
    fish_add_path /usr/local/share/dotnet

    # No idea what it does (prob. doing a setup with fish compatibility)
    zoxide init fish | source

    if not set -q BOBAPATH
        set -gx BOBAPATH $HOME/Dev/boba
    end

    set -gx EDITOR helix

    # ---------------------------------------------------
    # ALIAS STUFF
    # ---------------------------------------------------

    abbr ll "ls -lah"
    # abbr z zoxide
    abbr hx helix

    # used to sudo last command
    abbr !! --position anywhere --function last_history_item
    abbr --add --position anywhere -- !! 'history --max 1 | string match -r " (.*)" | string trim --left'

    # clipboard stuff
    abbr claptrap "pwd | xclip -selection clipboard"
    abbr --add clap "xclip -selection clipboard"

    alias creepy "xclip -selection clipboard"
    alias pasta "xclip -o -selection clipboard"

    alias deathnote "ps -ef | fzf -m | awk '{print \$2}' | creepy"
    alias instakill "pasta | xargs -p kill -9; xclip -selection clipboard /dev/null"

    # cool stuff
    function choco
        set arg $argv[1]
        mkdir $arg
        cd $arg
    end

    # If i need more arg i just have to add like 'f/first' after last
    # and add an 'else if' scope on '_flag_first'.
    function boba
        argparse l/last -- $argv
        or return
        if set -q _flag_last
            $EDITOR (ls -Art $BOBAPATH | tail -n 1)
        else
            set dt (date '+%Y%m%d_%H%M%S.md')
            $EDITOR $BOBAPATH/$dt
        end
    end

    function when
        date '+%Y-%m-%d %H:%M:%S'
        printf '\n'
        cal
    end

    # ---------------------------------------------------
    # SSH Agent (start once per session)
    # ---------------------------------------------------

    set -l agent_env_file ~/.ssh/agent_env_fish
    if not set -q SSH_AUTH_SOCK; or not test -S "$SSH_AUTH_SOCK"
        if test -f $agent_env_file
            source $agent_env_file
        end
        if not set -q SSH_AUTH_SOCK; or not test -S "$SSH_AUTH_SOCK"
            ssh-agent -c | tee $agent_env_file | source
        end
    end
    ssh-add -l >/dev/null 2>&1
    or ssh-add ~/.ssh/id_ed25519 >/dev/null
end
