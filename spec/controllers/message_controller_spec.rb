require 'rails_helper'
require 'spec_helper'
require 'savon'

RSpec.describe MessageController, :type => :controller do
  application_base = "http://localhost:3000"
  client = Savon.client(wsdl: application_base + "/message/wsdl")
  $message = "Ola k ase" 
  it "new message" do  
    response = client.call(:new,  message: {"message" => $message})
    key = 'asdf1234'
    encrypt_message = Digest::HMAC.hexdigest($message, key, Digest::SHA1)
    expect(response.body[:new_response][:message]).to eq(encrypt_message)
    $id = response.body[:new_response][:id]
  end

  it "return message" do
    response = client.call(:show, message: {"id" => $id})
    expect(response.body[:show_response][:message]).to eq($message)
  end 

end
