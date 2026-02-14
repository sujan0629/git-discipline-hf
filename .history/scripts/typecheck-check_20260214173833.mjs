import { sum } from '../src/index.js';

if (typeof sum !== 'function') {
  console.error('Typecheck failed: sum export is missing');
  process.exit(1);
}

console.log('Typecheck check passed');
