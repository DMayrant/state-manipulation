# Moved blocks:
Allows you to move on state file to another. You can have as many as you want 

    moved {
      from = aws_instance.new_list[0]
      to = aws_instance.new_list["instance1"]
    }

# 2nd Moved block:

    moved {
      from = aws_instance.new_list[1]
      to = aws_instance.new_list["instance2"]
  }

# Imports:

importing outside resources to your terraform configuration
example below shows how an s3 bucket can be imported using the bucket name 
best practice is to add a prevent_destroy for critical resources 

    resource "aws_s3_bucket" "remote_state" {
      bucket = "cf-templates-bv9qs0bu6gg2-us-east-1"

    tags = {
      ManagedBy = "Terraform"
      Lifecycle = "Critical"
    }    

    lifecycle {
      prevent_destroy = true
    
      }    
    }

CLI command: 
terraform import aws_s3_bucket.remote_state 'cf-templates-bv9qs0bu6gg2-us-east-1'


# Remove Resource Tracking:

    resource "aws_s3_bucket" "my_bucket" {
      bucket = "random-name-9867336"
  
    }

CLI command: 
terraform state rm -dry-run aws_s3_bucket.my_bucket
or
terraform state rm aws_s3_bucket.my_bucket

# Remove Resource Tracking:
via Removed block

    removed {
      from = aws_s3_bucket.my_new_bucket

    lifecycle {
        destroy = false/true
      }
    }

    resource "aws_s3_bucket" "my_new_bucket" {
    bucket = "random-name-9867336"
  
    }

If you set destroy to false. The resource tracking will just be removed 
If you set destroy to true. The whole resource will be removed

The removed block as a form of documentation to tell you what resource existed and what was removed. 

# Tainting:
allows you to mark resources for recreation without redoing the configuration

    resource "aws_s3_bucket" "tainted" {
      bucket = "my-tainted-bucket-4581113"
    }
CLI command:
terraform taint aws_s3_bucket.tainted
or
terraform untaint aws_s3_bucket.tainted 
