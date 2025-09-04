#!/bin/bash
# Script to add portfolio pages and update _config.yml
set -e

echo "📂 Adding portfolio pages..."

# Create additional Markdown pages if they don't exist
for page in about.md projects.md contact.md resume.md; do
  if [ ! -f "$page" ]; then
    cat <<EOF >"$page"
---
layout: default
title: ${page%%.*}
---

# ${page%%.*^}
Content for ${page%%.*} page goes here.
EOF
    echo "✅ Created $page"
  else
    echo "⚠️  $page already exists, skipping."
  fi
done

# Create assets folder + dummy resume if not exists
mkdir -p assets
if [ ! -f assets/Fauxxx_Resume.pdf ]; then
  echo "Dummy PDF for resume" >assets/Fauxxx_Resume.pdf
  echo "✅ Added dummy resume at assets/Fauxxx_Resume.pdf"
else
  echo "⚠️  Resume file already exists, skipping."
fi

# Update _config.yml with navigation (only if not already present)
if ! grep -q "navigation:" _config.yml; then
  cat <<'EOF' >>_config.yml

# Navigation links
navigation:
  - title: "Home"
    url: /
  - title: "About"
    url: /about
  - title: "Projects"
    url: /projects
  - title: "Contact"
    url: /contact
  - title: "Resume"
    url: /resume
EOF
  echo "✅ Updated _config.yml with navigation"
else
  echo "⚠️  Navigation already exists in _config.yml, skipping update."
fi

echo "🎉 Setup complete!"
