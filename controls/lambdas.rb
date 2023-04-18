control "Lambdas must be configured for multi AZ" do
    aws_lambdas.names.each do |lambda_function_name|
        lambda_function = aws_lambda(lambda_function_name)
        unless lambda_function.vpc_config.nil?  
            describe lambda_function do          
                its ('vpc_config.subnet_ids.count') { should be >= 2}
                
                it "atleast one subnet should be in a different availability zone" do
                    subnet_ids = lambda_function.vpc_config.subnet_ids
                    first_subnet = aws_subnet(subnet_ids.first)
                    all_other_subnets = subnet_ids.last(subnet_ids.length - 1)
                    subnets_in_other_azs = all_other_subnets.select do |x| 
                        aws_subnet(x).availability_zone != first_subnet.availability_zone 
                    end
                    
                    subnets_in_other_azs.count.should be > 0
                end
            end
        end
    end
end
