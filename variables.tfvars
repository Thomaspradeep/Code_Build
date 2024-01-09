aws_region = "ap-south-1"
bucket_name = "matthews-bucket-091423"
clients_list = {
    object1 ={
        kms = {
            alias = "alleviate",
            key_usage = "ENCRYPT_DECRYPT"
            key_spec = "SYMMETRIC_DEFAULT"
            is_enabled = "true"
            rotation_enabled = "true"
            deletion_window_in_days="7"
        }
    }
}