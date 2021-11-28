class Invoice::Manager::Show < Micro::Case
  attributes :user, :params

  validates :user, kind: User
  validates :params, kind: ActionController::Parameters

  def call!
    invoice = Invoice.find_by(id: params[:id])

    return Success result: { invoice: invoice } unless invoice.blank?

    Failure :invoice_not_found
  end
end
