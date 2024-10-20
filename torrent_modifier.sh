#!/bin/bash

basePath="$(dirname "$(readlink -f "$0")")"
torrent_file=""
torrent_source=""
torrent_announce=""
torrent_prefix=""

usage() {
    echo "Usage: $0 --torrent_file=<torrent file> --torrent_announce=<announce url> --torrent_prefix=<site prefix>"
    echo "    --torrent_file      The full path to the input torrent file"
    echo "    --torrent_announce  Specify the new announce URL"
    echo "    --torrent_prefix    Specify a prefix for the new file (e.g. OPS or RED)"
    echo "    --torrent_source    (optional) if the new site uses a 'Source' tag, this is it"
    exit 1
}

for arg in "$@"
do
    case $arg in
        --torrent_file=*)
        torrent_file="${arg#*=}"
	shift
	;;
        --torrent_source=*)
        torrent_source="${arg#*=}"
	shift
	;;
        --torrent_announce=*)
        torrent_announce="${arg#*=}"
	shift
	;;
        --torrent_prefix=*)
        torrent_prefix="${arg#*=}"
	shift
	;;
        *)
        usage
	;;
    esac
done

if [[ -z "$torrent_file" || -z "$torrent_announce" || -z "$torrent_prefix" ]]; then
    echo "Error: Missing required arguments."
    usage
    exit 0
else
    if [[ $torrent_file == ~* ]]; then
        torrent_file=$(eval echo "$torrent_file")
    fi
fi

if [ ! -d "${basePath}/.venv" ]; then
    python3 -m virtualenv "${basePath}/.venv"
fi

if [ -d "${basePath}/.venv" ]; then
    source ${basePath}/.venv/bin/activate
    pip3 install -q --upgrade pip setuptools wheel
    pip3 install -q -r ${basePath}/requirements.txt
    python3 ${basePath}/torrent_modifier.py --torrent_file="$torrent_file" --torrent_announce="$torrent_announce" --torrent_prefix="$torrent_prefix" --torrent_source="$torrent_source"
else
    echo "The Virtual environment is not present, cannot continue"
fi
