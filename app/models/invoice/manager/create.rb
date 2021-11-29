class Invoice::Manager::Create < Micro::Case
  attributes :user, :params

  validates :user, kind: User
  validates :params, kind: ActionController::Parameters

  def call!
    invoice_attributes = Invoice::Params.to_save(params)

    invoice = user.invoices.create(invoice_attributes.except(:emails))

    emails = invoice_attributes[:emails]

    if emails.present?
      emails.each { |email| invoice.emails.create(email: email) }
    end

    Success result: { invoice: invoice }

  rescue ActionController::ParameterMissing => e
    Failure :parameter_missing, result: { errors: e.message }
  end
end
