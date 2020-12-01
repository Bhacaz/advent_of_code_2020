# frozen_string_literal: true

require 'net/http'
require 'cgi'

class InputFetcher
  class << self
    def day(day)
      uri = URI("https://adventofcode.com/2020/day/#{day}/input")
      http = Net::HTTP.new(uri.host, 443)
      http.use_ssl = true
      request = Net::HTTP::Get.new(uri.request_uri)
      cookie = CGI::Cookie.new('session', token)
      request['Cookie'] = cookie.to_s
      http.request(request).body.split("\n")
    end

    private

    def token
      File.read('/Users/bhacaz/Documents/advent_of_code_2020/token.txt')
    end
  end
end
