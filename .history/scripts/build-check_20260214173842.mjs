import { access } from 'node:fs/promises';

async function run() {
  await access('src/index.js');
  console.log('Build check passed');
}

run().catch((error) => {
  console.error(error.message);
  process.exit(1);
});
