#!/bin/bash

# Ensure a title was passed as an argument
if [ -z "$1" ]; then
  echo "Usage: ./new_post.sh \"My Post Title\""
  exit 1
fi

TITLE="$1"
# Convert title to lowercase, replace spaces/special chars with hyphens for the URL slug
SLUG=$(echo "$TITLE" | iconv -t ascii//TRANSLIT | sed -E 's/[^a-zA-Z0-9]+/-/g' | sed -E 's/^-+|-+$//g' | tr A-Z a-z)

# Jekyll requires the date in the filename
DATE=$(date +%Y-%m-%d)
# Your template uses a specific ISO 8601 format for the front matter
DATETIME=$(date +"%Y-%m-%dT%H:%M:%S%z")

FILENAME="_posts/${DATE}-${SLUG}.md"

# Generate the file with your exact YAML block
cat <<EOF > "$FILENAME"
---
title: "$TITLE"
date: $DATETIME
author: KAL Martin
layout: post
permalink: /${SLUG}/
categories: Genel
tags: []
---

EOF

echo "Created new post: $FILENAME"
