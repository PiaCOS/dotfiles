function fish_prompt

    # ----------------- Git ------------------

    set -g __fish_git_prompt_showdirtystate 1
    set -g __fish_git_prompt_showuntrackedfiles 1
    set -g __fish_git_prompt_showupstream informative
    set -g __fish_git_prompt_showcolorhints 1
    set -g __fish_git_prompt_use_informative_chars 1

    # Custom Git Colors
    set -g __fish_git_prompt_color_branch cyan
    set -g __fish_git_prompt_char_dirtystate Δ
    set -g __fish_git_prompt_char_untrackedfiles "?"


    # ----------------- Venv -----------------

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

    # set_color magenta
    # printf ' :: '
    set_color normal
    printf '%s' (fish_vcs_prompt ' (%s) ' 2>/dev/null)

    # ---------------- Line 2 ----------------

    # New line
    echo

    # printf '∇ '
    printf '::|> '
    set_color normal
end
