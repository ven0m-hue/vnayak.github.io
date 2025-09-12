---
layout: page
title: Projects
permalink: /projects/
---

# Projects

<ul>
  {% for project in site.projects %}
    <li>
      <a href="{{ project.url | relative_url }}">{{ project.title }}</a><br>
      {{ project.excerpt | strip_html | truncate: 150 }}
    </li>
  {% endfor %}
</ul>
