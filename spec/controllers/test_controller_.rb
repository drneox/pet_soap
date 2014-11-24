require 'spec_helper'
require 'savon'

describe DummieController do
  HTTPI.adapter = :rack
  HTTPI::Adapter::Rack.mount 'application', MyApp::Application

	it 'register message' do
  		application_base = "http//localhost:3000"
  		client = Savon::Client.new({wsdl => application_base + message_new_path})
  		message = "Ola k ase"
  		response = client.request :web, :register_message, body: {"message" => message}
  		key = 'asdf1234'
  		encrypt_message = Digest::HMAC.hexdigest(message, key, Digest::SHA1)
  		response.body[:message_response][:value].should_not be_nil
	end	

end