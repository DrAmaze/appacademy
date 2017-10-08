#require 'byebug'

class Array
  def my_each(&prc)
    i = 0
    while i < self.length
      prc.call(self[i])
      i += 1
    end
  end

  def my_select(&prc)
    arr = []
    self.my_each { |el| arr << el if prc.call(el) }
    p arr
  end

  def my_reject(&prc)
    arr = []
    self.my_each { |el| arr << el if !prc.call(el) }
    p arr
  end

  def my_any?(&prc)
    !self.my_select{|el|prc.call(el)}.empty?
  end

  def my_flatten
    arr = []
    self.my_each do |el|
      if el.is_a?(Array)
        arr += el.my_flatten
      else
        arr << el
      end
    end
    arr
  end

  def my_zip(*arrays)
    arr = []
    i = 0
    while i < self.length
      subarr = []
      subarr << self[i]
      arrays.each do |el|
        if el[i].nil?
          subarr << nil
        else
          subarr << el[i]
        end
      end
      arr << subarr
      i += 1
    end
    arr
  end

  def my_rotate(shift=1)
    if shift > 0
      shift = shift % self.length
    else
      shift = ((shift * -1) % self.length)*-1
    end
    arr = []
    i = 0
    until arr.length == self.length
      if i+shift == self.length
        i = shift*-1
      end
      arr << self[i+shift]
      i += 1
    end
    arr
  end

  def my_join(separator="")
    str = ""
    i = 0
    while i < self.length-1
      str += self[i] + separator
      i += 1
    end
    str += self[-1]
  end

  def my_reverse
    output = []
    i = self.length - 1
    while i >= 0
      output << self[i]
      i -= 1
    end
    output
  end

end
