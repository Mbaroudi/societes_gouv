require 'open-uri'
require 'zip'

class Entreprise < ApplicationRecord
  attr_accessor :csv_path

  def self.searchable_columns
    [:siren, :siret, :nom_raison_sociale]
  end

  def self.process_row(row)
    return if Entreprise.find_by(siren: row[:siren])
    Entreprise.create(
      siren: row[:siren],
      siret: row[:siren] + row[:nic],
      nic: row[:nic],
      l1_normalisee: row[:l1_normalisee],
      l2_normalisee: row[:l2_normalisee],
      l3_normalisee: row[:l3_normalisee],
      l4_normalisee: row[:l4_normalisee],
      l5_normalisee: row[:l5_normalisee],
      l6_normalisee: row[:l6_normalisee],
      l7_normalisee: row[:l7_normalisee],
      l1_declaree: row[:l1_declaree],
      l2_declaree: row[:l2_declaree],
      l3_declaree: row[:l3_declaree],
      l4_declaree: row[:l4_declaree],
      l5_declaree: row[:l5_declaree],
      l6_declaree: row[:l6_declaree],
      l7_declaree: row[:l7_declaree],
      numero_voie: row[:numvoie],
      indice_repetition: row[:indrep],
      type_voie: row[:typvoie],
      libelle_voie: row[:libvoie],
      code_postal: row[:codpos],
      cedex: row[:cedex],
      region: row[:rpet],
      libelle: row[:libreg],
      departement: row[:depet],
      arrondissement: row[:arronet],
      canton: row[:ctonet],
      commune: row[:comet],
      libelle_commune: row[:libcom],
      departement_unite_urbaine: row[:du],
      taille_unite_urbaine: row[:tu],
      numero_unite_urbaine: row[:uu],
      etablissement_public_cooperation_intercommunale: row[:epci],
      tranche_commune_detaillee: row[:tcd],
      zone_emploi: row[:zemet],
      is_siege: row[:siege],
      enseigne: row[:enseigne],
      indicateur_champ_publipostage: row[:ind_publipo],
      statut_diffusion: row[:diffcom],
      date_introduction_base_diffusion: row[:amintret],
      nature_entrepreneur_individuel: row[:natetab],
      libelle_nature_entrepreneur_individuel: row[:libnatetab],
      activite_principale: row[:apet700],
      libelle_activite_principale: row[:libapet],
      date_validite_activite_principale: row[:dapte],
      tranche_effectif_salarie: row[:tefet],
      libelle_tranche_effectif_salarie: row[:libtefet],
      tranche_effectif_salarie_centaine_pret: row[:efetcent],
      date_validite_effectif_salarie: row[:defet],
      origine_creation: row[:origine],
      date_creation: row[:dcret],
      date_debut_activite: row[:ddebact],
      nature_activite: row[:activnat],
      lieu_activite: row[:lieuact],
      type_magasin: row[:actisurf],
      is_saisonnier: row[:saisonat],
      modalite_activite_principale: row[:modet],
      caractere_productif: row[:prodet],
      participation_particuliere_production: row[:prodpart],
      caractere_auxiliaire: row[:auxilt],
      nom_raison_sociale: row[:nomen_long],
      sigle: row[:sigle],
      nom: row[:nom],
      prenom: row[:prenom],
      civilite: row[:civilite],
      numero_rna: row[:rna],
      nic_siege: row[:nicsiege],
      region_siege: row[:rpen],
      departement_commune_siege: row[:depcomen],
      email: row[:adr_mail],
      nature_juridique_entreprise: row[:nj],
      libelle_nature_juridique_entreprise: row[:libnj],
      activite_principale_entreprise: row[:apen700],
      libelle_activite_principale_entreprise: row[:libapen],
      date_validite_activite_principale_entreprise: row[:dapen],
      activite_principale_registre_metier: row[:aprm],
      is_ess: row[:ess],
      date_ess: row[:dateess],
      tranche_effectif_salarie_entreprise: row[:tefen],
      libelle_tranche_effectif_salarie_entreprise: row[:libtefen],
      tranche_effectif_salarie_entreprise_centaine_pret: row[:efencent],
      date_validite_effectif_salarie_entreprise: row[:defen],
      categorie_entreprise: row[:categorie],
      date_creation_entreprise: row[:dcren],
      date_introduction_base_diffusion_entreprise: row[:amintren],
      indice_monoactivite_entreprise: row[:monoact],
      modalite_activite_principale_entreprise: row[:moden],
      caractere_productif_entreprise: row[:proden],
      date_validite_rubrique_niveau_entreprise_esa: row[:esaann],
      tranche_chiffre_affaire_entreprise_esa: row[:tca],
      activite_principale_entreprise_esa: row[:esaapen],
      premiere_activite_secondaire_entreprise_esa: row[:esasec1n],
      deuxieme_activite_secondaire_entreprise_esa: row[:esasec2n],
      troisieme_activite_secondaire_entreprise_esa: row[:esasec3n],
      quatrieme_activite_secondaire_entreprise_esa: row[:esasec4n],
      nature_mise_a_jour: row[:vmaj],
      indicateur_mise_a_jour_1: row[:vmaj1],
      indicateur_mise_a_jour_2: row[:vmaj2],
      indicateur_mise_a_jour_3: row[:vmaj3],
      date_mise_a_jour: row[:datemaj],
      type_evenement: row[:eve],
      date_evenement: row[:dateve],
      type_creation: row[:typcreh],
      date_reactivation_etablissement: row[:dreactet],
      date_reactivation_entreprise: row[:dreacten],
      indicateur_mise_a_jour_enseigne_entreprise: row[:madresse],
      indicateur_mise_a_jour_activite_principale_etablissement: row[:menseigne],
      indicateur_mise_a_jour_adresse_etablissement: row[:mapet],
      indicateur_mise_a_jour_caractere_productif_etablissement: row[:mprodet],
      indicateur_mise_a_jour_caractere_auxiliaire_etablissement: row[:mauxilt],
      indicateur_mise_a_jour_nom_raison_sociale: row[:mnomen],
      indicateur_mise_a_jour_sigle: row[:msigle],
      indicateur_mise_a_jour_nature_juridique: row[:mnj],
      indicateur_mise_a_jour_activite_principale_entreprise: row[:mapen],
      indicateur_mise_a_jour_caractere_productif_entreprise: row[:mproden],
      indicateur_mise_a_jour_nic_siege: row[:mnicsiege],
      siret_predecesseur_successeur: row[:siretps],
      telephone: row[:tel]
    )
  end

  def self.import_csv
    options = {
      chunk_size: 200,
      col_sep: ';',
      row_sep: "\r\n",
      convert_values_to_numeric: false,
      key_mapping: {},
      file_encoding: 'windows-1252'
    }

    @csv_path = 'public/sirc-17804_9075_14211_2017020_E_Q_20170121_015800268.csv'
    SmarterCSV.process(@csv_path, options) do |chunk|
      chunk.each do |row|
        Entreprise.transaction do
          Entreprise.process_row(row)
        end
      end
    end
  end

  def self.read_distant_base
    url = 'http://www.data.gouv.fr/fr/datasets/base-sirene-des-entreprises-et-de-leurs-etablissements-siren-siret/'
    body = Net::HTTP.get(URI.parse(url))
    links = body.scan(/<a itemprop="url" href=([^>]*)>/)
    last_link = links.first[0].delete('"')
    filename = last_link.gsub('http://files.data.gouv.fr/sirene/', '')
    download = open(last_link)
    IO.copy_stream(download, "public/#{filename}")
    Entreprise.extract_zip("public/#{filename}", 'public/')
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
