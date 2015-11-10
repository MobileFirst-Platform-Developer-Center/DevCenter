module Jekyll
  require 'pry'
  require 'pry-byebug'

  class TagPage < Page
    def initialize(site, base, dir, tag)
      @site = site
      @base = base
      @dir = dir
      @name = 'index.html'

      self.process(@name)
      self.read_yaml(File.join(base, '_layouts'), 'tagpage.html')
      self.data['tag'] = tag

      # category_title_prefix = site.config['category_title_prefix'] || 'Category: '
      # self.data['title'] = "#{category_title_prefix}#{category}"
      self.data['title'] = "#{tag}"
      self.data['filterByTag'] = "#{tag}"
    end
  end

  class TagPageGenerator < Generator
    safe true

    def generate(site)
      if site.layouts.key? 'tagpage'
        # binding.pry
        dir = site.config['tag_dir'] || 'blog/tag'
        site.tags.each_key do |tag|
          site.pages << TagPage.new(site, site.source, File.join(dir, tag), tag)
        end
      end
    end
  end

end
