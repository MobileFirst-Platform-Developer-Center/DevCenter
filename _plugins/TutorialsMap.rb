# require 'pry'
# require 'pry-byebug'
require_relative  'get_children'

Jekyll::Hooks.register :site, :pre_render do |site, payload|
  payload["site"]["data"]["tutorials"] = get_children("/tutorials/", payload["site"])
  # binding.pry

end
