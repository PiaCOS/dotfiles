function fish_prompt
    if not set -q VIRTUAL_ENV_DISABLE_PROMPT
        set -g VIRTUAL_ENV_DISABLE_PROMPT true
    end

    # ---------------- Line 1 ----------------

    set_color normal
    printf 'λ '

    if test -n "$VIRTUAL_ENV"
        printf "(%s) " (set_color blue)(basename $VIRTUAL_ENV)(set_color normal)
    end

    set_color magenta
    printf ':: '
    set_color yellow
    printf '%s' $USER
    set_color normal
    printf ' -> '

    set_color $fish_color_cwd
    printf '%s' (prompt_pwd)
    set_color normal

    # ---------------- Line 2 ----------------

    # New line
    echo

    # printf '∇ '
    printf '::|> '
    set_color normal
end
