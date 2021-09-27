class Api::V1::UserSerializer
  include FastJsonapi::ObjectSerializer

  def self.generate_api_key(new_user)
    {
      "data": {
        "type": "users",
        "id": new_user.id.to_s,
        "attributes": {
          "email": new_user.email,
          "api_key": "jgn983hy48thw9begh98h4539h4"
        }
      }
    }
  end
end
