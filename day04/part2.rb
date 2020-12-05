require_relative '../input_fetcher'

require 'set'

INPUT = InputFetcher.day(4).split("\n\n")

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
  attr_reader :data

  def initialize(data)
    @data = data
  end

  def keys_set
    @keys_set ||= @data.keys.to_set
  end

  def minimum_field?
    keys_set_must_have = keys_set - ['cid']
    keys_set_must_have == MUST_HAVE_FIELDS
  end

  def fields_valid?
    minimum_field? && keys_set.all? do |field|
      send("#{field}_valid?".to_sym)
    end
  end

  def byr_valid?
    year = @data['byr'].to_i
    year >= 1920 && year <= 2002
  end

  def iyr_valid?
    year = @data['iyr'].to_i
    year >= 2010 && year <= 2020
  end

  def eyr_valid?
    year = @data['eyr'].to_i
    year >= 2020 && year <= 2030
  end

  def hgt_valid?
    unity = @data['hgt'][-2..-1]
    height = @data['hgt'][0..-3].to_i
    case unity
    when 'cm'
      height >= 150 && height <= 193
    when 'in'
      height >= 59 && height <= 76
    end
  end

  def hcl_valid?
    @data['hcl'].match? /^#[0-9a-f]{6}$/
  end

  COLORS = %w[amb blu brn gry grn hzl oth].freeze

  def ecl_valid?
    COLORS.include?(@data['ecl'])
  end

  def pid_valid?
    @data['pid'].match? /^[0-9]{9}$/
  end

  def cid_valid?
    true
  end
end

passports = passport_raw_data.map { |data| Passport.new(data) }

count = 0
passports.each do |pass|
  if pass.fields_valid?
    count += 1
  end
end
p count
