class ApiData
  def get_merged_data
    # Loads in key order api1, api2, api3
    all_data = ::ApiLoader.new.load_all
    all_record_keys = all_data.values.flat_map do |records|
      records.map { |record| [record.id, record.destination] }
    end.uniq
    all_record_keys.map do |key|
      records = get_records_by_key(all_data, key)
      ::ApiMergeRecord.new(api1: records["api1"], api2: records["api2"], api3: records["api3"]).merge
    end
  end

  def get_data_filtered_by_hotel_ids(hotel_ids)
    # Loads in key order api1, api2, api3
    all_data = ::ApiLoader.new.load_all
    relevant_keys = all_data.values.flat_map do |records|
      records.map { |record| hotel_ids.include?(record.id) ? [record.id, record.destination] : nil }
    end.compact.uniq
    relevant_keys.map do |key|
      records = get_records_by_key(all_data, key)
      ::ApiMergeRecord.new(api1: records["api1"], api2: records["api2"], api3: records["api3"]).merge
    end
  end

  def get_data_filtered_by_destination_ids(destination_ids)
    # Loads in key order api1, api2, api3
    all_data = ::ApiLoader.new.load_all
    relevant_keys = all_data.values.flat_map do |records|
      records.map { |record| destination_ids.include?(record.destination) ? [record.id, record.destination] : nil }
    end.compact.uniq
    relevant_keys.map do |key|
      records = get_records_by_key(all_data, key)
      ::ApiMergeRecord.new(api1: records["api1"], api2: records["api2"], api3: records["api3"]).merge
    end
  end

  private

  def get_records_by_key(all_data, key)
    all_data.map do |api_name, records|
      record = records.find { |record| key == [record.id, record.destination] }
      [api_name, record]
    end.to_h
  end
end
