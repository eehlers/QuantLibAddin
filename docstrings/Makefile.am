
EXTRA_DIST = \
    docstrings.py \
    docstrings.vcproj \
    Doxyfile.ql \
    Doxyfile.qla \
    Makefile.vc

QLA_INPUTS := $(wildcard ../swig/functions/*.i)

all: docstrings.txt

docstrings-ql.txt:
	$(DOXYGEN) Doxyfile.ql
	python docstrings.py xml-ql docstrings-ql.txt

docstrings-qla.txt: $(QLA_INPUTS)
	$(DOXYGEN) Doxyfile.qla
	python docstrings.py xml-qla docstrings-qla.txt

docstrings.txt: docstrings-ql.txt docstrings-qla.txt
	cp docstrings-ql.txt docstrings.txt
	cat docstrings-qla.txt >> docstrings.txt

clean:
	rm -rf xml-ql xml-qla docstrings-ql.txt docstrings-qla.txt docstrings.txt

