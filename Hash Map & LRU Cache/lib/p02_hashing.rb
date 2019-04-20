class Integer
  # Integer#hash already implemented for you
end

class Array
  def hash
    hashed = 
    self.each do |ele|
      hashed += ele.unpack('h2H2c')
    end
    hashed.join('$')
  end
end

class String
  def my_hash
    hashed = []
    self.each_char do |ele|
      hashed = hashed.concat(ele.unpack('h2H2c'))
    end
    hashed.join('$')
  end
end

class Hash
  # This returns 0 because rspec will break if it returns nil
  # Make sure to implement an actual Hash#hash method
  def hash
    0
  end
end
