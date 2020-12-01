# frozen_string_literal: true

require 'net/http'
require 'cgi'

class InputFetcher
  class << self
    def day(day)
      if file_cache?
        File.read('input.txt')
      else
        download_input(day)
      end
    end

    private

    def token
      File.read('/Users/bhacaz/Documents/advent_of_code_2020/token.txt')
    end

    def file_cache?
      File.exist?('input.txt')
    end

    def download_input(day)
      uri = URI("https://adventofcode.com/2020/day/#{day}/input")
      http = Net::HTTP.new(uri.host, 443)
      http.use_ssl = true
      request = Net::HTTP::Get.new(uri.request_uri)
      cookie = CGI::Cookie.new('session', token)
      request['Cookie'] = cookie.to_s
      content = http.request(request).body
      File.write('input.txt', content)
      content
    end
  end
end
