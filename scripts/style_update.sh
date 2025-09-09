#!/bin/bash
set -e

echo "🚀 Setting up dark mode for your Jekyll site..."

# 1️⃣ Create CSS
mkdir -p assets/css
cat >assets/css/dark-mode.css <<'EOF'
/* Dark mode base */
body.dark-mode {
  background-color: #121212;
  color: #eaeaea;
}
body.dark-mode a { color: #bb86fc; }
body.dark-mode .navbar { background-color: #1f1f1f !important; }
body.dark-mode .card,
body.dark-mode .post-preview,
body.dark-mode .header-section {
  background-color: #1f1f1f;
  color: #eaeaea;
}

/* Dark mode toggle button */
#theme-toggle {
  border-radius: 50%;
  font-size: 1rem;
  width: 36px;
  height: 36px;
  display: flex;
  align-items: center;
  justify-content: center;
}
EOF

echo "✅ Created assets/css/dark-mode.css"

# 2️⃣ Create JS
mkdir -p assets/js
cat >assets/js/dark-mode.js <<'EOF'
(function() {
  const toggleBtn = document.getElementById("theme-toggle");
  if (!toggleBtn) return;

  const currentTheme = localStorage.getItem("theme");

  if (currentTheme === "dark") {
    document.body.classList.add("dark-mode");
    toggleBtn.textContent = "☀️";
  } else {
    toggleBtn.textContent = "🌙";
  }

  toggleBtn.addEventListener("click", function () {
    document.body.classList.toggle("dark-mode");

    let theme = "light";
    if (document.body.classList.contains("dark-mode")) {
      theme = "dark";
      toggleBtn.textContent = "☀️";
    } else {
      toggleBtn.textContent = "🌙";
    }
    localStorage.setItem("theme", theme);
  });
})();
EOF

echo "✅ Created assets/js/dark-mode.js"

# 3️⃣ Update header.html
mkdir -p _includes
cat >_includes/header.html <<'EOF'
{% assign date_format = site.date_format | default: "%B %-d, %Y" %}

<!-- Navbar -->
<nav class="navbar navbar-expand-lg navbar-light bg-light fixed-top">
  <div class="container">
    <a class="navbar-brand" href="{{ site.baseurl }}/">{{ site.title }}</a>
    <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav" 
      aria-controls="navbarNav" aria-expanded="false" aria-label="Toggle navigation">
      <span class="navbar-toggler-icon"></span>
    </button>

    <div class="collapse navbar-collapse" id="navbarNav">
      <!-- Left links -->
      <ul class="navbar-nav me-auto">
        {% for link in site.navbar-links %}
          <li class="nav-item">
            <a class="nav-link" href="{{ site.baseurl }}/{{ link[1] }}">{{ link[0] }}</a>
          </li>
        {% endfor %}
      </ul>

      <!-- Right side toggle button -->
      <ul class="navbar-nav">
        <li class="nav-item">
          <button id="theme-toggle" class="btn btn-outline-secondary btn-sm ms-2">🌙</button>
        </li>
      </ul>
    </div>
  </div>
</nav>
EOF

echo "✅ Updated _includes/header.html"

# 4️⃣ Update default.html for CSS + JS includes
DEFAULT_FILE="_layouts/default.html"

if ! grep -q "dark-mode.css" "$DEFAULT_FILE"; then
  sed -i '/<\/head>/i \
<link rel="stylesheet" href="{{ "/assets/css/dark-mode.css" | relative_url }}">' "$DEFAULT_FILE"
  echo "✅ Injected dark-mode.css into default.html"
fi

if ! grep -q "dark-mode.js" "$DEFAULT_FILE"; then
  sed -i '/<\/body>/i \
<script src="{{ "/assets/js/dark-mode.js" | relative_url }}"></script>' "$DEFAULT_FILE"
  echo "✅ Injected dark-mode.js into default.html"
fi

echo "🎉 Dark mode setup complete! Run 'bundle exec jekyll serve' to preview locally."
