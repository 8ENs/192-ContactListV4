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
  @contacts = Contact.joins(:phones).where('(firstname || lastname || email || phone || label) LIKE ?', "%#{params[:query]}%").map do |contact|
    { contact: contact, digits: contact.phones }
  end.to_json
end

get '/contact/delete/:id' do
  @contact = Contact.find(params[:id])
  @contact.destroy if @contact
end

post '/contact/new' do
  response = {result: false}
  newContact = Contact.create(
    firstname:   params[:firstname],
    lastname:  params[:lastname],
    email:  params[:email]
  )

  response[:result] = true if newContact.valid?

  response.to_json
end

post '/contact/phone/new' do
  response = {result: false}
  newPhone = Phone.create(
    phone:   params[:phone],
    label:  params[:label],
    contact_id:  params[:contact_id]
  )

  response[:result] = true if newPhone.valid?

  response.to_json
end