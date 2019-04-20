# build inplace for unit tests to pass (since they are run from this
# top level directory we need the .so files to be in the src tree
# when they run.
build: clean
	python setup.py build_ext --inplace
	python setup.py build

clean:
	# lcs.cpp and blocks.cpp are generated by cython
	rm -rf build dist dragnet/*.pyc dragnet/*.so dragnet/lcs.cpp dragnet/blocks.cpp dragnet.egg-info dragnet/features/*.pyc dragnet/features/_kohlschuetter.cpp dragnet/features/_readability.cpp dragnet/features/_weninger.cpp

test: pytest

pytest:
	pytest --cov=dragnet --cov-report=term --cov-branch -v test

# using python setup.py deploys as .egg, causing the model file not found
# using pip install deploys as a directory, so the model file can be found
# install: build
#	python setup.py install

install-pip: build
	pip install .

install: install-pip
