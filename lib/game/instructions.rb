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
      » Regular move examples: 
          a2 a4
          d7 d5
      » Special move examples: (TODO)
          castle e8 c8 
          en passant b5 c6 
          promotion d7 d8 
      eos
  end

  def display
    puts @title
    puts @instructions
  end
end