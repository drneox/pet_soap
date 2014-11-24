class MessageController < ApplicationController
include WashOut::SOAP
  	soap_action  "show",
  				args: {id: :integer},
  				return: {message: :string}
  	def show
  		message = Message.find(params[:id])
  		render :soap => {message: message.message}
  	end


  	soap_action  "new",
  				args: {message: :string},
  				return: {id: :integer, message: :string}
  	def new
  		message = Message.new(message: params[:message])
  		message.save
  		key = 'asdf1234'
    	encrypt_message = Digest::HMAC.hexdigest(message.message, key, Digest::SHA1)
  		render :soap => {id: message.id, message: encrypt_message}
  	end
end
