require_relative '../config/environment.rb'

module ProjectGenerator
  class TemplateMaker
    include TemplateHelper
    include GemfileHelper

    attr_reader :template_type, :project_name, :git

    TEMPLATES = ["ruby-method", "ruby-class"]
    EXTENTION_DICT = {"ruby" => "rb"}

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

    def create
      copy
      name_lab
      FileUtils.cd("#{project_name}") do
        git_init if run_git
        edit_readme
        if first_word(template_type) == "ruby"
          if template_type == "ruby-class"
            ruby_class_helper
          end
          touch_spec
          bundle_init
          ruby_helper
        else
          js_helper
        end
        git_add_commit_push if run_git
      end
      success_message
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
      EXTENTION_DICT[language]
    end

    def git_add_commit_push
      `bundle install`
      `git add .`
      `git commit -m "set up structure"`
      `subl .`
      `subl lib/#{formatted_project_name}.#{get_extention}`
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

    def touch_spec
      FileUtils.cd("spec/") do
        `touch #{formatted_project_name}_spec.rb`
      end
    end

    def change_filename(path, filename, extension, new_name)
      new_name = extension ? "#{new_name}.#{extension}": "#{new_name}"
      FileUtils.cd(path) do
        File.rename(filename, new_name)
      end
    end

    def edit_file(file, block)
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
