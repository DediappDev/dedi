#!/bin/bash

# DEDI SERVER - GIT HISTORY REWRITER
# Changes all commit authors to tangun/dediapp with weighted distribution

set -e

echo "🚨 WARNING: This will completely rewrite git history!"
echo "📊 Found $(git log --oneline | wc -l | tr -d ' ') commits to rewrite"
echo "⏰ This may take several minutes..."
read -p "Continue? (y/N): " -n 1 -r
echo
if [[ ! $REPLY =~ ^[Yy]$ ]]; then
    echo "❌ Aborted."
    exit 1
fi

# Define new identities
TANGUN_NAME="tangun"
TANGUN_EMAIL="tangun@dediapp.com"
DEDIAPP_NAME="dediapp" 
DEDIAPP_EMAIL="dediapp@dediapp.com"

# Create mapping script
cat > /tmp/author-map.py << 'EOF'
#!/usr/bin/env python3
import random
import sys

def get_author_for_commit_number(commit_num, total_commits):
    """
    Returns author based on commit position:
    - Early commits (0-40%): 70% dediapp, 30% tangun
    - Middle commits (40-70%): 50% dediapp, 50% tangun  
    - Late commits (70-100%): 30% dediapp, 70% tangun
    """
    position = commit_num / total_commits
    
    if position <= 0.4:  # First 40% of commits
        return "dediapp" if random.random() < 0.7 else "tangun"
    elif position <= 0.7:  # Middle 30% of commits
        return "dediapp" if random.random() < 0.5 else "tangun"
    else:  # Last 30% of commits  
        return "dediapp" if random.random() < 0.3 else "tangun"

if __name__ == "__main__":
    commit_num = int(sys.argv[1])
    total_commits = int(sys.argv[2])
    
    # Set seed for reproducible results
    random.seed(42 + commit_num)  # Different seed per commit but reproducible
    
    author = get_author_for_commit_number(commit_num, total_commits)
    
    if author == "tangun":
        print("tangun <tangun@dediapp.com>")
    else:
        print("dediapp <dediapp@dediapp.com>")
EOF

chmod +x /tmp/author-map.py

# Get total commit count
TOTAL_COMMITS=$(git rev-list --count HEAD)
echo "📋 Processing $TOTAL_COMMITS commits..."

# Create backup branch
git branch history-backup-$(date +%Y%m%d-%H%M) || true

# Get all commit hashes in reverse order (oldest first)
git rev-list --reverse HEAD > /tmp/commit-list.txt

# Create the filter-branch command
echo "🔄 Starting git filter-branch operation..."

git filter-branch -f --env-filter "
    # Read commit counter from temp file or initialize
    COUNTER_FILE='/tmp/commit_counter'
    if [ ! -f \"\$COUNTER_FILE\" ]; then
        echo '0' > \"\$COUNTER_FILE\"
    fi
    
    CURRENT_COUNTER=\$(cat \"\$COUNTER_FILE\")
    CURRENT_COUNTER=\$((CURRENT_COUNTER + 1))
    echo \"\$CURRENT_COUNTER\" > \"\$COUNTER_FILE\"
    
    # Get new author based on position
    NEW_AUTHOR=\$(python3 /tmp/author-map.py \$CURRENT_COUNTER $TOTAL_COMMITS)
    
    if [ \"\$NEW_AUTHOR\" = 'tangun <tangun@dediapp.com>' ]; then
        export GIT_AUTHOR_NAME='tangun'
        export GIT_AUTHOR_EMAIL='tangun@dediapp.com'
        export GIT_COMMITTER_NAME='tangun'  
        export GIT_COMMITTER_EMAIL='tangun@dediapp.com'
    else
        export GIT_AUTHOR_NAME='dediapp'
        export GIT_AUTHOR_EMAIL='dediapp@dediapp.com'
        export GIT_COMMITTER_NAME='dediapp'
        export GIT_COMMITTER_EMAIL='dediapp@dediapp.com'
    fi
" -- --all

# Clean up temp files
rm -f /tmp/author-map.py /tmp/commit-list.txt /tmp/commit_counter

echo "✅ Git history rewrite complete!"
echo "📊 New author distribution:"
git log --format="%an <%ae>" | sort | uniq -c | sort -nr

echo ""
echo "🔍 Verification:"
echo "Total commits: $(git log --oneline | wc -l | tr -d ' ')"
echo "First 10 commits (oldest):"
git log --reverse --oneline --format="%h %an: %s" | head -10

echo ""
echo "Last 10 commits (newest):"
git log --oneline --format="%h %an: %s" | head -10

echo ""
echo "💾 Backup branch created: history-backup-$(date +%Y%m%d)"
echo "🚨 To restore original history: git reset --hard history-backup-$(date +%Y%m%d)"
echo "🗑️  To clean up backup: git branch -D history-backup-$(date +%Y%m%d)"

echo ""
echo "⚠️  IMPORTANT: You'll need to force push to remote:"
echo "   git push organization main --force"