# require 'pry'
# require 'pry-byebug'
module Jekyll
  class PageByUrl < Liquid::Tag

    def initialize(tag_name, text, tokens)
      super
      input = text.strip
      @temp_url = input
      #binding.pry
    end

    def render(context)
      url = context[@temp_url] || @temp_url
      #binding.pry
      output = ""
      site = context.registers[:site]

      site.pages.each do |page|

        if page.url == url
          output = "#{page.data['title']}"
          break
        end
      end
      output
    end
  end
end

Liquid::Template.register_tag('page_by_url', Jekyll::PageByUrl)
