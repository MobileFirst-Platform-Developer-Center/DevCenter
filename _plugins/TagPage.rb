module Jekyll
  # This generates a Page showing all blog posts for a specific tag
  class TagPage < Page
    def initialize(site, base, dir, tag)
      @site = site
      @base = base
      @dir = dir
      @name = 'index.html'

      process(@name)
      read_yaml(File.join(base, '_layouts'), 'tagpage.html')
      data['tag'] = tag

      data['title'] = tag.tr '_', ' '
      data['filterByTag'] = "#{tag}"
    end
  end

  # This generates an Atom feed for a specific tag
  class TagAtom < Page
    def initialize(site, base, dir, tag)
      @site = site
      @base = base
      @dir = dir
      @name = "#{tag}.xml"

      process(@name)
      read_yaml(File.join(base, '_layouts'), 'atom.html')
      data['tag'] = tag

      data['title'] = "#{tag}"
      data['filterByTag'] = "#{tag}"
    end
  end

  class TagPageGenerator < Generator
    safe true

    # Generate tag page and atom feed for each tag used in the blogs
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
