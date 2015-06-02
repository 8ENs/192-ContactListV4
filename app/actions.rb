# Homepage (Root path)
get '/' do #, map: '/index', provides: [:html, :json] do
  erb :index
  # erb :'contacts/index'

  # @contacts = Contact.all

  # case content_type
  # when :html
  #   erb :index
  #   render '/'
  # when :json
  #   @contacts.to_json
  # end
end

get '/all' do
  @contacts = Contact.all
  erb :index
end

post '/new' do
  @contact = Contact.new(
    firstname:   params[:firstname],
    lastname:  params[:lastname],
    email:  params[:email]
  )
  if @contact.save
    redirect '/'
  else
    erb :index
  end
end

get '/find' do
  @contacts = Contact.where('firstname LIKE ? OR lastname LIKE ? OR email LIKE ?', "%#{params[:query]}%", "%#{params[:query]}%", "%#{params[:query]}%")
  erb :index
end