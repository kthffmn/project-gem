module TemplateHelper
  def ruby_helper
    change_filename('lib/', 'file.rb', 'rb', formatted_project_name)
    change_filename('.', 'rspec', nil, '.rspec')
    edit_file('spec/spec_helper.rb', { file_name: formatted_project_name })
    edit_gemfile
  end

  def ruby_class_helper
    edit_file('spec/classname_spec.rb', { class_name: camel_case_class_name })
    edit_file('lib/file.rb', { class_name: camel_case_class_name })
    change_filename('spec/', 'classname_spec.rb', 'rb', "#{snake_case_class_name}_spec")
  end

  def java_class_helper
    edit_file('src/main/java/ClassName.java', { class_name: camel_case_class_name })
    edit_file('src/test/java/ClassNameTest.java', { class_name: camel_case_class_name })
    change_filename('src/test/java/', 'ClassNameTest.java', 'java', "#{camel_case_class_name}Test")
    change_filename('src/main/java/ClassName.java', 'ClassName.java', 'java', "#{camel_case_class_name}")
  end
end
