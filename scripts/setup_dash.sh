#!/bin/bash
set -e

echo "🚀 Setting up Jekyll Dash theme..."

# 1. Clean old theme files
echo "🧹 Removing Beautiful Jekyll remnants..."
rm -f beautiful-jekyll-theme.gemspec Gemfile.lock
rm -rf _plugins _sass _includes _layouts

# 2. Create Gemfile for Dash
echo "📦 Creating Gemfile..."
cat >Gemfile <<'EOF'
source "https://rubygems.org"

gem "jekyll", "~> 4.3"
gem "jekyll-dash"
gem "jekyll-tagging"
EOF

# 3. Update _config.yml
echo "⚙️ Updating _config.yml..."
cat >_config.yml <<'EOF'
title: "Fauxxx’s Portfolio"
description: "Controls Engineer | Robotics | UAVs | AI & Controls"
url: "https://ven0m-hue.github.io"
baseurl: "" # leave empty for username.github.io

theme: jekyll-dash

plugins:
  - jekyll-tagging

author: Fauxxx
email: your-email@example.com

# Navbar links
navbar-links:
  About Me: "about"
  Projects: "projects"
  Blog: "blog"
  Resume: "resume"
  Contact: "contact"

# Footer text
footer: "© 2025 Fauxxx"
EOF

# 4. Add GitHub Actions workflow
echo "⚙️ Creating GitHub Actions workflow..."
mkdir -p .github/workflows
cat >.github/workflows/jekyll.yml <<'EOF'
name: Build and Deploy Jekyll Dash

on:
  push:
    branches:
      - main

jobs:
  build:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v3

      - name: Setup Ruby
        uses: ruby/setup-ruby@v1
        with:
          ruby-version: 3.1

      - name: Install dependencies
        run: |
          bundle install

      - name: Build site
        run: bundle exec jekyll build

      - name: Deploy to GitHub Pages
        uses: peaceiris/actions-gh-pages@v3
        with:
          github_token: ${{ secrets.GITHUB_TOKEN }}
          publish_dir: ./_site
EOF

echo "✅ Dash setup complete!"
echo "👉 Now commit and push your changes:"
echo "   git add ."
echo "   git commit -m 'Switch to jekyll-dash theme'"
echo "   git push origin master"
