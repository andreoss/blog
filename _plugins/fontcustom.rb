module Jekyll
  class FontcustomFile < StaticFile
    def write(dest)
      FileUtils.copy_file(
        File.join(dest, "/../_temp/icons/#{@name}"),
        File.join(dest, @dir, @name)
      )
      true
    end
  end
  class FontcustomGenerator < Generator
    priority :low
    safe true
    def generate(site)
      system("#{site.config['source']}/_glyphs/compile.sh #{site.config['source']}/_temp/icons")
      system("mkdir -p #{site.config['source']}/_site/css")
      ['svg', 'ttf', 'woff', 'eot', 'css'].each do |ext|
        site.static_files << Jekyll::FontcustomFile.new(site, site.dest, 'css', "icons.#{ext}")
      end
    end
  end
end
