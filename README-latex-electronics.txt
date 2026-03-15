Collect all latex and similar docs into one repo.

TODO Setup gitignore
TODO Unify the document types

On how to merge unrelated repos:
https://www.reddit.com/r/git/comments/z746vw/how_can_i_combine_three_repositories_without/

Text copy just in case:

shagieIsMe
•
3y ago
• Edited 3y ago

Create a new repository - its often easier to start out from a new blank spot than trying to merge B into A and then C into AB.

Lets call Z.

Then you add the remote for A to the Z project, fetch it, and then merge with the --allow-unrelated-histories flag.

This will bring in everything. I would suggest moving everything that you brought in to a subdirectory a.dir or similar - just something so that when you then do it for B, you don't have merge conflicts with two projects that happen to have the same files that you need to resolve right there and then.

Once you've got B merged into Z, and moved to avoid conflicts, do it again for C.

Now that Z contains the histories of all of A, B, and C and each project is in its own directory, you can then go about reconciling all of those directories and projects into one. It is likely easier to do this after all are merged in rather than dealing with merge conflicts.

(edit / doing it)

I had pre set up a repo A and a repo B with a commit each, and then created a directory Z at the same level as A and B and cd'ed into it.

Z % git init
Initialized empty Git repository in /private/tmp/git/Z/.git/
Z % git commit --allow-empty -m "Initial empty commit"
[main (root-commit) d52bf11] Initial empty commit
Z % git remote add a ../A
Z % git remote add b ../B
Z % git fetch a                               
remote: Enumerating objects: 3, done.
remote: Counting objects: 100% (3/3), done.
remote: Total 3 (delta 0), reused 0 (delta 0), pack-reused 0
Unpacking objects: 100% (3/3), 202 bytes | 202.00 KiB/s, done.
From ../A
 * [new branch]      main       -> a/main
Z % git fetch b
remote: Enumerating objects: 3, done.
remote: Counting objects: 100% (3/3), done.
remote: Total 3 (delta 0), reused 0 (delta 0), pack-reused 0
Unpacking objects: 100% (3/3), 213 bytes | 106.00 KiB/s, done.
From ../B
 * [new branch]      main       -> b/main
Z % git merge a/main --allow-unrelated-histories -m "Merge A"
Merge made by the 'ort' strategy.
 file.txt | 1 +
 1 file changed, 1 insertion(+)
 create mode 100644 file.txt
Z % ls 
file.txt
Z % mkdir a.dir
Z % git mv file.txt a.dir/.
Z % git commit -m "added a.dir; mv file.txt"
[main daf86fe] added a.dir; mv file.txt
 Committer: Shagie <shagie@local>
 1 file changed, 0 insertions(+), 0 deletions(-)
 rename file.txt => a.dir/file.txt (100%)
Z % git merge b/main --allow-unrelated-histories -m "Merge B"
Merge made by the 'ort' strategy.
 file.txt | 1 +
 1 file changed, 1 insertion(+)
 create mode 100644 file.txt
Z % git lg1
*   f57d7d1 - (18 seconds ago) Merge B - Shagie (HEAD -> main)
|\  
| * 595d003 - (13 minutes ago) Added file.txt here too - Shagie (b/main)
* daf86fe - (35 seconds ago) added a.dir; mv file.txt - Shagie
*   41b64dc - (73 seconds ago) Merge A - Shagie
|\  
| * e4a4117 - (14 minutes ago) Added file.txt - Shagie (a/main)
* d52bf11 - (3 minutes ago) Initial empty commit - Shagie
Z % 

At this point, you can see the commits. You can see the initial commit, which is then followed by the merge, which brought in an older commit from the other remote - and d52bf11 and e4a4117 don't share a common history which is why that flag is needed.

The command for lg1 is:

[alias]
lg1 = log --graph --abbrev-commit --decorate --format=format:'%C(bold blue)%h%C(reset) - %C(bold green)(%ar)%C(reset) %C(white)%s%C(reset) %C(dim white)- %an%C(reset)%C(bold yellow)%d%C(reset)' --all

I find it easier to read and show people what the history is like - it looks even better in color in my terminal.
11

