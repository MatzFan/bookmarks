post '/links' do
  url = params[:url]
  title = params[:title]
  tags = params['tags'].split(' ').map do |tag|
    #find or create a new tag
    Tag.first_or_create(text: tag) # first_or_create is DataMapper method
  end
  Link.create(url: url, title: title, tags: tags) # tags is array
  redirect to '/'
end

get '/links/new' do
  # suppresses layout rendering for JS/Ajax requests (request.xhr? is true)
  # this is not needed because we do not need to render a new page :)
  erb :'links/new', :layout => !request.xhr?
end
