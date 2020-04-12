for branch in `git branch -r --merged | grep -v HEAD`; do if [] echo -e `git show --before='1 month ago' --format="%cr" $branch | head -n 1` \\t$branch; done | sort -r


for k in $(git branch -r | awk -F/ '/\/YOUR_PREFIX_HERE/{print $2}' | sed /\*/d); do
   if [ -z "$(git log -1 --since='Jul 31, 2015' -s origin/$k)" ]; then
     echo deleting "$(git log -1 --pretty=format:"%ct" origin/$k) origin/$k";
     git push origin --delete $k;
   fi;
done



for branch in `git branch -r --merged | grep -v HEAD`; do echo -e `git show --before='1 month ago' --format="%cr" $branch | head -n 1` \\t$branch; done | sort -r



# Original
for branch in `git branch -r --merged | grep -v HEAD`; do echo -e `git show --before='1 month ago' --format="%ci %cr %an" $branch | head -n 1` \\t$branch; done | sort -r

# Updated

for b in $(git branch --remote --merged); do if ["$( --before='1 month ago')" ]; then
    echo $b;
    git show $b --pretty="format: Merged %cr" | head -n 1;
    echo;
    fi;
done

for b in $(git branch --remote --merged=master | grep -v feature); do
    echo $b;
    git log --before="2 months ago" --pretty="format: Merged %cr" $b | head -n 1 | sort -r;
    echo;
done

git branch -r --merged
  grep origin | 
  grep -v '>' | 
  grep -v master | 
  xargs -L1 | 
  awk '{sub(/origin\//,"");print}'| 
  xargs git push origin --delete --dry-run


  git for-each-ref --format='%(committerdate:relative),%(refname:short)' --sort=committerdate remote | column -t -s ','

  git branch -avv --format="%(committerdate:iso8601), %(committerdate:relative) - %(refname:short)" | sort


for branch in `git branch -r --merged | grep -v HEAD`; do echo -e `git show --format="%ci %cr %an" $branch | head -n 1` \\t$branch; done | sort -r

for b in $(git branch --remote --merged); do     echo $b;     git log --before="2 months ago" --pretty="format: Merged %cr" $b | head -n 1 | sort -r;     echo; done

# Time since and branch shorthand
git for-each-ref --format='%(committerdate:relative),%(refname:short)' --sort=committerdate refs/heads/ | column -t -s ','

for b in $(git branch --remote --merged=master | grep -v master); do echo $b; git log --before="2 months ago" --pretty="format: Merged %cr" $b | head -n 1 |sort -r; echo; done

for k in `git branch -r | perl -pe 's/^..(.*?)( ->.*)?$/\1/'`; do echo -e `git show --pretty=format:"%Cgreen%ci %Cblue%cr%Creset" $k -- | head -n 1`\\t$k; done | sort -r

# git branch -r --sort=-committerdate --format='%(HEAD) %(color:yellow)%(refname:short)%(color:reset) - %(color:red)%(objectname:short)%(color:reset) - %(contents:subject) - %(authorname) (%(color:green)%(committerdate:relative)%(color:reset))' | grep <remote|author>

# git branch -r --merged | grep -Ev 'HEAD|master|develop' | while read b; do git log --color --format="%ci _%C(magenta)%cr %C(bold cyan)$b%Creset %s %C(bold blue)<%an>%Creset" $b | head -n 1; done | sort -r | cut -d_ -f2- | sed 's;origin/;;g' | head -10

git branch -r --list 'origin/release*' --merged=master | grep -Ev 'HEAD|master|develop|feature' | while read b; do git log --before='2 months ago' --color --format="%ci _%C(magenta)%cr %C(bold cyan)$b%Creset" $b | head -n 1; done | sort -r | cut -d_ -f2- | sed 's;origin/;;g'

# Just Hotfix and release
git branch -r --list '*release*' '*hotfix*' --merged=master | grep -Ev 'HEAD|master|develop|feature' | while read b; do git log --before='2 months ago' --color --format="%ci _%C(magenta)%cr %C(bold cyan)$b%Creset" $b | head -n 1; done | sort -r | cut -d_ -f2- | sed 's;origin/;;g'

# No colors
git branch -r  --list '*release*' '*hotfix*' --merged=master | grep -Ev 'HEAD|master|develop|feature' | while read b; do git log --before='2 months ago' --format="Merged to Master %cr - $b" $b | head -n 1; done | sort -r | xargs git push remote origin --delete --dry-run
