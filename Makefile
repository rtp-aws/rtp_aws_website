.phony: deploy gitupdate

# aws s3 command for rsync. hopefully exclude can be added twice
deploy:
	aws s3 sync www-root/. s3://rtp-aws.org --exclude "*.swp" --exclude "*.key"


gitupdate:
	git add --all; git commit -m "wip"; git push

