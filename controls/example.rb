control "aws s3 buckets" do
  describe aws_s3_buckets do
    it { should exist }
  end
end
