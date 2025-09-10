#!/bin/bash
set -e

echo "🧹 Cleaning up Beautiful Jekyll files..."

# Remove Beautiful Jekyll theme folders
rm -rf _includes _layouts _sass

# Remove Beautiful Jekyll-specific assets (CSS/JS)
rm -rf assets/css assets/js

# Keep your resume file, delete the rest of assets if empty
if [ -d "assets" ]; then
  find assets -type f ! -name 'Fauxxx_Resume.pdf' -delete
  find assets -type d -empty -delete
fi

# Remove Beautiful Jekyll config leftovers
sed -i '/navbar-links:/,/^$/d' _config.yml || true
sed -i '/footer:/d' _config.yml || true
sed -i '/plugins:/,/^$/d' _config.yml || true

echo "✅ Cleanup complete! Your repo is ready for the Dash theme script."

#!/bin/bash
set -e

echo "🧹 Deep cleaning Beautiful Jekyll files..."

# Remove Beautiful Jekyll theme guts
rm -rf _includes _layouts _sass _data _plugins

# Remove theme-specific pages
rm -f feed.xml tags.html 404.html CHANGELOG.md README.md beautiful-jekyll-theme.gemspec

# Remove old gem dependencies
rm -f Gemfile Gemfile.lock

# Remove Beautiful Jekyll assets but keep resume
if [ -d "assets" ]; then
  find assets -type f ! -name 'Fauxxx_Resume.pdf' -delete
  find assets -type d -empty -delete
fi

# Clean _config.yml from Beautiful Jekyll leftovers
sed -i '/navbar-links:/,/^$/d' _config.yml || true
sed -i '/footer:/d' _config.yml || true
sed -i '/plugins:/,/^$/d' _config.yml || true
sed -i '/remote_theme:/d' _config.yml || true
sed -i '/theme:/d' _config.yml || true

echo "✅ Cleanup complete! Repo is ready for Dash setup."
