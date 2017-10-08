
def range(start, last)
  return [] if last < start
  return [start] if start == last-1

  [start] + range(start+1, last)
end

def iter_range(start, last)
  i = start
  arr = []
  while i < last
    arr << i
    i += 1
  end
  arr
end

def sum(arr)
  return 0 if arr.length == 0
  return arr.last if arr.length == 1

  arr.first + sum(arr[1..-1])
end

def iter_sum(arr)
  i = 0
  sum = 0

  while i < arr.length
    sum += arr[i]
    i+=1
  end

  sum
end

def exp1(b, n)
  return 1 if n == 0
  return nil if n < 0 || b < 0

  b * exp1(b, n - 1)
end

def exp2(b, n)
  return 1 if n == 0
  return b if n == 1
  return nil if n < 0 || b < 0

  if n.even?
    exp2(b, n/2) ** 2
  else
    b * (exp2(b, (n-1) / 2) ** 2)
  end
end

def deep_dup(el)
  return el if !el.is_a?(Array)

  arr = []
  el.each do |obj|
    arr << deep_dup(obj)
  end

  arr
end

def fibonacci(n)
  return [1] if n == 1
  return [1,1] if n == 2
  return nil if n < 1

  arr = fibonacci(n-1)

  arr + [arr[-1] + arr[-2]]
end

def subsets(arr)
  return [] if arr.length == 0
  return arr.first if arr.length == 1
  puts "arr:#{arr.to_s}"
  subsets = []
  subsets << arr
  i = 0
  while i < arr.length-1
    new_arr = arr.dup
    new_arr.delete_at(i)
    subsets << new_arr
    i += 1
  end
  subset = arr[0...arr.length-1]
  subsets << make_pairs(subset, arr[arr.length-1])
  puts "subsets:#{subsets.to_s}"
  if arr.length != 3
    subsets << subsets(subset)
  else
    subsets << subset
  end
  subsets
end

def make_pairs(arr , num)
  subsets = []
  (0..arr.length-1).to_a.each do |i|
    new_arr = arr.dup
    new_arr.delete_at(i)
    subsets << new_arr
  end
  (0..arr.length-1).to_a.each do |i|
    new_arr = arr.dup
    new_arr.delete_at(i)
    new_arr << num
    (0..arr.length-1).to_a.each do |i2|
      new_arr2 = new_arr.dup
      new_arr2.delete_at(i2)
      subsets << new_arr2  if !subsets.include?(new_arr2)
    end
  end
  return subsets
end

def permutations(arr)
  return nil if arr.length == 0
  if !arr[0].is_a?(Array)
    new_arr = []
    new_arr << arr.dup.reverse
    new_arr << arr
    permutations(new_arr)
  else
    new_arr = arr[-1].dup
    new_arr = [new_arr.last] + new_arr[0...-1]
    new_arr2 = new_arr.dup.reverse
    arr << new_arr2
    arr << new_arr
    if arr.length == factorial(arr[0].length)
      return arr
    else
      permutations(arr)
    end
  end
end

def factorial(n)
  return 1 if n == 1
  n * factorial(n - 1)
end

def binary_search(arr, target)
  return nil if arr.length == 0
  return nil if arr.length == 1 && arr[0] != target

  half = arr.length / 2
  num = arr[half]
  if num == target
    return half
  elsif num < target
    new_arr = arr[half..-1]
    index = binary_search(new_arr, target)
    if index.nil?
      return nil
    else
      index + half
    end
  else
    new_arr = arr[0...half]
    binary_search(new_arr, target)
  end
end

def merge_sort(arr)
  return arr if arr.length <= 1

  half = arr.length / 2
  half1 = arr[0...half]
  half2 = arr[half..-1]

  result1 = merge_sort(half1)
  result2 = merge_sort(half2)

  merge(result1, result2)

end

def merge(arr1, arr2)
  new_arr = []
  while !arr1.empty? && !arr2.empty?
    if arr1.first >= arr2.first
      new_arr << arr2.shift
    else
      new_arr << arr1.shift
    end
  end
  if arr1.empty?
    new_arr.concat(arr2)
  elsif arr2.empty?
    new_arr.concat(arr1)
  end
  new_arr
end

def greedy_make_change(change, coins = [25, 10, 5, 1])
  return [] if coins.empty?
  coin_arr = []
  max_num = change / coins.first
  max_num.times {coin_arr << coins.first}
  coin_arr + greedy_make_change(change-coins.first*max_num, coins[1..-1])
end
#
# def make_better_change(change, coins = [25, 10, 5, 1])
#   return [] if coins.empty?
#   best_solution = []
#   coin_arr = []
#   i = 0
#   while i < coins.length
#     if change > coins.first
#       coin_arr << coins.first
#       change -= coins.first
#       best_solution += [coin_arr + greedy_make_change(change, coins)]
#       coin_arr + make_better_change(change, coins[1..-1])
#     elsif change == 0
#       coin_arr
#     else
#       coin_arr << make_better_change(change, coins[1..-1])
#     end
#     i += 1
#   end
#   puts best_solution.to_s
#   coin_arr
# end

# def make_better_change(change, coins = [25,10,5,1])
#   possible_solutions = []
#   next_coins = []
#   next_change = []
#   new_change = change
#
#   coins.each do |coin|
#     if change > coin
#       new_change = new_change - coin
#       possible_solutions += [coin] + greedy_make_change(new_change, coins)
#       temp = coins.dup
#       temp.delete(coin)
#       next_coins << temp
#       next_change << new_change
#     end
#   end
#
#   next_coins.each_with_index do |set, i|
#     possible_solutions += make_better_change(next_change[i], set)
#   end
#
#   puts possible_solutions.to_s
# end
#
# def make_change(change, coins = [10, 7, 1])
#   possible_solutions = []
#   solution = [0]
#   until solution.reduce(:+) == change
#     puts solution.reduce(:+)
#     if solution.reduce(:+) < change
#       solution << coins[0] unless (solution.reduce(:+) + coins[0]) > change
#     end
#     make_change(change - solution.reduce(:+), coins[1..-1])
#   end
#   puts possible_solution
#   possible_solutions << solution
#   possible_solutions
# end


def make_better_change(change, coins = [25,10,5,1])
  i = 0
  possible_solutions = []
  while i < coins.length
    arr = []
    if(change - coins[i] > 0)
      arr << coins[i]
      arr + make_better_change(change - coins[i], coins[1..-1])
    elsif(change - coins[i] == 0)
      arr << coins[i]
      possible_solutions << arr
      return arr
    end
    i+=1
  end
  puts arr.to_s
  arr
end
