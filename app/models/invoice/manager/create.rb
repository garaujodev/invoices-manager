class Invoice::Manager::Create < Micro::Case
  attributes :user, :params

  validates :user, kind: User
  validates :params, kind: ActionController::Parameters

  def call!
    invoice_attributes = Invoice::Params.to_save(params)

    invoice = user.invoices.create(invoice_attributes.except(:emails))

    invoice_attributes[:emails].each { |email| invoice.emails.create(email: email) }

    return Success result: { invoice: invoice } if invoice.persisted?

    Failure :parameter_missing, result: { errors: invoice.errors.as_json }
  end
end
