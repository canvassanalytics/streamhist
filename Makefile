# Usage:
#	make <command-name>

SRCDIR=streamhist

# Standard paths
HOOKSDIR=git-hooks
TESTDIR=tests
PYTHON3=/usr/local/bin/python3

# Load environment variables from .env (if it exists) and export for make targets
-include .env
export

# Local environment setup targets
hooks:
	cp ${HOOKSDIR}/* .git/hooks/

venv:
	virtualenv -p ${PYTHON3} venv
	@echo "******************************************************************************"
	@echo "Run 'source venv/bin/activate' to activate this virtualenv in your local shell"
	@echo "******************************************************************************"

install: venv
	. venv/bin/activate && \
	pip3 install -r requirements.txt
	@echo "******************************************************************************"
	@echo "Run 'source venv/bin/activate' to activate this virtualenv in your local shell"
	@echo "******************************************************************************"


# Development / testing targets
lint:
	yapf . -r -i
	pylint ${SRCDIR}

test:
	python -m pytest --cov=${SRCDIR} ${TESTDIR}
