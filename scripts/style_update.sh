#!/bin/bash

# Paths
CSS_FILE="assets/css/style.scss"
JS_FILE="assets/js/theme-toggle.js"
HEADER_FILE="_includes/header.html"

echo "🔧 Updating styles..."
cat >>"$CSS_FILE" <<'EOF'

/* Navbar fix */
.navbar {
  display: flex;
  justify-content: space-between;
  align-items: center;
  padding: 0.5rem 1rem;
  position: fixed;
  top: 0;
  left: 0;
  right: 0;
  z-index: 1030;
  background-color: var(--bg-color, #fff);
}

body {
  margin: 0;
  padding-top: 60px;
}

body.dark-mode {
  --bg-color: #121212;
  --text-color: #f5f5f5;
}

body {
  background-color: var(--bg-color, #fff);
  color: var(--text-color, #000);
}
EOF

echo "📄 Writing JS toggle..."
mkdir -p assets/js
cat >"$JS_FILE" <<'EOF'
document.addEventListener("DOMContentLoaded", function () {
  const toggle = document.getElementById("theme-toggle");
  const body = document.body;

  if (localStorage.getItem("theme") === "dark") {
    body.classList.add("dark-mode"); }

  toggle.addEventListener("click", () => {
    body.classList.toggle("dark-mode");
    localStorage.setItem(
      "theme",
      body.classList.contains("dark-mode") ? "dark" : "light"
    );
  });
});
EOF

echo "📝 Updating header..."
cat >"$HEADER_FILE" <<'EOF'
<header class="navbar">
  <nav>
    <ul>
      <li><a href="{{ site.baseurl }}/about/">About</a></li>
      <li><a href="{{ site.baseurl }}/projects/">Projects</a></li>
      <li><a href="{{ site.baseurl }}/blog/">Blog</a></li>
      <li><a href="{{ site.baseurl }}/resume/">Resume</a></li>
      <li><a href="{{ site.baseurl }}/contact/">Contact</a></li>
    </ul>
  </nav>
  <button id="theme-toggle" aria-label="Toggle dark mode">🌙</button>
</header>
EOF

echo "✅ Done! Run 'bundle exec jekyll serve' and check locally."
