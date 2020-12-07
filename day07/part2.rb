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

  def nesting_count
    if @nesting_count.nil?
      @nesting_count = 0
      contain.each do |name, count|
        @nesting_count += (ALL_BAG[name].nesting_count * count) + count
      end
    end
    @nesting_count
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

p ALL_BAG[MY_BAG].nesting_count # => 176035
