git checkout gh-pages
git merge --no-ff master
cp -r _book/* .
git add .
git commit -m "Publish gitbook"
git push -u origin gh-pages
