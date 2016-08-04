class Instructions
  attr_reader :title, :instructions

  def initialize
    @title = <<~eos
      ╔═╗╦ ╦╔═╗╔═╗╔═╗
      ║  ╠═╣║╣ ╚═╗╚═╗
      ╚═╝╩ ╩╚═╝╚═╝╚═╝
    eos
    
    @instructions = <<~eos
      » Welcome to Ruby Chess
      » Regular move examples: a2 a4
      eos
  end

  def display
    puts @title
    puts @instructions
  end
end