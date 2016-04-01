require_relative '../config/environment.rb'

module ProjectGenerator
  class TemplateMaker
    include TemplateHelper
    include GemfileHelper

    attr_reader :template_type, :project_name, :git

    def initialize(project_name, git)
      @template_type = "ruby"
      @project_name = project_name
      @git = git
    end

    def self.run(project_name, git)
      new(project_name, git).create
    end

    def create
      copy
      name_lab
      FileUtils.cd("#{project_name}") do
        git_init if !git.nil?
        edit_readme
        if template_type == "ruby"
          touch_spec
          bundle_init
          fundamental_helper
        else
          js_helper
        end
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

    def change_filename(path, filename, extension)
      FileUtils.cd(path) do
        File.rename(filename, "#{formatted_project_name}.#{extension}")
      end
    end

    def edit_file(file, text)
      new_rr = IO.read(file) % { file_name: text }
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
  end
end
