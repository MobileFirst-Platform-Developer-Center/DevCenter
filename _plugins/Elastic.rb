# require 'pry'
# require 'pry-byebug'
require 'json'
require 'digest/md5'
Jekyll::Hooks.register :site, :post_write do |site|
  next unless site.config['elastic']

  File.open(site.config['destination'] + '/js/data/elastic.json','w+') {|f|

    # loop over blog posts
    site.posts.docs.each do |document|
      next unless document['indexed']
      next unless document.data["layout"]!="redirect"
      # get all the meta data
      element = document.data.clone
      element.delete('excerpt')
      element['hash'] = Digest::MD5.hexdigest(document.url)
      element['url'] = document.url
      element['type'] = 'blog'
      # get the cleaned up content
      element['content'] = document.content.gsub(/<\/?[^>]*>/, '')
      element['content'] = element['content'].delete('#')
      element['summary'] = element['content'][0, 400]

      if document.data["version"]
        # prepare the version list
        if document.data["version"].is_a?(String)
          element["version"] = [document.data["version"]]
        elsif document.data["version"].is_a?(Array)
          element["version"] = []
          document.data["version"].each do |version|
            element["version"].push("#{version}")
          end
        end

      end

      # create the index object
      index = {}
      index['index'] = {}
      index['index']['_id'] = element['hash']
      index['index']['_type'] = 'blog'

      # write the element with its index action
      f.puts(index.to_json)
      f.puts(element.to_json)
    end

    # loop over pages
    site.pages.each do |document|
      next unless document['indexed']
      next unless document.data["layout"]!="redirect"
      # get all the meta data
      element = document.data.clone
      element.delete('breadcrumbs')
      element.delete('children')
      element['hash'] = Digest::MD5.hexdigest(document.url)
      element['url'] = document.url
      element['type'] = document['category']
      # get the cleaned up content
      element['content'] = document.content.gsub(/<\/?[^>]*>/, '')
      element['content'] = element['content'].delete('#')
      element['summary'] = element['content'][0, 400]

      # insert version number
      if document.url.include? '/6.3/'
        element['version'] = ['6.3']
      elsif document.url.include? '/7.0/'
        element['version'] = ['7.0']
      elsif document.url.include? '/7.1/'
        element['version'] = ['7.1']
      elsif document.url.include? '/8.0/'
        element['version'] = ['8.0']
      end

      # insert language
      if document.url.include? '/en/'
        element['language'] = ['en']
      elsif document.url.include? '/es/'
        element['language'] = ['es']
      elsif document.url.include? '/fr/'
        element['language'] = ['fr']
      elsif document.url.include? '/ko/'
        element['language'] = ['ko']
      elsif document.url.include? '/pt-br/'
        element['language'] = ['pt']
      elsif document.url.include? '/ru/'
        element['language'] = ['ru']
      elsif document.url.include? '/de/'
        element['language'] = ['de']
      elsif document.url.include? '/zh-hans/'
        element['language'] = ['zh']
      elsif document.url.include? '/ja/'
        element['language'] = ['ja']
      end

      # create the index object
      index = {}
      index['index'] = {}
      index['index']['_id'] = element['hash']
      index['index']['_type'] = document['category']

      # write the element with its index action
      f.puts(index.to_json)
      f.puts(element.to_json)
    end

    # loop over videos
    site.data["videos"].each do |video|
      #binding.pry
      element = video.clone
      element["type"] = "video"
      element["title"] = element["caption"].clone
      element.delete("caption")
      element['hash'] = Digest::MD5.hexdigest(element["url"])

      # create the index object
      index = {}
      index['index'] = {}
      index['index']['_id'] = element['hash']
      index['index']['_type'] = "video"

      # write the element with its index action
      f.puts(index.to_json)
      f.puts(element.to_json)

    end

  }

end
