function fish_right_prompt
    set -l d (set_color brgrey)(date "+%R")(set_color normal)

    set_color normal
    printf $d
end
