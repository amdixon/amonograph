class DropboxController < ApplicationController
  def index
    client = get_dropbox_client
    unless client
      redirect_to(:action => 'auth_start') and return
    end

    account_info = client.account_info

    render :inline =>
    "#{account_info['email']}"


    # info = client.metadata("/", file_limit=100, list=true)['contents']

    # @imageArr ||= []

    # (0..info.length-1).each do |i|
    #   image = info[i]['path']
    #   yessir = client.media(image)['url']

    #   @imageArr << yessir
    # end

    # respond_to do |format|
    #   format.html { render :html => info }
    # end
  end

  def show
    @email = params[:id]
  end


  def get_dropbox_client
    if session[:access_token]
      begin
          access_token = session[:access_token]
          DropboxClient.new(access_token)
      rescue
          # Maybe something's wrong with the access token?
          session.delete(:access_token)
          raise
      end
    end
  end


  def get_web_auth()
      redirect_uri = url_for(:action => 'auth_finish')
      DropboxOAuth2Flow.new(APP_KEY, APP_SECRET, redirect_uri, session, :dropbox_auth_csrf_token)
  end

  def auth_start
      authorize_url = get_web_auth().start()

      # Send the user to the Dropbox website so they can authorize our app.  After the user
      # authorizes our app, Dropbox will redirect them here with a 'code' parameter.
      redirect_to authorize_url
  end

  def auth_finish
      begin
          access_token, user_id, url_state = get_web_auth.finish(params)
          session[:access_token] = access_token
          
          # redirect_to request_token.authorize_url(:oauth_callback => "http://#{request.host_with_port}/dropbox/callback")
          
          @@client = get_dropbox_client
          data = @@client.metadata('/')
          @pages = []
          data['contents'].each do |d|
            @pages << d['path']
            download_and_create(@pages)
          end
          
          redirect_to :controller => 'signup', :action => 'new'
          
      rescue DropboxOAuth2Flow::BadRequestError => e
          render :text => "Error in OAuth 2 flow: Bad request: #{e}"
      rescue DropboxOAuth2Flow::BadStateError => e
          logger.info("Error in OAuth 2 flow: No CSRF token in session: #{e}")
          redirect_to(:action => 'auth_start')
      rescue DropboxOAuth2Flow::CsrfError => e
          logger.info("Error in OAuth 2 flow: CSRF mismatch: #{e}")
          render :text => "CSRF error"
      rescue DropboxOAuth2Flow::NotApprovedError => e
          render :text => "Not approved?  Why not, bro?"
      rescue DropboxOAuth2Flow::ProviderError => e
          logger.info "Error in OAuth 2 flow: Error redirect from Dropbox: #{e}"
          render :text => "Strange error."
      rescue DropboxError => e
          logger.info "Error getting OAuth 2 access token: #{e}"
          render :text => "Error communicating with Dropbox servers."
      end
  end
  
  private
  
  def download_and_create(obj)
    if obj.any?
      obj.each do |f|
        path = download_file_from_url(f)
        dp_file = File.open(path) if File.exists?(path)
        if dp_file
          Page.create(:file => dp_file)
          File.delete(dp_file)
        end
      end
    end
  end
  
  def download_file_from_url(f)
    real_path = @@client.media(f)['url'].to_s
    destination_file_full_path = Rails.root.to_s + f.to_s
    begin
      open(destination_file_full_path, 'wb') do |file|
      file << open(real_path).read
    end
    rescue
      puts "Exception occured while downloading..."
    end
    destination_file_full_path
  end
 

end
