control "Lambdas must be configured for multi AZ" do
    aws_lambdas.names.each do |lambda_function_name|
        lambda_function = aws_lambda(lambda_function_name)
        unless lambda_function.vpc_config.nil?  
            describe lambda_function do          
                its ('vpc_config.subnet_ids.count') { should be >= 2}
            end
        end
    end
end
