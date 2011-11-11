
DIR="$(dirname "$(readlink -f "$0")")"
cd "$DIR"
TARBALL="`cat latest`"

echo
echo "Unpacking $DIR/$TARBALL ..." 
rm -rf package
tar -xzf $TARBALL

echo "Building NPM ..."
cd package
./configure --prefix="$DIR/root/usr"
rm -rf "$DIR/root"
mkdir "$DIR/root" -p
make install
cd $DIR

VERSION="$(node -e "var j=JSON.parse(require('fs').readFileSync('$DIR/root/usr/lib/node_modules/npm/package.json')); console.log(j.version);")"
echo "VERSION=$VERSION"


echo
echo "Patching $DIR/root/usr/lib/node_modules/npm/npmrc to reflect the correct prefix ..."
sed -i "s#^prefix = .*#prefix = /usr" $DIR/root/usr/lib/node_modules/npm/npmrc

mkdir -p RPMS
rpmbuild -bb "$DIR/package.spec" --buildroot "$DIR/root" --define "_topdir $DIR" --define "VERSION $VERSION"
