# require 'pry'
# require 'pry-byebug'
require_relative  'get_children'

Jekyll::Hooks.register :pages, :pre_render do |page, payload|
  # binding.pry
  next unless page.data['show_children']
  next unless page.data['layout'] != 'redirect'
  payload.page['children'] = get_children(page.url, payload['site'])
  # binding.pry
end
