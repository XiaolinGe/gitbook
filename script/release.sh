git checkout gh-pages
git merge --no-ff master
git push -u origin gh-pages
cp -r _book/* .
git add .
git commit -m "Publish gitbook"