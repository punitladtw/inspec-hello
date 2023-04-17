control "multi-az configuration" do
  input('rds_clusters').each do |rds_cluster|

    describe aws_rds_cluster(db_cluster_identifier: rds_cluster) do
      its('multi_az') { should be true }
      its('db_cluster_members.count') { should be >= 2 }
    end
  end
end