#!/bin/bash

set -e

echo "Updating Fauxxx Portfolio theme..."

# Ensure directories
mkdir -p _includes assets/css assets/js

# Write header.html
cat >_includes/header.html <<'EOF'
<nav class="navbar">
  <div class="navbar-left">
    <a href="{{ '/' | relative_url }}" class="site-title">Fauxxx's Portfolio</a>
    <button id="theme-toggle" aria-label="Toggle dark mode">🌙</button>
  </div>
  <ul class="nav-links">
    <li><a href="{{ '/about/' | relative_url }}">About Me</a></li>
    <li><a href="{{ '/projects/' | relative_url }}">Projects</a></li>
    <li><a href="{{ '/blog/' | relative_url }}">Blog</a></li>
    <li><a href="{{ '/resume/' | relative_url }}">Resume</a></li>
    <li><a href="{{ '/contact/' | relative_url }}">Contact</a></li>
  </ul>
</nav>
EOF

# Write style.css
cat >assets/css/style.css <<'EOF'
/* Root theme variables */
:root {
  --bg-color: #ffffff;
  --text-color: #000000;
  --link-color: #007bff;
}

body {
  background-color: var(--bg-color);
  color: var(--text-color);
  margin: 0;
  padding-top: 60px; /* space for navbar */
}

a {
  color: var(--link-color);
  text-decoration: none;
}

a:hover {
  text-decoration: underline;
}

/* Dark mode overrides */
body.dark-mode {
  --bg-color: #121212;
  --text-color: #f5f5f5;
  --link-color: #66aaff;
}

/* Navbar styles */
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
  background-color: var(--bg-color);
  border-bottom: 1px solid #ddd;
}

.navbar-left {
  display: flex;
  align-items: center;
  gap: 0.5rem;
}

.site-title {
  font-weight: bold;
  font-size: 1.2rem;
  color: var(--text-color);
}

.nav-links {
  list-style: none;
  display: flex;
  gap: 1rem;
  margin: 0;
  padding: 0;
}

.nav-links a {
  color: var(--text-color);
  font-weight: 600;
}

#theme-toggle {
  border: none;
  background: none;
  cursor: pointer;
  font-size: 1.2rem;
}
EOF

# Write JS
cat >assets/js/theme-toggle.js <<'EOF'
(function() {
  const toggleBtn = document.getElementById("theme-toggle");
  if (!toggleBtn) return;

  // Apply saved mode
  const savedTheme = localStorage.getItem("theme");
  if (savedTheme === "dark") {
    document.body.classList.add("dark-mode");
    toggleBtn.textContent = "☀️";
  }

  toggleBtn.addEventListener("click", () => {
    document.body.classList.toggle("dark-mode");
    if (document.body.classList.contains("dark-mode")) {
      localStorage.setItem("theme", "dark");
      toggleBtn.textContent = "☀️";
    } else {
      localStorage.setItem("theme", "light");
      toggleBtn.textContent = "🌙";
    }
  });
})();
EOF

echo "✅ Update complete! Now run: bundle exec jekyll serve"
