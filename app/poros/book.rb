class Book
  attr_reader :isbn, :title, :publisher

  def initialize(info)
    @isbn = info[:isbn] # array of 2 strings
    @title = info[:title] # string
    @publisher = info[:publisher] # arroy of 1 string
  end
end
