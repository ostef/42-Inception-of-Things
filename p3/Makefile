all: install setup

install:
	./scripts/install.sh

uninstall:
	./scripts/uninstall.sh

setup:
	./scripts/setup.sh

clean:
	./scripts/clean.sh

re: clean setup

password:
	./scripts/get_password.sh

argocd:
	sudo kubectl port-forward -n argocd svc/argocd-server 8080:80
