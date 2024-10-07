# frozen_string_literal: true

require 'net/http'
require 'net/https'
require 'nokogiri'
require 'open-uri'

class Hacker
  class << self
    def hack(email, password)
      # BEGIN
      unless email.is_a?(String) && password.is_a?(String) && !email.empty? && !password.empty?
        puts 'Invalid email or password'
        return
      end

      hostname = 'https://rails-collective-blog-ru.hexlet.app'
      users_path = '/users'
      users_sign_up_path = '/users/sign_up'

      uri_users = URI.join(hostname, users_path)
      uri_sign_up = URI.join(hostname, users_sign_up_path)

      # get csrf-token and cookie
      token, cookie = get_token_and_cookie(uri_sign_up)

      params = {
        'user[email]': email,
        'user[password]': password,
        'user[password_confirmation]': password,
        authenticity_token: token
      }

      sign_up(uri_users, params, cookie)
      # END
    end

    private

    def get_token_and_cookie(uri)
      response = Net::HTTP.get_response(uri)
      html = Nokogiri::HTML(response.body)

      # searching with selector
      token_tag = html.at('input[name="authenticity_token"]')
      token = token_tag['value'] if token_tag

      # get cookie
      cookie = response.response['set-cookie'].split('; ')[0]

      puts "get_token_and_cookie: #{response.code}"
      [token, cookie]
    end

    def sign_up(uri, params, cookie)
      http = Net::HTTP.new(uri.host, uri.port)
      http.use_ssl = uri.scheme == 'https'
      http.verify_mode = OpenSSL::SSL::VERIFY_NONE

      request = Net::HTTP::Post.new uri
      request.body = URI.encode_www_form(params)
      request['Cookie'] = cookie

      response = http.request request
      puts "sign_up: #{response.code}"

      response
    end
  end
end
