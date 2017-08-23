.PHONY: all production test docs clean

all: production

production:
	@true

docs:
	tox -e docs

dev: $(LOCAL_CONFIG_DIR) $(LOGS_DIR) install-hooks

install-hooks:
	pre-commit install -f --install-hooks

test:
	tox

test-docker:
	docker-compose --project-name elastalert build tox
	docker-compose --project-name elastalert run tox

clean:
	make -C docs clean
	find . -name '*.pyc' -delete
	find . -name '__pycache__' -delete
	rm -rf virtualenv_run .tox .coverage *.egg-info build


deb: VERSION := ${shell sed -nE 's/^elastalert \((.*)\).*$$/\1/p' debian/changelog}
deb:
	@echo "===> building deb elasticalert_$(VERSION)_amd64.deb"
	@docker rm elastalert-deb 2> /dev/null || true
	docker build -t elastalert-deb -f debian/Dockerfile .
	docker create --name elastalert-deb elastalert-deb
	docker cp elastalert-deb:/home/elastalert_$(VERSION)_amd64.deb .
	docker rm elastalert-deb
