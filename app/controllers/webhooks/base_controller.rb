class Webhooks::BaseController < ApplicationController
  #disable CSRF check
  # skip_before_action :verify_authenticity_token
  skip_forgery_protection
  before_action :verify_event

  def create
    InboundWebhook.create!(body: payload)
    head :ok
  end


  private

  def payload
    @payload ||= request.body.read
  end

  def verify_event
    head :bad_request
  end

end
