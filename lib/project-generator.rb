require_relative '../config/environment.rb'

module ProjectGenerator
  class TemplateMaker
    include TemplateHelper
    include GemfileHelper

    attr_reader :template_type, :project_name, :git

    TEMPLATES = ["ruby-method", "ruby-class", "java-class"]
    EXTENTION_DICT = {ruby: "rb", java: "java"}
    DOCS = {
      ruby: "http://ruby-doc.org/core-2.3.0/",
      java: "https://docs.oracle.com/javase/8/docs/api/allclasses-noframe.html"
    }

    def initialize(template_type, project_name, git)
      @template_type = template_type
      @project_name = project_name
      @git = git
    end

    def self.run(template_type, project_name, git)
      new(template_type, project_name, git).create
    end

    def run_git
      !git.nil?
    end

    def rename_gitignore
      change_filename('.', 'gitignore', nil, '.gitignore')
    end

    def create
      copy
      name_lab
      FileUtils.cd("#{project_name}") do
        edit_readme
        rename_gitignore
        if first_word(template_type) == "ruby"
          config_ruby_template
        elsif first_word(template_type) == "java"
          config_java_template
        end
        setup_git if run_git
        open_docs
        open_files
      end
      success_message
    end

    def open_docs
      webpage = DOCS[language.to_sym]
      `/usr/bin/open -a "/Applications/Google Chrome.app" '#{webpage}'`
    end

    def open_files
      `subl .`
      `subl #{main_class_test_file_path}`
      `subl #{main_class_file_path}`
    end

    def config_ruby_template
      ruby_class_helper if template_type == "ruby-class"
      bundle_init
      ruby_helper
    end

    def config_java_template
      java_class_helper
    end

    def copy
      FileUtils.cp_r(FileFinder.location_to_dir("templates/#{template_type}"), FileUtils.pwd)
    end

    def name_lab
      FileUtils.mv(template_type, project_name)
    end

    def git_init
      `git init`
    end

    def language
      first_word(template_type)
    end

    def get_extention
      EXTENTION_DICT[language.to_sym]
    end

    def username
      `head -1 ~/.reposit`.strip
    end

    def setup_git
      `git init`
      `git add .`
      `git commit -m "set up structure"`
      `reposit #{project_name}`
      `git remote add origin git@github.com:#{username}/#{project_name}.git`
      `git push -u origin master`
    end

    def main_class_file_path
      if first_word(template_type) == "ruby"
        "lib/#{formatted_project_name}.#{get_extention}"
      elsif first_word(template_type) == "java"
        "src/main/java/#{camel_case_class_name}.#{get_extention}"
      else
        "."
      end
    end

    def main_class_test_file_path
      if first_word(template_type) == "ruby"
        "spec/#{formatted_project_name}_spec.#{get_extention}"
      elsif first_word(template_type) == "java"
        "src/test/java/#{camel_case_class_name}Test.#{get_extention}"
      else
        "."
      end
    end

    def edit_readme
      File.open("README.md", 'a') do |f|
        f << "\n# #{formatted_name}"
      end
    end

    def formatted_name
      project_name.gsub('-', ' ').split.map(&:capitalize).join(' ')
    end

    def formatted_project_name
      project_name.gsub('-', '_')
    end

    def bundle_init
      `bundle init`
    end

    def change_filename(path, filename, extension, new_name)
      new_name = extension ? "#{new_name}.#{extension}": "#{new_name}"
      FileUtils.cd(path) do
        File.rename(filename, new_name)
      end
    end

    def edit_file(file, block)
      puts "file: #{file}"
      new_rr = IO.read(file) % block
      File.open(file, 'w') { |f| f.write(new_rr) }
    end

    def edit_spec(file)
      File.open(file, 'w') { |f| f.write("require_relative './spec_helper'") }
    end

    def success_message
      puts "\n#{formatted_name} successfully created in #{FileUtils.pwd}\n"
      FileUtils.cd("#{project_name}") do
        puts "#{`tree`}"
      end
    end

    def first_word(hyphenated_compound)
      hyphenated_compound.match(/^(.*?)-/).captures[0]
    end

    def camel_case_class_name
      project_name.split('-').map(&:capitalize).join
    end

    def snake_case_class_name
      formatted_project_name
    end
  end
end
