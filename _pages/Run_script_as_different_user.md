[category:security](category:security "wikilink")

To run as a different user that may not have a login shell use;

`su -c SCRIPT -s /bin/sh USER`

eg;

`su -c /home/nginx/html/youtube/youtube_downloader.sh -s /bin/bash www-data`

[Category:Linux](Category:Linux "wikilink")