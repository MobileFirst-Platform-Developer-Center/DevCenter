# require 'pry'
# require 'pry-byebug'
require 'thread'
require 'thwait'
require 'pdfkit'
require 'fileutils'
PDFKit.configure do |config|
  # config.wkhtmltopdf = '/path/to/wkhtmltopdf'
  config.default_options = {
    page_size: 'A4',
    print_media_type: true,
    disable_external_links: true,
    disable_internal_links: true
  }
  config.root_url = 'https://pages.github.ibm.com'
  config.verbose = true
end

Jekyll::Hooks.register :site, :post_write do |site|
  next unless site.config['print_pdf']
  threads = []
  site.pages.each do |page|
    next unless page.data['print_pdf']
    # next unless page.url == '/tutorials/en/foundation/6.3/hello-world/previewing-application-mobile-web-desktop-browser/'
    # binding.pry
    prefix_folder = site.config['destination'] + '/pdf'
    source_file = File.new(site.config['destination'] + page.url + 'index.html')
    # binding.pry
    # Create the directory if not exists
    parts = page.url.split('/')
    parts.pop
    parent_folder = prefix_folder + parts.join('/') + '/'
    FileUtils.mkdir_p(parent_folder) unless File.exist?(parent_folder)

    # Define the file path
    file_name = prefix_folder + page.url.chomp('/') + '.pdf'
    threads << Thread.new {
      # Generate the PDF
      kit = PDFKit.new(source_file)
      file = kit.to_file(file_name)
    }
  end
  ThreadsWait.all_waits(*threads)
end
