
if [ "$BASH" ]; then
  if [ -f ~/.bashrc ]; then
    . ~/.bashrc
  fi
fi

mesg n 2> /dev/null || true

# Go Path -- aniruddh
#export PATH=$PATH:/usr/local/go/bin