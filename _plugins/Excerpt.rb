# Jekyll::Page needs to have this method for Jekyll::Excerpt to work for it.
class Jekyll::Page
  def excerpt_separator
    site.config['excerpt_separator']
  end
end

Jekyll::Hooks.register :pages, :post_init do |page|
  # Set excerpt for pages if not specified in front matter
  page.data['excerpt'] ||= Jekyll::Excerpt.new(page).content
end
