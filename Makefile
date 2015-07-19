PYTEST ?= py.test --host=api.aplazame.com
export PYTEST

init-test:
	pip install -r requirements/tests.txt

init: init-test
	pip install -r requirements/local.txt
	pip install -r requirements/build.txt

test:
	$(PYTEST) --verbose tests

coverage:
	$(PYTEST) --verbose --cov-report term --cov=aplazame_sdk tests
	coveralls

ci: init
	$(PYTEST) --junitxml=junit.xml tests

publish:
	python setup.py register
	python setup.py sdist upload
	python setup.py bdist_wheel upload

master:
	git checkout master
	git merge $(branch)
	git push origin master
	git checkout $(branch)

dev:
	git checkout $(branch)
	git push origin $(branch)
