# require 'redcarpet'
# class Redcarpet::Render::HTML
#   # A patch to allow Japanese headers.
#   # Remove once this is fixed and released:
#   # https://github.com/vmg/redcarpet/issues/538
#   def header(text, header_level)
#     %Q{<h#{header_level} id="#{text.downcase.gsub(" ", "-")}">#{text}</h#{header_level}>}
#   end
# end
