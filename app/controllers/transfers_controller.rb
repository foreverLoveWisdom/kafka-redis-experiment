class TransfersController < ApplicationController
def create
  transfer = Transfer.create!(transfer_params)
  TransferMoneyJob.perform_later(transfer.id)
  render json: { status: "queued" }
end

private

def transfer_params
  params.permit(:from, :to, :amount)
end
end
