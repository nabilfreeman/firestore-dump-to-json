# firestore-dump-to-json

This takes your Firestore, and turns it into a massive JSON file.

It uses https://github.com/benyap/firestore-backfire, and gets rid of the chunks to give you one big object that looks like the one on your Firebase Console.

You can then do whatever you want with it, e.g. import it somewhere else, run some analysis, etc.

# 4 easy steps

```
# clone the repo
git clone https://github.com/nabilfreeman/firestore-dump-to-json
cd firestore-dump-to-json

# install dependencies
npm install

# put your Firebase service account JSON file in here (it is gitignored)
touch service-account.json

# run and go get a coffee!
npm start
```

Now you will have a file, `firestore.json` in your root directory which is a replica of your Firestore.

# Options

You can add `DUMP_PATTERNS` as an environment variable to speed up the export process by skipping stuff you don't need.

Specify it as a Regex string.

```
# exclude any path that has "users_orders_join" in it, but let everything else through
DUMP_PATTERNS='^(?!users_orders_join).*$' npm start
```

Regex is usually a "whitelist" thing, but here negative lookaheads do work, so you can exclude a path and let everything else through.

https://regexpal.com is useful for experimenting.

This is a direct expose of Backfire - you can read more about the pattern matching here:

https://github.com/benyap/firestore-backfire#--patterns-pattern