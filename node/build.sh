
set -e
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
echo "Installing into $DIR/install-root ..."
mkdir -p "$DIR/install-root"
make install DESTDIR="$DIR/install-root"

cd $DIR
echo
echo "Building RPM ..."
mkdir -p "$DIR/RPMS"
rpmbuild -bb package.spec --buildroot "$DIR/install-root" --define "_topdir $DIR" --define "VERSION $VERSION"

