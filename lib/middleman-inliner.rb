require 'middleman-core'

class Inliner < Middleman::Extension
  def initialize(app, options_hash={}, &block)
    super
  end

  helpers do
    def inline_css(*names)
      app.sitemap.rebuild_resource_list!(:inline_css)

      names.map { |name|
        name += ".css" unless name.include?(".css")
        css_path = sitemap.resources.select { |p| p.source_file.include?(name) }
        puts css_path
        "<style type='text/css'>#{css_path.render}</style>"
      }.reduce(:+)
    end

    alias :stylesheet_inline_tag :inline_css
  end
end

::Middleman::Extensions.register(:inliner, Inliner)
