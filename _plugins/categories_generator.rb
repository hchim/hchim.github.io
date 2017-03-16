module Jekyll
  class CategoriesGenerator < Generator

    def generate(site)
        cats_dir = Dir.pwd + '/cats'

        if !Dir.exists?(cats_dir)
            puts "Creating categories dir"
            Dir.mkdir(cats_dir)
        end
        regenerate_flag = false

        site.categories.each do |i|
            if !File.exists?(cats_dir + '/' + i[0])
                puts "Creating category page for: " + i[0]
                cat_file = File.new(cats_dir + '/' + i[0] + '.markdown', "w")
                cat_file.puts("---\nlayout: category\ntitle: " + i[0] + "\npermalink: /cats/" + i[0] + "/\n---")
                cat_file.close

                regenerate_flag = true
            end
        end

        if regenerate_flag
            FileUtils.touch Dir.pwd+'/_config.yml'
        end

    end
  end
end