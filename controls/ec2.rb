control "Each instance should be associated to an autoscaling group (asg managed multi az)" do
  tag aws_service: 'ec2-instance'

  # aws_ec2_instances.instance_ids.each do |instance_id|
    # instance = aws_ec2_instance(instance_id)
    instance = aws_ec2_instance("i-00c922131dee4b853")
    describe instance do
      autoscaling_group_tag = instance.tags.select do |x| 
        puts(x)
        puts(x["aws:autoscaling:groupName"])
        x['key'] == "aws:autoscaling:groupName"
      end
      it "contains an autoscaling group tag from aws" do
        autoscaling_group_tag.should_not be_empty
      end
    end 
  # end
end
