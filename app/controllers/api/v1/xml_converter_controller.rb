class Api::V1::XmlConverterController < ApplicationController
  skip_before_action :verify_authenticity_token

  def new
    # This action will render the form
  end

  def create
    nfe_keys = params[:nfe_keys].split("\n").map(&:strip).reject(&:empty?)
    customer = params[:customer]
    interactor = XmlConverterInteractor.new(nfe_keys, customer)
    @tar_gz_file_path = interactor.execute

    @file_paths = interactor.full_file_paths.map { |path| path ? path.sub(Rails.root.join('public').to_s, '') : nil }.compact

    respond_to do |format|
      format.html # Renders the HTML view
      format.json { render json: { message: "Seus XML Estão prontos! Acesse-os em #{@tar_gz_file_path}" } }
    end
  end
end