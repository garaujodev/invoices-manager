class Invoice::Manager::List < Micro::Case
  attributes :user, :params

  validates :user, kind: User
  validates :params, kind: ActionController::Parameters

  def call!
    invoices = Invoice.where(user_id: user.id)

    Success result: { invoices: invoices }
  end
end
