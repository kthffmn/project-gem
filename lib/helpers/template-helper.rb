module TemplateHelper
  def fundamental_helper
    change_filename('lib/', 'file.rb', 'rb')
    edit_file('spec/spec_helper.rb', formatted_lab_name)
    edit_gemfile
  end

  def js_helper
    change_filename('js/', 'file.js', 'js')
  end

  def fe_helper
    edit_file('index.html', formatted_name)
  end
end