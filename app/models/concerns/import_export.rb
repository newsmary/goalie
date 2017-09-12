module ImportExport
  extend ActiveSupport::Concern

  module ClassMethods
    def to_csv
      require 'csv'
      attributes = self::HEADERS

      CSV.generate(headers: true) do |csv|
        csv << attributes #headers

        all.each do |line|
          csv << attributes.map{ |attr| line.send(attr) }
        end
      end
    end

    def import(file)
      #should've already checked the file in the controller, but double-check headers are valid

      missing_cols = self::HEADERS - CSV.read(file.path,headers: true).headers
      return "Missing columns: #{missing_cols.join(", ")}" unless missing_cols.empty?

      CSV.foreach(file.path, headers: true) do |row|
        #update an exisitng one?
        if(t = self.find_by(id: row['id'])) #use find_by so we don't get an error if it's not found
          parent = self.find(row['parent_id']) unless row['parent_id'].to_s.empty?
          value_hash = {}
          self::HEADERS.map{ |h| value_hash[h] = row[h] }
          t.update!(value_hash)
          t.update!(parent: parent) if parent.present?
        else
          #or create a new one.
          #assumes parents are always created before children... is this true?
          value_hash = {}
          self::HEADERS.map{|h| value_hash[h] = row[h]}
          parent = self.find_by(imported_id: row['parent_id'].to_s) unless row['parent_id'].to_s.empty?
          user = Person.find_by(imported_id: row['user_id']) if row['user_id'].present?
          t = self.create!(value_hash)
          t.update!(parent: parent) if parent.present?
        end
      end

    end

  end
end
