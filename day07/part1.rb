# frozen_string_literal: true

require_relative '../input_fetcher'

INPUT = InputFetcher.day(7).split("\n")

RULE_REGEX = /(.+\w)\sbags\scontain\s(.+)\./.freeze
CONTAIN_REGEX = /(\d)\s(.+\w)\sbag/.freeze
MY_BAG = 'shiny gold'

class BagColorRule
  attr_reader :bag_color
  attr_accessor :contain

  # contain: { 'faded blue' => 2 }
  def initialize(bag_color, contain = {})
    @bag_color = bag_color
    @contain = contain
  end

  def can_hold?
    @can_hold = contain.keys.include?(MY_BAG) if @can_hold.nil?
    @can_hold
  end
end

ALL_BAG = Hash.new { |hash, key| hash[key] = BagColorRule.new(key) }

# Parsing
INPUT.each do |rule|
  rule_name, rules = rule.match(RULE_REGEX).captures
  current_rule = ALL_BAG[rule_name]

  rules.split(', ').each do |contain|
    next if contain.start_with?('no')

    count, name = contain.match(CONTAIN_REGEX).captures
    current_rule.contain[name] = count.to_i
  end
end

def can_hold?(bag_color_rule)
  bag_color_rule.can_hold? ||
    bag_color_rule.contain.each_key.any? { |bag_color| can_hold? ALL_BAG[bag_color] }
end

count = 0

ALL_BAG.each_value { |bag_color_rule| count += 1 if can_hold?(bag_color_rule) }

p count # => 242
