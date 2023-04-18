control "RDS instances (not part of clusters) must be configured for multi AZ" do
  client = Aws::RDS::Client.new
  db_instance_message = client.describe_db_instances()
  db_instances = db_instance_message['db_instances']
  db_instances.each do |db_instance|
    next if !db_instance.db_cluster_identifier.nil?
    describe db_instance.db_instance_identifier do
      it "configured for multi AZ" do
        db_instance.multi_az.should be true
      end
      it "primary and secondary zones are different" do 
        db_instance.availability_zone.should_not be_nil
        db_instance.secondary_availability_zone.should_not be_nil
        db_instance.secondary_availability_zone.should_not eq db_instance.availability_zone
      end
    end
  end
end