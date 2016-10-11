require 'pry'

module RushHour
  class Server < Sinatra::Base
    not_found do
      erb :error
    end

    post '/sources/:IDENTIFIER/data' do
      client = Client.find_by(identifier:params["IDENTIFIER"])
      if params[:payload].nil?
        status 400
        body "Missing Payload - 400 Bad Request"
      elsif !client
        status 403
        body "Application Not Registered - 403 Forbidden"
      elsif Payload.already_exists?(params)
        status 403
        body "Already Recieved Request  #{ params["IDENTIFIER"]} -  403 Forbidden "
      else
        client.populate(params[:payload])
        status 200
      end
    end

    post '/sources' do
      @identifier = params[:identifier]
      @root_url = params[:rootUrl]

      if @identifier.nil? || @root_url.nil?
        status 400
        body "Missing Parameters - 400 Bad Request"
      elsif Client.exists?(:identifier => @identifier)
        status 403
        body "#{@identifier} Already Exists - 403 Forbidden"
      else
        Client.create(identifier: @identifier, root_url: @root_url)
        status 200
        body "identifier: #{@identifier}"
      end
    end

    get "/sources/:IDENTIFIER" do
      @client = Client.find_by(identifier: params["IDENTIFIER"])

      if !@client
        @status_code = 404
        @status_message = "#{params["IDENTIFIER"]} not found"
        status 404
        body "#{params["IDENTIFIER"]} not found"
        erb :error
      elsif @client && @client.payloads.empty?
        @status_code = 404
        @status_message = "#{params["IDENTIFIER"]} payloads not found"
        status 404
        body "#{params["IDENTIFIER"]} payloads not found"
        erb :error
      else
        erb :show
      end
    end

  end
end
