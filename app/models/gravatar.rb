class Gravatar
  attr_reader :email

  def initialize(email, options = {})
    raise ArgumentError, "Expected :email" unless email
    @options = options || {}
    @email = email
  end

  def image_url(options = {})
    secure = options[:ssl] || options[:secure]
    proto = "http#{secure ? 's' : ''}"
    sub = secure ? "secure" : "www"

    "#{proto}://#{sub}.gravatar.com/avatar/#{email_hash}#{extension_for_image(options)}#{query_for_image(options)}"
  end

  def email_hash(email = self.email)
    Digest::MD5.hexdigest(email.downcase.strip)
  end

  def extension_for_image(options)
    options.key?(:filetype) || options.key?(:ext) ? "." + (options[:filetype] || options[:ext] || "jpg").to_s : ""
  end

  def query_for_image(options)
    query = ''
    [:rating, :size, :default, :forcedefault, :r, :s, :d, :f].each do |key|
      if options.key?(key)
        query.blank? ? query.concat("?") : query.concat("&")
        query.concat("#{key}=#{CGI::escape options[key].to_s}")
      end
    end
    query
  end
end
