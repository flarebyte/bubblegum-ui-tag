#!/usr/bin/env zsh

hash=$(md5 -q docs/app.js)
hashcss=$(md5 -q docs/styles.css)

mv docs/app.js docs/app-$hash.js
sed -i '' "s/app.js/app-$hash.js/" docs/index.html
	
mv docs/styles.css docs/styles-$hashcss.css
sed -i '' "s/styles.css/styles-$hashcss.css/" docs/index.html
