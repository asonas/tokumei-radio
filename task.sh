#!/bin/sh -e
./download.sh
ruby convert.rb
ruby rename_and_move.rb
