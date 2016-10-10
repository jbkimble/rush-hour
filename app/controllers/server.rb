module RushHour
  class Server < Sinatra::Base
    not_found do
      erb :error
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

  end
end
