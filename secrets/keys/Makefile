

# set the default goal.
.DEFAULT_GOAL := list_docs
#.phony: list_docs gitupdate clean



list_docs:
	ls -l



gitupdate: clean
	git add .; git commit -m "update secrets/keys dir"; git push

clean:
	echo "docs: make clean"
	#-find . -name "*.backup" -print | xargs rm
	#-rm *.md
	-rm *.backup *.BACKUP *.swp *.key *.md



encrypt:
	gpg --output administrator.md.gpg --encrypt --recipient davisjf@gmail.com administrator.md
	gpg --output jfd.md.gpg --encrypt --recipient davisjf@gmail.com jfd.md



decrypt:
	gpg --decrypt administrator.md.gpg
	gpg --decrypt jfd.md.gpg

decrypt_tofile:
	gpg --output administrator.md --decrypt administrator.md.gpg
	gpg --output jfd.md --decrypt jfd.md.gpg
