# .dotfiles
Organized for management with GNU Stow.

Be careful to appropriately use the options `--no-folding` and setting the
target to root with `-t /` when necessary.

Also, take care not to symlink files containing a `DO NOT SYMLINK` comment.
```
grep --exclude-dir=.git -r "DO NOT SYMLINK" .
```
