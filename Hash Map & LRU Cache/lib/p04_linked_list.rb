require "byebug"

class Node
  attr_reader :key
  attr_accessor :val, :next, :prev

  def initialize(key = nil, val = nil)
    @key = key
    @val = val
    @next = nil
    @prev = nil
  end

  def to_s
    "#{@key}: #{@val}"
  end

  def remove
    # optional but useful, connects previous link to next link
    # and removes self from list.
  end
end

class LinkedList
  attr_accessor :head, :tail

  include Enumerable

  def initialize
    @head = Node.new()
    @tail = Node.new()
    self.head.next = self.tail
    self.tail.prev = self.head
  end

  def [](i)
    each_with_index { |link, j| return link if i == j }
    nil
  end

  def first
    self.head.next
  end

  def last
    self.tail.prev
  end

  def empty?
    self.head.object_id == self.tail.prev.object_id &&
    self.tail.object_id == self.head.next.object_id
  end

  def get(key)
    self.each do |node|
      return node.val if node.key == key
    end
    nil
  end

  def include?(key)
    self.each do |node|
      return true if node.key == key
    end
    false
  end

  def append(key, val)
    new_node = Node.new(key, val)
    vtail = self.tail
    prev_node = vtail.prev

    new_node.next = tail
    new_node.prev = prev_node
    vtail.prev = new_node
    prev_node.next = new_node

  end

  def update(key, val)
     self.each do |node|
      return node.val = val if node.key == key
    end
  end

  def get_old(target_key)
    old_node = nil
    self.each do |node|
      old_node = node if node.key == target_key
    end
    return old_node
  end

  def remove(key)
    old_node = get_old(key)
    next_node = old_node.next
    prev_node = old_node.prev

    prev_node.next = next_node
    next_node.prev = prev_node
    old_node = nil
  end

  def each(&prc)
    start = self.head.next
    while start != self.tail
      prc.call(start)
      start = start.next
    end
  end

  # uncomment when you have `each` working and `Enumerable` included
  def to_s
    inject([]) { |acc, link| acc << "[#{link.key}, #{link.val}]" }.join(", ")
  end
end
