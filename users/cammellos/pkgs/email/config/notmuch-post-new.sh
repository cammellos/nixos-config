MAILDIR=~/Maildir/andrea.maria.piana@gmail.com

skip_tags=("[Imap]/Trash" "Spam" "Drafts" "Inbox")

for folder in "$MAILDIR"/*; do
  [ -d "$folder" ] || continue
  label=$(basename "$folder")

  if printf '%s\n' "${skip_tags[@]}" | grep -qx "$label"; then
    continue
  fi

  notmuch tag +"$label" -- "folder:andrea.maria.piana@gmail.com/$label" 2>/dev/null
done
