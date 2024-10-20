import torrent_parser as tp
import argparse
from pathlib import Path

parser = argparse.ArgumentParser()
parser.add_argument('--torrent_file',required=True,help='The input torrent file')
parser.add_argument('--torrent_announce',required=True,help='The new announce URL')
parser.add_argument('--torrent_prefix',required=True,help='The prefix we will use to name the new torrent file')
parser.add_argument('--torrent_source',required=False,help='If provided, the new source value will be written to the new file')
args = parser.parse_args()

torrent_file_path = Path(args.torrent_file)
torrent_directory = torrent_file_path.parent
new_filename = f"{torrent_directory}/{args.torrent_prefix}_{torrent_file_path.name}"
torrent_data = tp.parse_torrent_file(args.torrent_file)

# Handle the announce field
if 'announce' in torrent_data:
    torrent_data['announce'] = args.torrent_announce

# Handle the source field
if 'info' in torrent_data and 'source' in torrent_data['info']:
    if args.torrent_source == "":
        del torrent_data['info']['source']
if args.torrent_source != None and args.torrent_source != "":
    torrent_data['info']['source'] = args.torrent_source

tp.create_torrent_file(new_filename,torrent_data)
print(f"New file should be created: {new_filename}")
