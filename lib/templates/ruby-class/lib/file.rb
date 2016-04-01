class %{class_name}

  # constant
  SHAPE_DICT = {3: 'triangle', 4: 'quadrilateral', 5: 'pentagon'}

  # class method
  def self.shape_name(sides)
    SHAPE_DICT.include?(sides) ? SHAPE_DICT[sides] : 'unknown'
  end

  # reader
  attr_reader :length, :width

  # initialize method
  def initialize(length, width)
    @length = length
    @width = width
  end

  # instance method
  def area
    length * width
  end

end
