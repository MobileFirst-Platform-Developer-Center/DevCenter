#require 'pry'
#require 'pry-byebug'

def getPageByUrl(url,site)
  site['pages'].each do |page|

    if page.url == url
      return page
    end
  end
  return nil
end

def GetSiblings(url,site)
  parts = url.split('/')
  target_level = parts.count
  parts.pop()
  parent_url = parts.join('/') + '/'

  siblings = []

  site['pages'].each do |page|
    level = page.url.split('/').count
    if (level == target_level) && (page.url.include? parent_url)
      element = {}

      if page.data['use_dropdown_home']
        element['url'] = page.url + page.data['use_dropdown_home']
      else
        element['url'] = page.url
      end

      if(page.data['breadcrumb_title'])
        element['title'] = page.data['breadcrumb_title']
      else
        element['title'] = page.data['title']
      end

      if page.data['weight']
        element['weight'] = page.data['weight']
      else
        element['weight'] = 1000
      end

      siblings.push(element)
    end
  end

  siblings = siblings.sort {|x,y| x['weight'] <=> y['weight'] }
  # binding.pry
  return siblings
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
        temp = getPageByUrl(aggregated,payload['site'])
        if temp
          element = {}
          element['url'] = temp.url

          if(temp.data['breadcrumb_title'])
            element['title'] = temp.data['breadcrumb_title']
          else
            element['title'] = temp.data['title']
          end

          if(temp.data['use_dropdown'])
            element['use_dropdown'] = true
            element['siblings'] = GetSiblings(temp.url,payload['site'])
          else
            element['use_dropdown'] = false
          end
          breadcrumbs.push(element)
        end
      end
      i += 1
    end

    payload['page']['breadcrumbs'] = breadcrumbs
    # binding.pry

  end
end
