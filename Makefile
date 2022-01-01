.phony: deploy gitupdate

# these are for gcp.  convert to equivalent aws method
deploy:
	aws s3 sync www-root/. s3://rtp-aws.org


gitupdate:
	git add --all; git commit -m "wip"; git push

