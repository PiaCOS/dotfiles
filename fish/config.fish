if status is-interactive
    # Commands to run in interactive sessions can go here
    
    # ---------------------------------------------------
    # ALIAS STUFF
    # ---------------------------------------------------
    
    alias ll="ls -lsa"

    # ---------------------------------------------------
    # PATH STUFF
    # ---------------------------------------------------
    
    # Add cargo to path
    # set -x PATH $HOME/.cargo/bin
    set PATH $PATH ~/.cargo/bin

    # Add go to path
    set -x GOPATH $HOME/go
    set -x PATH $PATH $GOPATH/bin

    # Add JDK to path for Ghidra
    set -x PATH $HOME/jdk-21.0.5+11:$PATH

    # Add dotnet to path
    set -x PATH /usr/local/share/dotnet/:$PATH

end
