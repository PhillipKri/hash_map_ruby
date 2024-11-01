class HashMap
  attr_accessor :buckets, :load_factor, :size
  def initialize(capacity = 16, load_factor = 0.75)
    @buckets = Array.new(capacity)
    @load_factor = load_factor
    @size = 0
  end

  def hash(key)
    hash_code = 0
    prime_number = 31
       
    key.each_char { |char| hash_code = prime_number * hash_code + char.ord }
       
    hash_code
  end

  def set(key, value)
    hash_code = hash(key)
    index = hash_code % @buckets.length
    check(index)
    
    if @buckets[index].nil?
      @buckets[index] = [[key, value]]
    else
      pair = @buckets[index].find { |k, _ | k == key }
      pair ? pair[1] = value : @buckets[index] << [key, value]
    end

    @size += 1

  end

  def get(key)
    hash_code = hash(key)
    index = hash_code % @buckets.length
    check(index)

    bucket = @buckets[index]
    return nil if bucket.nil?
    pair = bucket.find {|k, _| k == key}
    pair ? pair[1] : nil
    
  end

  def has?(key)
    !get(key).nil?
  end

  def remove(key)
    hash_code = hash(key)
    index = hash_code % @buckets.length
    check(index)

    bucket = @buckets[index]
    return nil if bucket.nil?

    pair = bucket.index {|k,_| k == key}
    return unless pair

    removed = bucket.delete_at(pair)
    @size -= 1
    removed[1]
  end

  def length
    @size
  end

  def clear
    @buckets = Array.new(@buckets.length)
  end

  def keys
    @buckets.compact.flatten(1).map(&:first)
  end

  def values
    @buckets.compact.flatten(1).map(&:last)
  end

  def entries
    @buckets.compact.flatten(1)
  end



  def check(index)
    raise IndexError if index.negative? || index >= @buckets.length
  end

end

