{
  programs.git = {
    enable = true;
    userName = "nikolaia";
    userEmail = "nikolai@stasj.com";
    extraConfig = {
      user = {
        signingKey = "4E548DA00E9B10E5470AAA4CD9E872DE8210DCF7";
      };
      core = {
        excludesfile = "~/.gitignore_global";
        editor = "nvim";
      };
      push = {
        default = "simple";
      };
      init = {
        defaultBranch = "main";
      };
      filter = {
        lfs = {
          clean = "git-lfs clean -- %f";
          smudge = "git-lfs smudge -- %f";
          required = true;
          process = "git-lfs filter-process";
        };
      };
    };
    aliases = {
      co = "checkout";
      ec = "config --global -e";
      up = "!git pull --rebase --prune $@ && git submodule update --init --recursive";
      cob = "checkout -b";
      cm = "!git add -A && git commit -m";
      save = "!git add -A && git commit -n -m 'SAVEPOINT'";
      wip = "!git add -u && git commit -n -m 'WIP'";
      undo = "reset HEAD~1 --mixed";
      "default-branch-name" = "!git symbolic-ref refs/remotes/origin/HEAD | sed 's@^refs/remotes/origin/@@'";
      "branch-name" = "!git rev-parse --abbrev-ref HEAD";
      amend = "commit -a --amend --no-edit";
      amendf = "!git commit -a --amend --no-edit && git push -f origin $(git branch-name)";
      wipe = "!git add -A && git commit -qm 'WIPE SAVEPOINT' && git reset HEAD~1 --hard";
      bclean = "!f() { git branch --merged \${1-$(git default-branch-name)} | grep -v \" \${1-$(git default-branch-name)}$\" | xargs -r git branch -d; }; f";
      bcleanall = "!f() { \
          DEFAULT_BRANCH=$(git default-branch-name); \
          git checkout $DEFAULT_BRANCH; \
          git pull origin $DEFAULT_BRANCH; \
          git fetch -p; \
          git branch | grep -v \"\\*\" | grep -v \"$DEFAULT_BRANCH\" | xargs -r git branch -D; \
      }; f";
      bdone = "!f() { git checkout \${1-$(git default-branch-name)} && git up && git bclean \${1-$(git default-branch-name)}; }; f";
      dsstore = "find . -name .DS_Store -print0 | xargs -0 git rm --ignore-unmatch";
    };
  };
}
