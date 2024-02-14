#!/bin/bash

if [ $# -ne 2 ]; then
    echo "Usage: $0 <branch-to-merge> <path-to-exclude>"
    exit 1
fi

branch_to_merge=$1
path_to_exclude=$2

# Ensure the working directory is clean
if [ -n "$(git status --porcelain)" ]; then
    echo "Error: Working directory is not clean. Please commit or stash your changes."
    exit 1
fi

# Merge with no commit and no fast-forward
git merge --no-commit --no-ff "$branch_to_merge" || exit 1

# Reset the specified path
git reset -- "$path_to_exclude" || exit 1

# Check if there are staged changes to commit
if [ -z "$(git diff --cached --name-only)" ]; then
    echo "No changes to commit after excluding $path_to_exclude."
    exit 0
fi

# Commit the merge
git commit || exit 1

echo "Merge committed successfully."

