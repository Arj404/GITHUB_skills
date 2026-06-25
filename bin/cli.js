#!/usr/bin/env node
'use strict';

const fs = require('fs');
const path = require('path');
const os = require('os');

const VERSION = require('../package.json').version;
const PACKAGE_ROOT = path.resolve(__dirname, '..');

const HELP = `
copilot-skills-kit v${VERSION}

Install the GitHub Copilot skills framework into VS Code and/or a target repo.

Usage:
  copilot-skills-kit install [options]
  copilot-skills-kit --version
  copilot-skills-kit --help

Commands:
  install     Copy agents, prompts, instructions and skills into VS Code and
              the target repository's .github/ directory.

Options for install:
  --target <path>   Repository to install the framework into (.github/).
                    Defaults to the current working directory.
  --global-only     Only install to VS Code's global user prompts directory;
                    skip the per-repo .github/ install.

Global options:
  -v, --version     Print version and exit.
  -h, --help        Show this message and exit.

Examples:
  npx copilot-skills-kit install
  npx copilot-skills-kit install --target ~/projects/my-app
  npx copilot-skills-kit install --global-only
`;

// ─── Utilities ────────────────────────────────────────────────────────────────

function resolveVscodePromptsDir() {
  const { platform } = process;
  const home = os.homedir();

  if (platform === 'darwin') {
    return path.join(home, 'Library', 'Application Support', 'Code', 'User', 'prompts');
  }
  if (platform === 'win32') {
    const appdata = process.env.APPDATA;
    if (!appdata) {
      throw new Error('APPDATA environment variable is not set. Cannot locate VS Code on Windows.');
    }
    return path.join(appdata, 'Code', 'User', 'prompts');
  }
  // Linux / other Unix
  return path.join(home, '.config', 'Code', 'User', 'prompts');
}

function copyFilesFlat(srcDir, destDir) {
  if (!fs.existsSync(srcDir)) return 0;
  fs.mkdirSync(destDir, { recursive: true });
  let count = 0;
  for (const file of fs.readdirSync(srcDir)) {
    const src = path.join(srcDir, file);
    if (fs.statSync(src).isFile()) {
      fs.copyFileSync(src, path.join(destDir, file));
      count++;
    }
  }
  return count;
}

function copyDirRecursive(src, dest) {
  if (!fs.existsSync(src)) return;
  fs.mkdirSync(dest, { recursive: true });
  for (const entry of fs.readdirSync(src, { withFileTypes: true })) {
    const srcPath = path.join(src, entry.name);
    const destPath = path.join(dest, entry.name);
    if (entry.isDirectory()) {
      copyDirRecursive(srcPath, destPath);
    } else {
      fs.copyFileSync(srcPath, destPath);
    }
  }
}

// ─── Install steps ────────────────────────────────────────────────────────────

function installGlobal() {
  const promptsDir = resolveVscodePromptsDir();
  fs.mkdirSync(promptsDir, { recursive: true });

  let total = 0;
  for (const dir of ['agents', 'prompts', 'instructions']) {
    total += copyFilesFlat(path.join(PACKAGE_ROOT, dir), promptsDir);
  }
  console.log(`  ✓  Installed ${total} files → ${promptsDir}`);
}

function installToRepo(targetPath) {
  for (const dir of ['agents', 'instructions', 'prompts', 'skills']) {
    const src = path.join(PACKAGE_ROOT, dir);
    const dest = path.join(targetPath, '.github', dir);
    copyDirRecursive(src, dest);
    console.log(`  ✓  Copied ${dir}/ → .github/${dir}/`);
  }

  // Ensure .copilot/context/ exists so agents have a place to write specs
  const contextDir = path.join(targetPath, '.copilot', 'context');
  fs.mkdirSync(contextDir, { recursive: true });

  // Write .vscode/settings.json only if none exists
  const settingsSrc = path.join(PACKAGE_ROOT, 'vscode', 'settings.json');
  const settingsDest = path.join(targetPath, '.vscode', 'settings.json');
  if (fs.existsSync(settingsSrc) && !fs.existsSync(settingsDest)) {
    fs.mkdirSync(path.dirname(settingsDest), { recursive: true });
    fs.copyFileSync(settingsSrc, settingsDest);
    console.log('  ✓  Created .vscode/settings.json');
  }

  console.log(`  ✓  Framework installed to ${targetPath}`);
}

// ─── Main ─────────────────────────────────────────────────────────────────────

function main() {
  const args = process.argv.slice(2);

  if (args.length === 0 || args.includes('--help') || args.includes('-h')) {
    console.log(HELP);
    process.exit(0);
  }

  if (args.includes('--version') || args.includes('-v')) {
    console.log(VERSION);
    process.exit(0);
  }

  const command = args[0];
  if (command !== 'install') {
    console.error(`Unknown command: "${command}"\nRun 'copilot-skills-kit --help' for usage.`);
    process.exit(1);
  }

  const globalOnly = args.includes('--global-only');
  const targetIndex = args.indexOf('--target');
  const targetPath = targetIndex !== -1
    ? path.resolve(args[targetIndex + 1])
    : process.cwd();

  if (targetIndex !== -1 && !args[targetIndex + 1]) {
    console.error('--target requires a path argument.');
    process.exit(1);
  }

  console.log(`\ncopilot-skills-kit — Installing GitHub Copilot skills framework\n`);

  try {
    installGlobal();
    if (!globalOnly) {
      installToRepo(targetPath);
    }
  } catch (err) {
    console.error(`\n  ✗  Error: ${err.message}`);
    process.exit(1);
  }

  console.log('\n✅  Done! Open VS Code and start using @Product, @Planner, /spec, and more.\n');
  console.log('Next steps:');
  console.log('  1. Open your repo in VS Code.');
  console.log('  2. Update .copilot/context/overview.md with your project details.');
  console.log("  3. Type '@Product Please create a spec for [feature]' in Copilot Chat.\n");
}

main();
