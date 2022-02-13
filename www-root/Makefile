# set the default goal.
.DEFAULT_GOAL := list_docs
#.phony: list_docs gitupdate clean



list_docs:
	ls -l


gitupdate: clean
	git add .; git commit -m "update www-root dir"; git push

clean:
	echo "docs: make clean"
	#-find . -name "*.backup" -print | xargs rm
	-rm *.backup *.BACKUP *.swp *.key


# list discributions
list:
	aws cloudfront list-distributions


# aws s3 command for rsync. hopefully exclude can be added twice
deploy: clean
	aws s3 sync . s3://rtp-aws.org --exclude "*.swp" --exclude "*.key" --exclude "*.backup" --exclude "*.BACKUP" --exclude "Makefile"
	aws cloudfront create-invalidation --distribution-id E1USF87Z031C1M --paths "/*"
