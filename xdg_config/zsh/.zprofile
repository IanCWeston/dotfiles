# set PATH so it includes user's private bin if it exists
if [ -d "$HOME/bin" ] ; then
    PATH="$HOME/bin:$PATH"
fi

# set PATH so it includes user's private bin if it exists
if [ -d "$HOME/.local/bin" ] ; then
    PATH="$HOME/.local/bin:$PATH"
fi

set PATH so it includes nodejs if it exists
VERSION=v16.15.0
DISTRO=linux-x64
if [ -d "/usr/local/lib/nodejs" ] ; then
    PATH="/usr/local/lib/nodejs/node-$VERSION-$DISTRO/bin:$PATH"
fi
