#!/bin/bash
set -e

echo "🚀 Setting up advanced blog features for Beautiful Jekyll..."

# 2️⃣ Create assets/css/dark-mode.css
mkdir -p assets/css
cat >assets/css/dark-mode.css <<'EOF'
/* Dark mode overrides */
body.dark-mode { background-color: #121212; color: #e0e0e0; }
body.dark-mode h1,h2,h3,h4,h5,h6 { color: #fff; }
body.dark-mode a { color: #90caf9; } 
body.dark-mode a:hover { color: #bbdefb; }
.navbar.dark-mode, body.dark-mode .navbar { background-color: #1f1f1f !important; }
body.dark-mode .navbar a { color: #e0e0e0 !important; }
body.dark-mode .navbar a:hover { color: #fff !important; }
footer.dark-mode, body.dark-mode footer { background-color: #1f1f1f; color: #aaa; }
body.dark-mode pre, body.dark-mode code { background-color: #1e1e1e; color: #c5c8c6; border-radius: 5px; }
body.dark-mode pre { padding: 10px; overflow-x: auto; }
body.dark-mode code { padding: 2px 4px; }
body.dark-mode .card, body.dark-mode .post { background-color: #1a1a1a; border: 1px solid #333; color: #ddd; }
body.dark-mode .post-preview { background-color: #1a1a1a; border: 1px solid #333; padding: 15px; border-radius: 8px; margin-bottom: 20px; }
body.dark-mode .post-preview a { color: #90caf9; } 
body.dark-mode .post-preview a:hover { color: #bbdefb; }
body.dark-mode .post-title, body.dark-mode .post-subtitle { color: #fff; }
body.dark-mode .post-meta { color: #bbb; }
body.dark-mode .post-content { color: #e0e0e0; line-height: 1.7; }
body.dark-mode .post-content h2, body.dark-mode .post-content h3 { color: #fff; }
body.dark-mode blockquote { border-left: 4px solid #90caf9; color: #ccc; padding-left: 15px; font-style: italic; }
#search-input { background-color: #1a1a1a; color: #eee; border: 1px solid #333; }
#search-results li a { color: #90caf9; }
#search-results li a:hover { color: #bbdefb; }
EOF

# 3️⃣ Create assets/js/dark-mode.js
mkdir -p assets/js
cat >assets/js/dark-mode.js <<'EOF'
(function() {
  const toggleButton = document.getElementById("theme-toggle");
  const body = document.body;
  function setIcon() {
    if (body.classList.contains("dark-mode")) { toggleButton.textContent = "🌞"; }
    else { toggleButton.textContent = "🌙"; }
  }
  const savedTheme = localStorage.getItem("theme");
  if (savedTheme) { if (savedTheme === "dark") { body.classList.add("dark-mode"); } }
  else { if (window.matchMedia && window.matchMedia("(prefers-color-scheme: dark)").matches) { body.classList.add("dark-mode"); } }
  setIcon();
  toggleButton.addEventListener("click", function() {
    body.classList.toggle("dark-mode");
    localStorage.setItem("theme", body.classList.contains("dark-mode") ? "dark" : "light");
    setIcon();
  });
  window.matchMedia("(prefers-color-scheme: dark)").addEventListener("change", e => {
    if (!localStorage.getItem("theme")) {
      if (e.matches) { body.classList.add("dark-mode"); } else { body.classList.remove("dark-mode"); }
      setIcon();
    }
  });
})();
EOF

# 4️⃣ Add _plugins folder + generate_tags.rb
mkdir -p _plugins
cat >_plugins/generate_tags.rb <<'EOF'
module Jekyll
  class TagPageGenerator < Generator
    safe true
    def generate(site)
      if site.layouts.key? 'tag_page'
        site.tags.keys.each do |tag|
          site.pages << TagPage.new(site, site.source, File.join('blog/tags', tag), tag)
        end
      end
    end
  end
  class TagPage < Page
    def initialize(site, base, dir, tag)
      @site = site
      @base = base
      @dir  = dir
      @name = 'index.html'
      self.process(@name)
      self.read_yaml(File.join(base, '_layouts'), 'tag_page.html')
      self.data['tag'] = tag
      self.data['title'] = "Posts tagged \"#{tag}\""
    end
  end
end
EOF

# 5️⃣ Create _layouts/tag_page.html
mkdir -p _layouts
cat >_layouts/tag_page.html <<'EOF'
---
layout: home
---
<h2>Posts tagged "{{ page.tag }}"</h2>
<ul class="post-list">
{% for post in site.tags[page.tag] %}
  <li><a href="{{ post.url | relative_url }}">{{ post.title }}</a> — {{ post.date | date: "%b %-d, %Y" }}</li>
{% endfor %}
</ul>
EOF

# 6️⃣ Update navbar.html
NAVBAR_FILE="_includes/header.html"
if ! grep -q "theme-toggle" $NAVBAR_FILE; then
  sed -i '/<\/ul>/i \
<li class="nav-item"><button id="theme-toggle" class="btn btn-sm"></button></li>' $NAVBAR_FILE
fi

# 7️⃣ Update default.html to include CSS + JS
DEFAULT_FILE="_layouts/default.html"
if ! grep -q "dark-mode.css" $DEFAULT_FILE; then
  sed -i '/<\/head>/i \
<link rel="stylesheet" href="{{ \"/assets/css/dark-mode.css\" | relative_url }}">' $DEFAULT_FILE
fi

if ! grep -q "dark-mode.js" $DEFAULT_FILE; then
  sed -i '/<\/body>/i \
<script src="{{ \"/assets/js/dark-mode.js\" | relative_url }}"></script>' $DEFAULT_FILE
fi

echo "✅ Setup complete! Run 'jekyll serve' to preview your blog locally."
