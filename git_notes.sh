# Git Basics
git config --global user.name "jeddidite" # Sets the global username for Git commits
git config --global user.email "charlesj.persson@gmail.com" # Sets the global username and email for Git commits
git config --global --add init.defualtBranch master # Sets the global username and email for Git commits
git init # Initializes a new Git repository in the current directory
git status # Shows you the status of the files in the repository
git add . # Adds all files in the current directory to the staging area
git commit -m "Adding git notes" # Commits the staged files with a message

# Git Logs and viewing history
git --no-pager log # Shows the commit history in a paginated format
git log --oneline # Shows the commit history in a single line format
git cat-file -p 7777 # Displays the content of the commit with the hash 7777
git config --list --local # Lists the local Git configuration settings
git config --list --global # Lists the global Git configuration settings

# Adding arbitrary configuration settings
git config --add user.name "jeddidite" # Adds a new user name to the global Git configuration
git config --add user.email "charlesj.persson@gmail.com" # Adds a new user email to the global Git configuration
git config --add --local pokemon.ceo "jeddidite" # Adds a new local configuration setting for the repository
git config --add --local pokemon.cto "Quacky" # Adds another local configuration setting for the repository
git config pokemon.ceo # Displays the value of the local configuration setting 'pokemon.ceo'
git config pokemon.cto # Displays the value of the local configuration setting 'pokemon.cto'
git config --unset pokemon.ceo # Removes the local configuration setting 'pokemon.ceo'
git config --unset-all pokemon.ceo # Removes all instances of the local configuration setting 'pokemon.ceo'
git config --unset-all --global pokemon.ceo # Removes all instances of the global configuration setting 'pokemon.ceo'

# git branches
git branch # Lists all branches in the repository
git branch -a # Lists all branches, including remote branches
git branch -m master main # Renames the branch 'master' to 'main'
git switch -c "new-branch" # Creates and switches to a new branch named 'new-branch'
git switch main # Switches to the 'main' branch
git checkout main # Switches to the 'main' branch (alternative old command)

# Setting up SSH configuration with Git
ssh-keygen -t ed25519 -C "charlesj.persson@gmail.com" # Generates a new SSH key pair
Get-Service -Name ssh-agent | Set-Service -StartupType Manual # Sets the ssh-agent service to manual startup
Start-Service ssh-agent # Starts the ssh-agent service
ssh-add C:\Users\Quacky\.ssh\id_ed25519 # # Add your key to the ssh-agent
Get-Content C:\Users\Quacky\.ssh\id_ed25519.pub | Set-Clipboard # Copies the public key to the clipboard
ssh -T git@github.com # Tests the SSH connection to GitHub
cd C:\Users\Quacky\Desktop\pokemon # Changes the directory to the pokemon repository
git remote set-url origin git@github.com:jeddidite/pokemon.git # Sets the remote URL for the repository to use SSH

# Git clone
git clone https://github.com/jeddidite/pokemon # Clones the repository from the specified URL

# Git merging
git fetch # Fetches changes from the remote repository
git log HEAD..origin/main --oneline # Shows the commits that are in the remote 'main' branch but not in the local 'HEAD'
git add git_notes.sh # Adds the file 'git_notes.sh' to the staging area
git commit -m "My local changes to git_notes.sh" # Commits the staged changes with a message
git merge origin/main # Merges the changes from the remote 'main' branch into the current branch

# DANGER COMMANDS BE VERY CAREFUL WHEN USING THE FOLLOWING COMMANDS. CAN CAUSE PERMANENT DATA LOSS
git reset --hard # This discards all uncommitted changes
git clean # This removes untracked files from the working directory
git checkout #(when switching branches)
git pull # This could have overwritten your local files with the remote version
Used git clean -fd # This permanently deletes untracked file