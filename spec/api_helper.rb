def sign_up(user_1 = true)
  if user_1
    params = {'email' => 'test@test.com', 'password' => 'testpassword',
              'password_confirmation' => 'testpassword',
              'organisation' => 'Makers Academy', 'mobile' => '12345678910'}
  else
    params = {'email' => 'test2@test.com', 'password' => 'testpassword',
              'password_confirmation' => 'testpassword',
              'organisation' => 'MacDonalds','mobile' => '12345678910'}
  end
  post '/api/v1/sign_up', :params => params
end

def sign_in(user_1 = true)
  if user_1
    params = {'email' => 'test@test.com', 'password' => 'testpassword',
              'password_confirmation' => 'testpassword'}
  else
    params = {'email' => 'test2@test.com', 'password' => 'testpassword',
              'password_confirmation' => 'testpassword'}
  end
  post '/api/v1/sign_in', :params => params
end

def post_shift(user_id, user_1 = true)
  if user_1
    org = "Makers Academy"
    email = "test@test.com"
  else
    org = "MacDonalds"
    email = "test2@test.com"
  end
  params = {'title' => email, 'start_time' => 1517540400000,
            'end_time' => 1517540400000, 'user_id' => user_id,
            'organisation' => org }
  post '/api/v1/shifts', :params => params
end

def get_shifts(organisation)
  get '/api/v1/shifts', :params => {'organisation' => organisation}
end

def delete_shift(id)
  delete "/api/v1/shifts/#{id}"
end
