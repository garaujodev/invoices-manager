class Invoice::Manager::Email < Micro::Case
  attributes :user, :params

  validates :user, kind: User
  validates :params, kind: ActionController::Parameters

  def call!
    invoice = Invoice.find_by(id: params[:invoice_id])
    emails = params[:emails]

    emails.each { |email| invoice.emails.create!(email: email) }

    Success { attributes }

  rescue ActiveRecord::RecordInvalid => e
    Failure :invalid_email, result: { errors: e.message }
  end
end
