# require 'pry'
# require 'pry-byebug'
require 'pdfkit'
require 'fileutils'
PDFKit.configure do |config|
  # config.wkhtmltopdf = '/path/to/wkhtmltopdf'
  config.default_options = {
    :page_size => 'A4',
    :print_media_type => true
  }
  # Use only if your external hostname is unavailable on the server.
  # config.root_url = "http://localhost"
  # config.verbose = false
end

Jekyll::Hooks.register :pages, :post_write do |page|
  #binding.pry
  if page.data["print_pdf"]
    prefix_folder = '_site/pdf'
    # binding.pry
    # Create the directory if not exists
    parts = page.url.split('/')
    parts.pop()
    parent_folder = prefix_folder + parts.join('/') + '/'
    FileUtils.mkdir_p(parent_folder) unless File.exists?(parent_folder)

    # Define the file path
    file_name = prefix_folder + page.url.chomp('/') + '.pdf'

    # Generate the PDF
    kit = PDFKit.new(page.output)
    kit.stylesheets << '_site/css/combined.css'
    file = kit.to_file(file_name)
  end
end
