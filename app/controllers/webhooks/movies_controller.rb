class Webhooks::MoviesController < Webhooks::BaseController
  # curl -X Post http://localhost:3000/webhooks/movies -H 'Content-Type: application/json' -d '{"title": "The Matrix"}'

  def create
    record = InboundWebhook.create!(body: payload)
    Webhooks::MoviesJob.perform_later(record)
    head :ok
  end

  private

  def verify_event
    head :bad_request if params[:fail_verification]
  end
end
