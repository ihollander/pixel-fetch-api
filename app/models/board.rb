class Board
  attr_reader :id

  class << self
    def create(id)
      board = self.new(id)
      board.fill
      board
    end
  
    def find(id)
      if Redis.current.exists? id
        self.new(id)
      end
    end
  
    def find_or_create(id)
      self.find(id) || self.create(id)
    end
  end
  
  def initialize(id)
    @id = id
  end

  def fill
    l = 100
    w = 100
    bitfield = "\u0000" * (l * w * 4)
    Redis.current.set self.id, bitfield
  end

  def bitfield
    Redis.current.get self.id
  end

  def set_pixel(start_index, r, g, b, a)
    self.set_index(start_index, r)
    self.set_index(start_index + 1, g)
    self.set_index(start_index + 2, b)
    self.set_index(start_index + 3, a)
  end

  def set_index(index, value, enable_logging = true)
    command = ["BITFIELD", self.id, "SET", "u8", "##{index}", "#{value}"]
    puts command.join(" ") if enable_logging
    Redis.current.call command
  end

  # make it work with ActionCable
  def to_param
    self.id
  end

end