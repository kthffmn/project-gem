module GemfileHelper
  def edit_gemfile
    File.open("Gemfile", 'a') do |f|
      f << "\ngem 'rspec'
gem 'pry'"
    end
  end

end