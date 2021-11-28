class InvoicesController < ApplicationController
  before_action :authenticate_user

  def index
    Invoice::Manager::List
      .call(user: current_user, params: params)
      .on_success { |result| render_json(200, invoices: result[:invoices]) }
  end

  def create
    Invoice::Manager::Create
      .call(user: current_user, params: params)
      .on_failure(:parameter_missing) { |error| render_json(422, invoice: error[:errors]) }
      .on_success { |result| render_json(201, invoice: result[:invoice]) }
  end

  def show
    Invoice::Manager::Show
      .call(user: current_user, params: params)
      .on_failure(:invoice_not_found) { render_json(404, invoice: 'Invoice not found') }
      .on_success { |result| render_json(200, invoice: result[:invoice]) }
  end

  def email
    Invoice::Manager::Email
      .call(user: current_user, params: params)
      .on_failure(:invalid_email) { |error| render_json(422, emails: error[:errors]) }
      .on_success { |result| render_json(201, emails: 'Emails was recorded successfully') }
  end
end
