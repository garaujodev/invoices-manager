class Invoice::Params
  def self.to_save(params)
    params.require(:invoice).permit(:number, :due_at, :bill_from, :bill_to, :total, :emails => [])
  end
end
