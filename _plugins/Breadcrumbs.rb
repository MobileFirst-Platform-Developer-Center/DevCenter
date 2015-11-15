#require 'pry'
#require 'pry-byebug'

def getPage(url,site)
  site['pages'].each do |page|

    if page.url == url
      return page
    end
  end
  return nil
end

Jekyll::Hooks.register :pages, :pre_render do |page, payload|
  if page.data["show_breadcrumb"]

    parts = page.url.split('/')
    aggregated = ''
    breadcrumbs = []
    i = 0
    parts.each do |part|
      aggregated = aggregated + part + '/'

      if i > 1
        temp = getPage(aggregated,payload['site'])
        if temp
          element = {}
          element['url'] = temp.url
          element['title'] = temp.data['title']
          breadcrumbs.push(element)
        end
      end
      i += 1
    end

    payload['page']['breadcrumbs'] = breadcrumbs
    # binding.pry

  end
end
