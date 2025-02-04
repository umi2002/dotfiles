find . -type f -name "config.org" -exec sh -c 'cd "$(dirname "$1")" && ln -sf "$(basename "$1")" "readme.org"' _ {} \;
