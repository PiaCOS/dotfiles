function odooswitch
    if test (count $argv) -ne 1
        echo "Usage: reposwitch <branch>"
        return 1
    end

    set branch $argv[1]

    # Replace these with absolute paths to your repos
    set repo1 /home/odoo/Dev/odoo
    set repo2 /home/odoo/Dev/enterprise

    echo "Switching $repo1 to $branch"
    git -C $repo1 switch $branch

    echo "Switching $repo2 to $branch"
    git -C $repo2 switch $branch
end
