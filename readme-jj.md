# Jujutsu Manual Solutions

## Problem: VSCode Counter Files Being Tracked

When using the VSCode Counter extension, it generates `.VSCodeCounter` directories with analysis files that shouldn't be tracked in version control.

### Symptoms
- `jj st` shows files like:
  ```
  A .VSCodeCounter/2025-05-28_01-16-38/details.md
  A .VSCodeCounter/2025-05-28_01-16-38/diff-details.md
  A .VSCodeCounter/2025-05-28_01-16-38/diff.csv
  ```

## Solution 1: Untrack Files in Jujutsu

### Step 1: Untrack the files
```bash
# Untrack specific directory
jj file untrack ".VSCodeCounter"

# Or untrack from specific subdirectories
jj file untrack "aaa-practic/.VSCodeCounter"

# For multiple locations, run the command for each
jj file untrack "learn-clean--v2-2ett/.VSCodeCounter"
```

### Step 2: Update .gitignore
Add these patterns to your `.gitignore` file:
```ignore
# VSCode Counter extension files
.VSCodeCounter
**/.VSCodeCounter
**/.VSCodeCounter/
```

### Step 3: Verify
```bash
jj st
# Should no longer show .VSCodeCounter files

# Check if files are ignored
jj st | grep VSCodeCounter
# Should return nothing (exit code 1)
```

## Solution 2: Preventive Approach

### Add to .gitignore BEFORE generating counter files
```ignore
# VSCode Counter extension files
.VSCodeCounter/
**/.VSCodeCounter/
**/VSCodeCounter*/
```

## Solution 3: Global gitignore (Recommended)

### Create a global gitignore for all projects
```bash
# Create global gitignore
touch ~/.gitignore_global

# Add VSCodeCounter patterns
echo "# VSCode Counter extension files" >> ~/.gitignore_global
echo ".VSCodeCounter/" >> ~/.gitignore_global
echo "**/.VSCodeCounter/" >> ~/.gitignore_global

# Configure git to use global gitignore
git config --global core.excludesfile ~/.gitignore_global
```

## Key Differences: Git vs Jujutsu

| Action | Git Command | Jujutsu Command |
|--------|-------------|-----------------|
| Untrack files | `git rm --cached <file>` | `jj file untrack <file>` |
| Reset staging | `git reset HEAD <file>` | `jj file untrack <file>` |
| Check ignore | `git check-ignore <file>` | *Use jj st to verify* |

## Common Patterns for .gitignore

```ignore
# VSCode Counter (comprehensive)
.VSCodeCounter
.VSCodeCounter/
**/.VSCodeCounter
**/.VSCodeCounter/
**/VSCodeCounter*/

# Other VSCode files you might want to ignore
.vscode/settings.json
.vscode/launch.json
.vscode/tasks.json
.vscode/*.code-snippets

# But keep these VSCode files
!.vscode/extensions.json
!.vscode/recommended-extensions.json
```

## Troubleshooting

### Files still showing after untrack?
1. Check if files were committed in a previous change:
   ```bash
   jj log --no-graph -r 'file(.VSCodeCounter)'
   ```

2. If files were committed, you might need to edit the commit:
   ```bash
   jj edit <commit-id>
   jj file untrack ".VSCodeCounter"
   jj commit -m "Remove VSCodeCounter files"
   ```

### Files in multiple subdirectories?
Run untrack for each location:
```bash
find . -name ".VSCodeCounter" -type d | while read dir; do
    jj file untrack "$dir"
done
```

### Verify .gitignore patterns work
Create a test file and check:
```bash
mkdir -p test/.VSCodeCounter
touch test/.VSCodeCounter/test.md
jj st | grep test
# Should not show the test file if gitignore is working
rm -rf test/
```

## Best Practices

1. **Add patterns to .gitignore early** - before generating counter files
2. **Use global gitignore** for commonly ignored files across all projects
3. **Be specific with patterns** - use both `.VSCodeCounter` and `**/.VSCodeCounter/`
4. **Test your patterns** - create test files to verify ignore rules work
5. **Document in README** - let team members know about ignored files

## Related Files

- `.gitignore` - Local ignore patterns
- `~/.gitignore_global` - Global ignore patterns
- `.jjignore` - Jujutsu-specific ignore patterns (if needed)
