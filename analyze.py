import os
import re
from collections import defaultdict

TARGET_DIR = '/Users/liberyus/development/dedi/lib'
PUBSPEC = '/Users/liberyus/development/dedi/pubspec.yaml'

keywords = re.compile(r'(twake|linagora|fluffy)', re.IGNORECASE)

results = defaultdict(list)

# Check pubspec.yaml
with open(PUBSPEC, 'r', encoding='utf-8', errors='ignore') as f:
    text = f.read()
    if keywords.search(text):
        results['Root / pubspec.yaml'].append('pubspec.yaml mentions keywords (likely package name or git dependencies)')

for root, _, files in os.walk(TARGET_DIR):
    for file in files:
        if not file.endswith('.dart'):
            continue
        filepath = os.path.join(root, file)
        relpath = os.path.relpath(filepath, '/Users/liberyus/development/dedi')
        folder = os.path.dirname(relpath)
        
        match_in_name = keywords.search(file)
        match_in_content = False
        
        with open(filepath, 'r', encoding='utf-8', errors='ignore') as f:
            content = f.read()
            if keywords.search(content):
                match_in_content = True
        
        if match_in_name or match_in_content:
            reasons = []
            if match_in_name: reasons.append("in file name")
            if match_in_content: reasons.append("in content")
            results[folder].append(f"- `{file}` ({', '.join(reasons)})")

with open('report.md', 'w') as out:
    out.write("# Twake, Linagora, Fluffy Reference Analysis\n\n")
    for folder in sorted(results.keys()):
        out.write(f"### `{folder}`\n")
        for item in sorted(results[folder]):
            out.write(item + "\n")
        out.write("\n")
        
print("Analysis complete. Check report.md")
