# http://www.gnu.org/software/make/manual/make.html#Special-Variables

# set the default goal.
# I want the default to really just dump contents of dirs
# as a stub.  For instance, I don't want it to
# push code or
.DEFAULT_GOAL := deploy
#.phony: all deploy gitupdate clean $(DIRS)

TOPTARGETS := all clean

SUBDIRS := docs imgs my-assets not-mine official-assets www-root secrets


$(TOPTARGETS): $(SUBDIRS)
$(SUBDIRS):
	echo "make arg is" $(MAKECMDGOALS)
	$(MAKE) -C $@ $(MAKECMDGOALS)




SUBCLEAN = $(addsuffix .clean,$(SUBDIRS))

clean: $(SUBCLEAN)

$(SUBCLEAN): %.clean:
#	echo "top: make clean"
#	echo "top: subdirs is $(SUBDIRS)"
#	echo "clean in top dir"
#	echo "first prereq "$<
#	echo "top: all prereqs "$?
#	echo "top: all prereqs " $(SUBDIRS)
#	make -C $? clean
	-rm *.backup *.swp *.BACKUP
	$(MAKE) -C $* clean


# list discributions
list:
	aws cloudfront list-distributions


# aws s3 command for rsync. hopefully exclude can be added twice
deploy: clean
	aws s3 sync www-root/. s3://rtp-aws.org --exclude "*.swp" --exclude "*.key" --exclude "*.backup" --exclude "*.BACKUP" --exclude "Makefile"
	aws cloudfront create-invalidation --distribution-id E1USF87Z031C1M --paths "/*"

gitupdate: clean
	git add --all; git commit -m "wip"; git push
