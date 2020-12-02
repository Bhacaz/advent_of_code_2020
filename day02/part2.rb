require_relative '../input_fetcher'

INPUT = InputFetcher.day(2).split("\n")

password_objects = []

class PasswordsAndPolicies
  def initialize(policy_min, policy_max, letter, password)
    @policy_min = policy_min
    @policy_max = policy_max
    @letter = letter
    @password = password
  end

  def valid?
    first_occurence = @password[@policy_min - 1]
    second_occurence = @password[@policy_max - 1]
    (first_occurence == @letter || second_occurence == @letter) && first_occurence != second_occurence
  end
end

INPUT.each do |password_and_policy|
  policy, letter, password = password_and_policy.split(' ')
  min, max = policy.split('-').map(&:to_i)
  letter.gsub!(':', '')

  password_objects << PasswordsAndPolicies.new(min, max, letter, password)
end

puts password_objects.count(&:valid?) # => 747
