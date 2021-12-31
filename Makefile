.phony: deploy gitupdate

# these are for gcp.  convert to equivalent aws method
deploy:
	echo need aws gsutil -m rsync -j html,css -r -x ".*\.swp|.*\.bak"  www-root gs://www.rtp-gcp.org


gitupdate:
	git add --all; git commit -m "wip"; git push

