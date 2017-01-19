require 'open-uri'
require 'zip'

class Entreprise
  attr_accessor :csv_path
  include Redis::Objects
  hash_key :infos

  def initialize(id = 1, infos = {})
    @id = id
    @infos = infos
  end

  def self.process_rows(rows)
    rows.each do |row|
    end
  end

  def self.import_csv
    options = {
      chunk_size: 100,
      col_sep: ";",
      row_sep: "\r\n",
      key_mapping: {},
      file_encoding: "windows-1252"
    }
    binding.pry
    SmarterCSV.process(@csv_path, options) do |chunk|
      chunk.each do |rows|
        Entreprise.process_rows(rows)
      end
    end
  end

  def self.read_distant_base
    url = "http://www.data.gouv.fr/fr/datasets/base-sirene-des-entreprises-et-de-leurs-etablissements-siren-siret/"
    body = Net::HTTP.get(URI.parse(url))
    links = body.scan(/<a itemprop="url" href=([^>]*)>/)
    last_link = links.first[0].gsub("\"", "")
    filename = last_link.gsub("http://files.data.gouv.fr/sirene/", "")
    download = open(last_link)
    IO.copy_stream(download, "public/#{filename}")
    Entreprise.extract_zip("public/#{filename}", "public/")
    Entreprise.import_csv
  end

  def self.extract_zip(file, destination)
    Zip::File.open(file) do |zip_file|
      zip_file.each do |f|
        @csv_path = File.join(destination, f.name)
        zip_file.extract(f, @csv_path) unless File.exist?(@csv_path)
      end
    end
  end
end
