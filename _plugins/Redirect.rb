require 'pry'
require 'pry-byebug'
module Jekyll
  # This generates a Page showing redirecting to new_url
  class RedirectPage < Page
    def initialize(site, base, dir, new_url)
      @site = site
      @base = base
      @dir = dir
      @name = 'index.html'

      process(@name)
      read_yaml(File.join(base, '_layouts'), 'redirect.html')
      data['new_url'] = new_url
      data['is_redirect'] = true
    end
  end

  class RedirectPageGenerator < Generator
    safe true

    # Look for pages that need redirection
    def generate(site)
      if site.layouts.key? 'redirect'
        site.pages.each do |page|
          next unless (page['is_redirect'] != true)
          # binding.pry
          old_url = page.url.sub '/tutorials/en/foundation/7.0/', 'documentation/getting-started-7-0/'
          old_url = old_url.sub '/tutorials/en/foundation/6.3/', 'documentation/getting-started-6-3/'
          old_url = old_url.sub '/tutorials/en/foundation/7.1/', 'documentation/getting-started-7-1/foundation/'
          
          old_url = old_url.sub '/tutorials/en/product-integration/7.1/', 'documentation/integration-7-1/'
          old_url = old_url.sub '/tutorials/en/product-integration/7.0/', 'documentation/integration-7-0/'
          old_url = old_url.sub '/tutorials/en/product-integration/6.3/', 'documentation/integration-6-3/'
          next unless old_url != page.url
          new_url = site.baseurl + page.url
          site.pages << RedirectPage.new(site, site.source, File.join(old_url), new_url)
        end
      end
    end
  end
end
