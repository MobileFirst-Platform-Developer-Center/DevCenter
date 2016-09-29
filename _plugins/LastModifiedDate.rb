# Jekyll::Hooks.register :pages, :pre_render do |page, payload|
#   next unless payload.site['last_modified']
#   next unless !page.path.include? "blog/"
#   next unless !page.path.include? "sitemap.xml"
#   next unless !page.path.include? "feed.xml"
#   cmd = "git log -1 --format=%cd #{page.path}"
#   result = %x{ #{cmd} }
#   page.data["last-modified-date"] = result
# end
# Jekyll::Hooks.register :posts, :pre_render do |post, payload|
#   next unless payload.site['last_modified']
#   cmd = "git log -1 --format=%cd #{post.path}"
#   result = %x{ #{cmd} }
#   post.data["last-modified-date"] = result
# end
