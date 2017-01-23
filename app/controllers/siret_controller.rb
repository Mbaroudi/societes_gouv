class SiretController < ApplicationController
  def show
    # NICE SEGURIDAD
    r = Redis::HashKey.new(params[:id])
    if r.all.empty?
      render json: { message: 'no results found' }, status: 404
    else
      render json: { etablissement: r.all }, status: 200
    end
  end

  def siret_params
    params.permit(:id)
  end
end
