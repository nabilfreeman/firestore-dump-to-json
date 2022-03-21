# if we have past dumps, let's safely move them out of the firing line so they don't get overwritten.
mv ./dump "./dump-old-$(date +%s%3N)" || true

# this can be safely erased as long as we don't throw away the dumped chunks. they can always be re-processed.
rm -rf ./firestore.json

# this dumps the production firestore into a weird chunk format in the ./dump directory.
# --workers=1 is very important, our `parse.js` script can only process one file, not multiple threads.
npx backfire export -p "$FIREBASE_APP_NAME" -k ./service-account.json --patterns="$DUMP_PATTERNS" --logLevel='verbose' --workers=1 ./dump

# now we run parse.js, which reads the dump chunk file and outputs a Firebase-y nested map with all the collections in it.
# JS puts the whole thing in stdout so we catch it and write to JSON file.
node ./parse.js > ./firestore.json

# now you an use the firestore.json to run `seed_from_firestore.js` in the Node API.