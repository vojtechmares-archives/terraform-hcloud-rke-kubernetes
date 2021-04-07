setup-git-hooks:
	rm -rf .git/hooks
	(cd .git && ln -s ../.git-hooks hooks)

tf-fmt:
	terraform fmt -recursive

tf-fmt-check:
	terraform fmt -recursive -check
