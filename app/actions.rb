# Homepage (Root path)
get '/' do
  erb :index
end

get '/contacts' do
  @contacts = Contact.all.map do |contact|
    { contact: contact, digits: contact.phones }
  end.to_json
end

get '/contacts/find' do
  @contacts = Contact.where('firstname LIKE ? OR lastname LIKE ? OR email LIKE ?', "%#{params[:query]}%", "%#{params[:query]}%", "%#{params[:query]}%").map do |contact|
    { contact: contact, digits: contact.phones }
  end.to_json
end

get '/contact/delete' do
  @contact = Contact.find(params[:id])
  @contact.destroy
  erb :index
end

post '/contact/new' do
  response = {result: false}
  newContact = Contact.create(
    firstname:   params[:firstname],
    lastname:  params[:lastname],
    email:  params[:email]
  )
  
  if newContact
    response[:result] = true 
    response[:id] = newContact.id
    response[:firstname] = newContact.firstname
    response[:lastname] = newContact.lastname
    response[:email] = newContact.email
  end

  response.to_json
end

post '/contact/phone/new' do
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