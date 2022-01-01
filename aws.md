# AWS cli notes

# aws configure
Use `aws configure` to credentials to associate yourself with the aws services
cli.

# s3 listing
`aws s3 ls`

# list s3 files in a bucket
`aws s3 ls s3://rtp-aws.org/`

# rsync s3 bucket to local dir
`aws s3 sync s3://rtp-aws.org .`

# rsync local dir to s3 bucket
`aws s3 sync . s3://rtp-aws.org`
