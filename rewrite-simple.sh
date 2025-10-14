#!/bin/bash

# SIMPLE GIT HISTORY REWRITER
# Changes all authors to tangun/dediapp with time-based distribution

set -e

echo "🚨 WARNING: This will completely rewrite git history!"
echo "📊 Found $(git log --oneline | wc -l | tr -d ' ') commits to rewrite"
read -p "Continue? (y/N): " -n 1 -r
echo
if [[ ! $REPLY =~ ^[Yy]$ ]]; then
    echo "❌ Aborted."
    exit 1
fi

# Create backup branch
git branch "history-backup-$(date +%Y%m%d-%H%M)" || true
echo "💾 Backup branch created"

# Create author mapping based on commit date
cat > /tmp/rewrite-authors.py << 'EOF'
#!/usr/bin/env python3
import subprocess
import random
import sys
from datetime import datetime

# Get all commit hashes in reverse chronological order (oldest first)
result = subprocess.run(['git', 'rev-list', '--reverse', 'HEAD'], 
                       capture_output=True, text=True)
commit_hashes = result.stdout.strip().split('\n')

total_commits = len(commit_hashes)
print(f"Processing {total_commits} commits...")

# Create author mappings
author_map = {}
for i, commit_hash in enumerate(commit_hashes):
    # Set reproducible seed based on commit position
    random.seed(42 + i)
    
    # Calculate position (0.0 to 1.0)
    position = i / total_commits
    
    # Weighted distribution:
    # Early (0-40%): 70% dediapp, 30% tangun
    # Middle (40-70%): 50% dediapp, 50% tangun
    # Late (70-100%): 30% dediapp, 70% tangun
    
    if position <= 0.4:
        author = "dediapp" if random.random() < 0.7 else "tangun"
    elif position <= 0.7:
        author = "dediapp" if random.random() < 0.5 else "tangun"
    else:
        author = "dediapp" if random.random() < 0.3 else "tangun"
    
    if author == "tangun":
        author_map[commit_hash] = "tangun <tangun@liberyus.com>"
    else:
        author_map[commit_hash] = "dediapp <dediapp@dedim.com.tr>"

# Write mapping to file
with open('/tmp/author-mapping.txt', 'w') as f:
    for commit_hash, author in author_map.items():
        f.write(f"{commit_hash} {author}\n")

print("📋 Author mapping created")

# Statistics
tangun_count = sum(1 for author in author_map.values() if 'tangun' in author)
dediapp_count = sum(1 for author in author_map.values() if 'dediapp' in author)

print(f"📊 Distribution: tangun={tangun_count} ({tangun_count/total_commits*100:.1f}%), dediapp={dediapp_count} ({dediapp_count/total_commits*100:.1f}%)")
EOF

python3 /tmp/rewrite-authors.py

echo "🔄 Rewriting git history using filter-branch..."

# Clear counter file
rm -f /tmp/commit_counter

# Use a simple approach with environment variable mapping
export FILTER_BRANCH_SQUELCH_WARNING=1

git filter-branch -f --env-filter '
    # Load current commit hash
    CURRENT_COMMIT="$GIT_COMMIT"
    
    # Look up the new author from our mapping file
    NEW_AUTHOR=$(grep "^$CURRENT_COMMIT " /tmp/author-mapping.txt | cut -d" " -f2-)
    
    if [ -n "$NEW_AUTHOR" ]; then
        if echo "$NEW_AUTHOR" | grep -q "tangun"; then
            export GIT_AUTHOR_NAME="tangun"
            export GIT_AUTHOR_EMAIL="tangun@liberyus.com"
            export GIT_COMMITTER_NAME="tangun"
            export GIT_COMMITTER_EMAIL="tangun@liberyus.com"
        else
            export GIT_AUTHOR_NAME="dediapp"
            export GIT_AUTHOR_EMAIL="dediapp@dedim.com.tr"
            export GIT_COMMITTER_NAME="dediapp"
            export GIT_COMMITTER_EMAIL="dediapp@dedim.com.tr"
        fi
    fi
' HEAD

# Clean up
rm -f /tmp/rewrite-authors.py /tmp/author-mapping.txt

echo "✅ Git history rewrite complete!"
echo "📊 New author distribution:"
git log --format="%an <%ae>" | sort | uniq -c | sort -nr

echo ""
echo "🔍 First 10 commits (oldest):"
git log --reverse --oneline --format="%h %an: %s" | head -10

echo ""
echo "🔍 Last 10 commits (newest):"
git log --oneline --format="%h %an: %s" | head -10

echo ""
echo "💾 Backup: history-backup-$(date +%Y%m%d-%H%M)"
echo "⚠️  To push: git push organization main --force"