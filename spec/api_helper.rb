def sign_up(email, organisation, name)
  params = {'email' => email, 'password' => 'testpassword',
            'password_confirmation' => 'testpassword',
            'organisation' => organisation,'mobile' => '12345678910', 'name' => name}
  post '/api/v1/sign_up', :params => params
end

def sign_in(email)
  params = {'email' => email, 'password' => 'testpassword'}
  post '/api/v1/sign_in', :params => params
end

def post_shift(user_id)
  user = User.find(user_id)
  params = {'title' => user.name, 'start_time' => 1517540400000,
            'end_time' => 1517540400000, 'user_id' => user_id,
            'organisation' => user.organisation, 'email' => user.email }
  post '/api/v1/shifts', :params => params
end

def get_shifts(organisation)
  get '/api/v1/shifts', :params => {'organisation' => organisation}
end

def delete_shift(id)
  delete "/api/v1/shifts/#{id}"
end
