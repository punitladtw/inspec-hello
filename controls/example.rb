control "RDS clusters must be configured for multi AZ" do
  input('rds_clusters').each do |rds_cluster|
    client = Aws::RDS::Client.new
    cluster = client.describe_db_clusters({db_cluster_identifier: rds_cluster}).db_clusters[0]
    describe cluster["db_cluster_identifier"] do
      it "configured for multi AZ" do
        cluster['multi_az'].should be true
        cluster['db_cluster_members'].count.should be >= 2
      end

      writer = cluster['db_cluster_members'].find { |x| x['is_cluster_writer'] }
      readers = cluster['db_cluster_members'].select { |x| !x['is_cluster_writer'] }
      readers.each do |reader| 
        it "readers are configured outside of writer availability zone" do
          writer_instance = aws_rds_instance(writer["db_instance_identifier"])
          reader_instance = aws_rds_instance(reader["db_instance_identifier"])
          expect(reader_instance.availability_zone).to_not eq(writer_instance.availability_zone)
        end 
      end
    end
  end
end