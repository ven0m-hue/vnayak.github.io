#!/bin/bash

# Create folders
mkdir -p _posts
mkdir -p assets
mkdir -p .github/workflows

# Create config file (overwrites existing)
cat >_config.yml <<'EOF'
title: "Fauxxx’s Portfolio"
email: your-email@example.com
description: >-
  Controls Engineer | Robotics | UAVs | AI & Controls
baseurl: "" # leave empty for user.github.io
url: "https://ven0m-hue.github.io"

theme: minima
markdown: kramdown
paginate: 5
paginate_path: "/blog/page:num/"

plugins:
  - jekyll-feed
  - jekyll-paginate

# Navigation links
header_pages:
  - about.md
  - projects.md
  - contact.md
  - resume.md
EOF

# Create index.md (landing page)
cat >index.md <<'EOF'
---
layout: home
title: Home
---

Welcome to my portfolio and blog!  
I write about **controls, robotics, UAVs, and embedded systems**.  

- 👉 [About Me](about)  
- 🚀 [Projects](projects)  
- ✉️ [Contact](contact)  
- 📄 [Resume](resume)  
EOF

# Create about.md
cat >about.md <<'EOF'
---
layout: page
title: About
permalink: /about/
---

# About Me
Hi, I’m Fauxxx — a Controls Engineer passionate about robotics, UAVs, and safe autonomous systems.
EOF

# Create projects.md
cat >projects.md <<'EOF'
---
layout: page
title: Projects
permalink: /projects/
---

# Projects
- 🚁 UAV Payload Delivery System @ Redwing  
- 🤖 Lateral Control for Autonomous Forklifts @ Flux Auto  
- 🛫 VTOL Pad with Thrust Vector Control  
EOF

# Create contact.md
cat >contact.md <<'EOF'
---
layout: page
title: Contact
permalink: /contact/
---

# Contact
You can reach me at:  
📧 [your-email@example.com](mailto:your-email@example.com)  
🔗 [GitHub](https://github.com/ven0m-hue)  
🔗 [LinkedIn](https://www.linkedin.com/in/your-profile/)  
EOF

# Create resume.md
cat >resume.md <<'EOF'
---
layout: page
title: Resume
permalink: /resume/
---

# Resume
[Download my Resume (PDF)](assets/Fauxxx_Resume.pdf)
EOF

# Create first blog post
cat >_posts/2025-09-01-welcome.md <<'EOF'
---
layout: post
title: "Welcome to My Blog"
date: 2025-09-01
---

This is my first post! I’ll write about controls, robotics, and UAVs.
EOF

echo "✅ Portfolio structure created successfully!"
