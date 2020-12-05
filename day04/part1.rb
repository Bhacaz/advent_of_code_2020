require_relative '../input_fetcher'

require 'set'

INPUT = InputFetcher.day(4).split("\n\n").reject(&:empty?)

MUST_HAVE_FIELDS = %w[byr iyr eyr hgt hcl ecl pid].to_set.freeze
ALL_FIELDS = %w[byr iyr eyr hgt hcl ecl pid cid].to_set.freeze

passport_raw_data = INPUT.map do |line_password|
  raw_data = line_password.split(' ')
  raw_data.map! do |info|
    info.split(':')
  end
  raw_data.to_h
end

class Passport
  def initialize(data)
    @data = data
  end

  def keys_set
    @keys_set ||= @data.keys.to_set
  end

  def have_minimum_field?
    keys_set_must_have = keys_set - ['cid']
    keys_set_must_have == MUST_HAVE_FIELDS
  end
end

passports = passport_raw_data.map { |data| Passport.new(data) }

p passports.count(&:have_minimum_field?) # => 208
