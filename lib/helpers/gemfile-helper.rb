module GemfileHelper
  def edit_gemfile
    File.open("Gemfile", 'a') do |f|
      f << "\nruby '2.3.0'\ngem 'rspec'\ngem 'pry'"
    end
  end

end