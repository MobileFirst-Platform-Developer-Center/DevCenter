require 'pry'
require 'pry-byebug'
require 'json'
require 'digest/md5'
module Jekyll
  class ElasticIndex < Page
    def initialize(site, base, dir, documents)
      @site = site
      @base = base
      @dir = dir
      @name = 'index.json'

      process(@name)
      read_yaml(File.join(base, '_layouts'), 'elasticindex.html')

      data['documents'] = documents
    end
  end

  class ElasticIndexGenerator < Generator
    safe true

    def generate(site)
      # build an array of each lines I want to print
      lines = []

      # loop over blog posts
      site.posts.docs.each do |document|
        # get all the meta data
        element = document.data
        # get the cleaned up content
        element["content"] = document.content.gsub(/<\/?[^>]*>/, "")
        #element["hash"] = document.url.hash
        element["hash"] = Digest::MD5.hexdigest(document.url)

        # create the index object
        index = {}
        index["index"] = {}
        index["index"]["_id"] = element["hash"]
        index["index"]["_type"] = "blog"
        lines.push(index.to_json)

        # add it to the array
        lines.push(element.to_json)
      end

      # loop over pages
      site.pages.each do |document|
        if(document["indexed"])
          # get all the meta data
          element = document.data
          # get the cleaned up content
          element["content"] = document.content.gsub(/<\/?[^>]*>/, "")
          # element["hash"] = document.url.hash
          element["hash"] = Digest::MD5.hexdigest(document.url)

          # insert version number
          if document.url.include? "/6.3/"
            element["version"] = "6.3"
          elsif document.url.include? "/7.0/"
            element["version"] = "7.0"
          elsif document.url.include? "/7.1/"
            element["version"] = "7.1"
          elsif document.url.include? "/8.0/"
            element["version"] = "8.0"
          end

          # create the index object
          index = {}
          index["index"] = {}
          index["index"]["_id"] = element["hash"]
          index["index"]["_type"] = document["category"]
          lines.push(index.to_json)

          # add it to the array
          lines.push(element.to_json)
          #binding.pry
        end
      end

      site.pages << ElasticIndex.new(site, site.source, File.join('js/data/elastic'), lines)
      #binding.pry
    end
  end
end
