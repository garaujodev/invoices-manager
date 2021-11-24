class User
  module Register
    class Flow < Micro::Case
      flow Step::NormalizeParams,
           Step::CreateRecord,
           Step::SendEmail
    end
  end
end
