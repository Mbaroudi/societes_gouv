require 'open-uri'
require 'zip'

class Entreprise < ApplicationRecord

  def self.read_distant_base
    url = "http://www.data.gouv.fr/fr/datasets/base-sirene-des-entreprises-et-de-leurs-etablissements-siren-siret/"
    body = Net::HTTP.get(URI.parse(url))
    links = body.scan(/<a itemprop="url" href=([^>]*)>/)
    last_link = links.first[0].gsub("\"", "")
    filename = last_link.gsub("http://files.data.gouv.fr/sirene/", "")
    download = open(last_link)
    IO.copy_stream(download, "public/#{filename}")
    Entreprise.extract_zip("public/#{filename}", "public/")
  end

  def self.extract_zip(file, destination)
    Zip::File.open(file) do |zip_file|
      zip_file.each do |f|
        fpath = File.join(destination, f.name)
        zip_file.extract(f, fpath) unless File.exist?(fpath)
      end
    end
  end
end
