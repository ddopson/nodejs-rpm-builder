
cd "$(dirname "$(readlink -f "$0")")"
TARBALL_URL="$(curl http://registry.npmjs.org/npm/latest -s | sed 's/.*"tarball":"//; s/".*//;')"
FILE="`echo "$TARBALL_URL" | sed 's#.*/##'`"
echo "Downloading $TARBALL_URL  -->  $FILE ..."
curl -s $TARBALL_URL > $FILE
echo "$FILE" > latest
