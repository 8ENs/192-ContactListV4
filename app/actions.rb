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

get '/find' do
  @contacts = Contact.where('firstname LIKE ? OR lastname LIKE ? OR email LIKE ?', "%#{params[:query]}%", "%#{params[:query]}%", "%#{params[:query]}%")
  erb :index
end

get '/delete' do
  @contact = Contact.find(params[:id])
  @contact.destroy
  erb :index
end

post '/new_contact' do
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

post '/add_phone' do
  @phone = Phone.new(
    phone:   params[:phone],
    label:  params[:label],
    contact_id:  params[:id]
  )
  if @phone.save
    redirect '/'
  else
    erb :index
  end
end