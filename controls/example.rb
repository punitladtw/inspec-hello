control "aws rds clusters" do
  input('rds_clusters').each do |rds_cluster|
    describe aws_rds_cluster(db_cluster_identifier: rds_cluster) do
      its('availability_zones') { should eq ["us-east-1b", "us-east-1a", "us-east-1e"] }
    end
  end
end
