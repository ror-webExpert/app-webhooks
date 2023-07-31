class Webhooks::StripeController < Webhooks::BaseController

  def create
    record = InboundWebhook.create!(body: payload)
    Webhooks::StripeJob.perform_later(record)
    head :ok
  end

  def verify_event
    signature = request.headers['Stripe-Signature']
    secret =  ENV["STRIPE_SIGNING_SECRET"] || Rails.application.credentials.dig(:stripe, :webhook_signing_secret)
    ::Stripe::Webhook::Signature.verify_header(
      payload,
      signature,
      secret.to_s,
      tolerance: Stripe::Webhook::DEFAULT_TOLERANCE
    )
  rescue ::Stripe::SignatureVerificationError
    head :bad_request
  end
end
