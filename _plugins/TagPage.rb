module Jekyll

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

  class TagAtom < Page
    def initialize(site, base, dir, tag)
      @site = site
      @base = base
      @dir = dir
      @name = "#{tag}.xml"

      self.process(@name)
      self.read_yaml(File.join(base, '_layouts'), 'atom.html')
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
        site.tags.each_key do |tag|
          site.pages << TagPage.new(site, site.source, File.join('blog/tag', tag), tag)
          site.pages << TagAtom.new(site, site.source, File.join('blog/atom'), tag)
        end
      end
    end
  end

end
