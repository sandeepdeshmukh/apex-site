set -e
echo "Installing npm dependencies..."
npm install
echo "Installing bower dependencies..."
./node_modules/.bin/bower install
echo "Building project..."
./node_modules/.bin/gulp
cp -r content content_tmp
COMMIT_HASH=`git rev-parse HEAD`
echo "Build successful."
git checkout asf-site
rm -rf content
mv content_tmp content
git add content
echo "Commiting changes to asf-site branch from master branch."
git commit -m "from $COMMIT_HASH"
echo "-----------------------------------------------------"
echo "BUILD SUCCESSFUL. You are now on the asf-site branch."
echo "Run git push origin asf-site to update the live site."
set +e