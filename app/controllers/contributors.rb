class Contributors
  attr_accessor :number, :login, :url
  def initialize(number, login, url)
    @number = number
    @login = login
    @url = url
  end
end
