import { execSync } from 'node:child_process';

function getBranchFromGit() {
  return execSync('git rev-parse --abbrev-ref HEAD', { encoding: 'utf8' }).trim();
}

const inputBranch = process.argv[2];
const branch = inputBranch || getBranchFromGit();
const blockedBranches = new Set(['main', 'develop']);
const branchRegex = /^(feature|fix|hotfix|chore)\/[a-z0-9]+(?:-[a-z0-9]+)*$/;

if (blockedBranches.has(branch)) {
  console.error(`Direct pushes to ${branch} are blocked. Use a short-lived branch + PR.`);
  process.exit(1);
}

if (!branchRegex.test(branch)) {
  console.error(`Invalid branch name: ${branch}`);
  console.error('Allowed formats:');
  console.error('- feature/auth-navigation');
  console.error('- fix/crash-on-start');
  console.error('- hotfix/crash-on-launch');
  console.error('- chore/update-deps');
  process.exit(1);
}

console.log(`Branch name valid: ${branch}`);
