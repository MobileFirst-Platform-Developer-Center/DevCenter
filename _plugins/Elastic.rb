# require 'pry'
# require 'pry-byebug'
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
      return unless site.config['elastic']

      # build an array of each lines I want to print
      lines = []

      # loop over blog posts
      site.posts.docs.each do |document|
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
        lines.push(index.to_json)

        # add it to the array
        lines.push(element.to_json)
      end

      # loop over pages
      site.pages.each do |document|
        next unless document['indexed']
        # get all the meta data
        element = document.data
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

        # create the index object
        index = {}
        index['index'] = {}
        index['index']['_id'] = element['hash']
        index['index']['_type'] = document['category']
        lines.push(index.to_json)

        # add it to the array
        lines.push(element.to_json)
        # binding.pry
      end

      site.pages << ElasticIndex.new(site, site.source, File.join('js/data/elastic'), lines)
      # binding.pry
    end
  end
end
