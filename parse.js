// the json file should be exported with `npx backfire`.
// only one chunk is supported, so make sure you export with `--workers=1`
const dump = require('./dump/chunk00.json');

const map = {};

for(const { path, data } of dump) {
    const parts = path.split('/');

    let deep = map;

    for (const [index, part] of parts.entries()) {
       deep[part] = deep[part] || {};

       if(index === parts.length - 1) {
           deep[part] = {
               id: part,
               ...data
           };
       }

       deep = deep[part]
    }
}

console.log(JSON.stringify(map));