---
layout: post
title: Blog
permalink: /blog/
---


<div class="posts-list">
  {% for post in site.posts %}
    <article>
      <h2><a href="{{ post.url | relative_url }}">{{ post.title }}</a></h2>
      <p>{{ post.excerpt }}</p>
      <p><small>{{ post.date | date: "%b %-d, %Y" }}</small></p>
    </article>
  {% endfor %}
</div>
