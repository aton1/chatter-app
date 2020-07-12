module Helpers
  module RequestHelpers
    def sign_in_as(user)
      post login_path, params: { session: { username: user.username, password: user.password } }
    end

    def sign_out_as(user)
      delete logout_path
    end
  end
end
