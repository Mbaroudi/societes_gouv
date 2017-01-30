class FullTextController < ApplicationController
  def show
    # NICE SEGURIDAD
    r = Etablissement.fuzzy_search(params[:id])
    if r.nil?
      render json: { message: 'no results found' }, status: 404
    else
      render json: { etablissement: r.all }, status: 200
    end
  end

  def full_text_params
    params.permit(:id)
  end
end
