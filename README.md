# torrent_modifier
A command line tool to make modification of torrent files quicker and easier

## Example use:
```torrent_modifier.sh --torrent_file=~/tmp/input.torrent --torrent_announce="http://mynewsite.com/blah" --torrent_prefix=NEW --torrent_source=NEW```

This will create a file called "~/tmp/NEW_input.torrent".

This file will have the new 'announce' URL specified in the "torrent_announce" value.

It will also have a 'source' value as specified by the (optional) "torrent_source" parameter.

Note: if "torrent_source" is not provided, but the input.torrent file has a source, it will remove the source value from the new torrent.
