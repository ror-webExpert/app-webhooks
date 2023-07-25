class Webhooks::StripeController < Webhooks::BaseController

  def create
    record = InboundWebhook.create!(body: payload)
    Webhooks::StripeJob.perform_later(record)
    head :ok
  end

  def verify_event
    signature = request.headers['Stripe-Signature']
    secret =  ENV[""] || Rails.application.credentials.dig(:stripe, :webhook_signing_secret)
    head :bad_request if params[:fail_verification]
  end
end
