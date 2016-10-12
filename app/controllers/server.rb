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

    get '/sources/:IDENTIFIER/urls/:RELATIVEPATH' do
      @client = Client.find_by(identifier: params["IDENTIFIER"])
      @url = @client.urls.find_by(url: @client.root_url + "/#{params["RELATIVEPATH"]}")
      if !@url
        @status_code = 404
        @status_message = "Relative path #{params["RELATIVEPATH"]} not found"
        status 404
        body "Relative path #{params["RELATIVEPATH"]} not found"
        erb :error
      else
        erb :"urls/show"
      end
    end

    get '/sources/:IDENTIFIER/urls' do
      @client = Client.find_by(identifier: params["IDENTIFIER"])
      erb :"urls/index"
    end

# /sources/jumpstartlab/sources/jumpstartlab/events/socialLogin
    get '/sources/:IDENTIFIER/events/:EVENTNAME' do
      @client = Client.find_by(identifier: params["IDENTIFIER"])
      @event = @client.event_names.find_by(event_name: params["EVENTNAME"])
      @set = @client.payloads.where(event_name_id: @event.id)
      @times = @set.map{|payload| payload.parse_time}
      erb :"events/show"
    end

    get '/sources/:IDENTIFIER/events' do
      @client = Client.find_by(identifier: params["IDENTIFIER"])
      @events = @client.event_names.pluck(:event_name).uniq
      erb :"events/index"
    end

    get "/" do
      erb :index
    end

    post "/redirect" do
      @id = params["user"]
      redirect "/sources/#{@id}"
    end


  end
end
