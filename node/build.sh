
DIR="$(dirname "$(readlink -f "$0")")"
cd "$DIR"

VERSION=`cat version`
cd "node-v$VERSION"
export CFLAGS=" -w -pipe -O3"
export CXXFLAGS=" -w -pipe -O3"
./configure --prefix=/usr

echo
echo "Building Node ..."
make

echo
echo "Installing into $DIR/root ..."
mkdir "$DIR/root"
make install DESTDIR="$DIR/root"

echo
echo "Building RPM ..."
mkdir "$DIR/RPMS"
rpmbuild -bb package.spec --buildroot "$DIR/root" --define "_topdir $DIR" --define "VERSION $VERSION"

