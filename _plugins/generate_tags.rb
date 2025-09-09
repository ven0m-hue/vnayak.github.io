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
