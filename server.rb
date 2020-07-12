require "sinatra"
require "sinatra/base"
require "json"

class Server < Sinatra::Base
  def verify_signature(payload_body)
    signature = "sha1=" + OpenSSL::HMAC.hexdigest(OpenSSL::Digest.new("sha1"), ENV["SECRET_TOKEN"], payload_body)
    unless Rack::Utils.secure_compare(signature, request.env["HTTP_X_AUTIFY_SIGNATURE"])
      return halt 500, "Signatures didn't match!"
    end
  end

  post "/payload" do
    push = JSON.parse(request.body.read)
    puts "You've got a JSON: #{push.inspect}"
  end

  post "/secret-payload" do
    request.body.rewind
    payload_body = request.body.read
    verify_signature(payload_body)
    push = JSON.parse(payload_body)
    puts "You've got a JSON: #{push.inspect}"
  end
end
