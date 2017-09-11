module Export
  extend ActiveSupport::Concern

  module ClassMethods
    def csv_export(header_string)
      require 'csv'
      attributes =header_string.split(" ")

      CSV.generate(headers: true) do |csv|
        csv << attributes #headers

        all.each do |line|
          csv << attributes.map{ |attr| line.send(attr) }
        end
      end
    end
  end
end
