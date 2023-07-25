class Webhooks::StripeJob < ApplicationJob
  queue_as :default

  def perform(inbound_webhook)
    json = JSON.parse(inbound_webhook.body, symbolize_names: true)
    event = Stripe::Event.construct_form(json)
    case event.type
    when "customer.update"
    inbound_webhook.update!(status: :processed)
    else
      inbound_webhook.update!(status: :skipped)
    end
    # Do something later
  end
end
