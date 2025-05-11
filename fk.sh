#!/bin/bash

# Check for Git repo
if [ ! -d .git ]; then
  echo "This is not a Git repository. Run this in a git repo directory."
  exit 1
fi

NUM_COMMITS=10
START_DATE="2025-04-16"
AUTHOR_NAME="deshanMAK"
AUTHOR_EMAIL="kavishkadeshan428@gmail.com"

FILES=("index.html" "index.css" "index.js" "index.php" "README")

for i in $(seq 0 $((NUM_COMMITS - 1))); do
  COMMIT_DATE=$(date -d "$START_DATE +$i day" +"%Y-%m-%dT12:00:00")
  
  echo "$COMMIT_DATE - Commit $i"
  
  # Randomly select a file to modify
  FILE=${FILES[$RANDOM % ${#FILES[@]}]}
  
  # Add a comment to the selected file
  echo "/* Update $i - $(date -d "$COMMIT_DATE" +"%Y-%m-%d") */" >> "$FILE"
  
  git add "$FILE"

  GIT_COMMITTER_DATE="$COMMIT_DATE" GIT_AUTHOR_DATE="$COMMIT_DATE" \
  GIT_AUTHOR_NAME="$AUTHOR_NAME" GIT_AUTHOR_EMAIL="$AUTHOR_EMAIL" \
  GIT_COMMITTER_NAME="$AUTHOR_NAME" GIT_COMMITTER_EMAIL="$AUTHOR_EMAIL" \
  git commit -m "Update $FILE - commit $i"
done

echo "Done. Push it to GitHub if you'd like."