# frozen_string_literal: true

def sign_up_get_user_id(email, organisation, name, job_title)
  params = { 'email' => email, 'password' => 'testpassword',
             'password_confirmation' => 'testpassword',
             'organisation' => organisation, 'mobile' => '12345678910', 'name' => name,
           'job_title' => job_title }
  post '/api/v1/sign_up', params: { 'email' => email, 'password' => 'testpassword',
             'password_confirmation' => 'testpassword',
             'organisation' => organisation, 'mobile' => '12345678910', 'name' => name, 'job_title' => job_title }
  return JSON.parse(response.body)['id']
end

def sign_in(email)
  params = { 'email' => email, 'password' => 'testpassword' }
  post '/api/v1/sign_in', params: params
end

def post_shift_get_id(user_id)
  user = User.find(user_id)
  params = { 'title' => user.name, 'start_time' => 1_517_540_400_000,
             'end_time' => 1_517_540_400_000, 'user_id' => user_id,
             'organisation' => user.organisation, 'email' => user.email }
  post '/api/v1/shifts', params: params
  return JSON.parse(response.body)['id']
end

def get_shifts(organisation)
  get '/api/v1/shifts', params: { 'organisation' => organisation }
end

def delete_shift(id)
  delete "/api/v1/shifts/#{id}"
end

def get_shifts_by_user(id)
   get "/api/v1/shiftsbyuser/#{id}"
end
