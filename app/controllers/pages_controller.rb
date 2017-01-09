class PagesController < ApplicationController

  def index
    puts "index"
  end

  def authorization
    binding.pry
    begin
      credentials = Google::Auth::UserRefreshCredentials.new(
       client_id: ENV["GOOGLE_AUTH_CLIENT_ID"],
       client_secret: ENV["GOOGLE_AUTH_CLIENT_SECRET"],
       scope: [
         "https://www.googleapis.com/auth/drive",
         "https://spreadsheets.google.com/feeds/",
       ],
        redirect_uri: "localhost:3000/authorization"
      )
      credentials.code = authorization_code
      credentials.fetch_access_token!
      session = GoogleDrive::Session.from_credentials(credentials)
    rescue Exception => error
      binding.pry
    end
  end

  def start_process
    credentials = Google::Auth::UserRefreshCredentials.new(
     client_id: ENV["GOOGLE_AUTH_CLIENT_ID"],
    client_secret: ENV["GOOGLE_AUTH_CLIENT_SECRET"],
     scope: [
       "https://www.googleapis.com/auth/drive",
       "https://spreadsheets.google.com/feeds/",
     ],
      redirect_uri: "localhost:3000/authorization"
    )

    auth_url = credentials.authorization_uri.to_s
    begin
      redirect_to auth_url
    rescue Exception => error
      binding.pry
    end
  end

end