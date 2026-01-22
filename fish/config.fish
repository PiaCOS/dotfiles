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
    set -gx EDITOR hx

    set -q GHCUP_INSTALL_BASE_PREFIX[1]; or set GHCUP_INSTALL_BASE_PREFIX $HOME ; set -gx PATH $HOME/.cabal/bin /home/elco/.ghcup/bin $PATH # ghcup-env

    # ---------------------------------------------------
    # ALIAS STUFF
    # ---------------------------------------------------

    abbr j "just"
    abbr ll "eza -la"
    # abbr ll "ls -lah"
    # abbr z zoxide
    # abbr hx helix

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

    # Not sure wtf happens inside the 'if' but it works
    function boba
        argparse l/last -- $argv
        or return
        if set -q _flag_last
            $EDITOR (ls -Art -d -1 "$BOBAPATH"/{*,.*} | tail -n 1)
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

    function rfc
        set arg $argv[1]
        set url "https://www.rfc-editor.org/rfc/rfc"
        set ext ".txt"
        curl (string join '' $url $arg $ext) | less
    end


    # ---------------------------------------------------
    # SSH Agent (start once per session)
    # ---------------------------------------------------

    function start_agent
        ssh-agent -c | tee ~/.ssh/agent_env_fish | source
    end

    # set -l agent_env_file ~/.ssh/agent_env_fish
    # if not set -q SSH_AUTH_SOCK; or not test -S "$SSH_AUTH_SOCK"
    #     if test -f $agent_env_file
    #         source $agent_env_file
    #     end
    #     if not set -q SSH_AUTH_SOCK; or not test -S "$SSH_AUTH_SOCK"
    #         ssh-agent -c | tee $agent_env_file | source
    #     end
    # end
    # ssh-add -l >/dev/null 2>&1
    # or ssh-add ~/.ssh/id_ed25519 >/dev/null

    set -l agent_env_file ~/.ssh/agent_env_fish

    if test -f $agent_env_file
        source $agent_env_file 2>/dev/null
    end

    if not set -q SSH_AGENT_PID; or not kill -0 $SSH_AGENT_PID 2>/dev/null; or not test -S "$SSH_AUTH_SOCK"
        echo "Starting new ssh-agent..."
        ssh-agent -c | tee $agent_env_file | source
    end

    if status is-interactive
        ssh-add -l >/dev/null 2>&1
        or begin
            echo "Adding SSH key..."
            ssh-add ~/.ssh/id_ed25519
        end
    end
end
