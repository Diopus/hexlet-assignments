# frozen_string_literal: true

class SetLocaleMiddleware
  def initialize(app)
    @app = app
  end

  # BEGIN
  def call(env)
    dup._call(env)
  end

  def _call(env)
    @request = Rack::Request.new(env)

    Rails.logger.debug "* Accept-Language: #{@request.env['HTTP_ACCEPT_LANGUAGE']}"
    locale = extract_locale_from_accept_language_header || I18n.default_locale
    Rails.logger.debug "* Locale set to '#{locale}'"

    I18n.locale = locale.to_sym

    @app.call(env)
  end

  private
    def extract_locale_from_accept_language_header
      http_accept_language = @request.env['HTTP_ACCEPT_LANGUAGE']
      return nil if http_accept_language.nil?
      http_accept_language.scan(/^[a-z]{2}/).first
    end
  # END
end
