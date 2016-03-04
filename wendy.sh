#!/bin/sh

HTMLROOT="/builds/wildefyr.net"
cd "$HTMLROOT"

./media.sh
wendy -m 768 -f ./media ./media.sh &
