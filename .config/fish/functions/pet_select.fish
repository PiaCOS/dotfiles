function pet_select
    set -l query (commandline)
    pet search --query "$query" $argv | read cmd
    commandline $cmd
end
