function fish_prompt
	test $SSH_TTY
    and printf (set_color red)$USER(set_color brwhite)'@'(set_color yellow)(prompt_hostname)' '
    test "$USER" = 'root'
    and echo (set_color red)"#"

    # Main
    echo -n -e 🐳(set_color brown)(__fish_git_prompt)'\n'(set_color cyan)(prompt_pwd) (set_color red)'❯'(set_color yellow)'❯'(set_color green)'❯ '

    # Virtual Env
    if set -q VIRTUAL_ENV
       echo -n -s (set_color -b black white) "(" (basename "$VIRTUAL_ENV") ")" (set_color normal) " "
    end

    set -l last_status $status

end
