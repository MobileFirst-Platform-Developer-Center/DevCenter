# require 'pry'
# require 'pry-byebug'

# This helper method is used to get the page object given a URL
def getPageByUrl(url, site)
  site['pages'].each do |page|
    return page if page.url == url
  end
  nil
end

# This helper method gives an array of pages that are on the same level (URL-wise)
def GetSiblings(url, site)
  # Caching mechanism
  if !site['siblings']
    site['siblings'] = {}
  elsif site['siblings'] && site['siblings']["#{url}"]
    return site['siblings'][url]
  end

  # Break down URL
  parts = url.split('/')
  target_level = parts.count
  parts.pop
  parent_url = parts.join('/') + '/'

  # Array to be returned
  siblings = []

  # Loop over all the pages, performance improvements welcomed
  site['pages'].each do |page|
    level = page.url.split('/').count
    # Look for URLs of the same level (number of /) and sharing the same parent.
    next unless (level == target_level) && (page.url.include? parent_url)
    element = {}

    if page.data['use_dropdown_home']
      element['url'] = page.url + page.data['use_dropdown_home']
    else
      element['url'] = page.url
    end

    if page.data['breadcrumb_title']
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

  siblings = siblings.sort { |x, y| x['weight'] <=> y['weight'] }

  # Caching
  site['siblings']["#{url}"] = siblings
  siblings
end

# The actual hook
Jekyll::Hooks.register :pages, :pre_render do |page, payload|
  # This hook only handles pages with a show_breadcrumb flag
  if page.data['show_breadcrumb']

    # Remove duplicate relevantTo (windows)
    if page.data['relevantTo'] && (page.data['relevantTo'].length > 1)
      # binding.pry
      payload['page']['relevantTo'].map! do |x|
        if x == 'windows8' || x == 'windows10' || x == 'windowsphone8' || x == 'windowsphone10'
          'windows'
        else
          x
        end
      end
      payload['page']['relevantTo'].uniq!
      # binding.pry
    end

    # Build the breadcrumbs
    parts = page.url.split('/')
    aggregated = ''
    breadcrumbs = []
    i = 0
    parts.each do |part|
      aggregated = aggregated + part + '/'

      if i > 1
        temp = getPageByUrl(aggregated, payload['site'])
        if temp
          element = {}
          element['url'] = temp.url

          if temp.data['breadcrumb_title']
            element['title'] = temp.data['breadcrumb_title']
          else
            element['title'] = temp.data['title']
          end

          if temp.data['use_dropdown']
            element['use_dropdown'] = true
            element['siblings'] = GetSiblings(temp.url, payload['site'])
          else
            element['use_dropdown'] = false
          end

          if temp.data['use_dropdown_url_replace']
            element['use_dropdown_url_replace'] = true
          else
            element['use_dropdown_url_replace'] = false
          end

          breadcrumbs.push(element)
        end
      end
      i += 1
    end
    payload.page['breadcrumbs'] = breadcrumbs
    # binding.pry

  end
end
