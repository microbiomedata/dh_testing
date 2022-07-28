.PHONY: all clean make_interface

all: clean DataHarmonizer/web/templates/dh_testing/schema.json

clean:
	mkdir -p target
	rm -rf DataHarmonizer/web/templates/dh_testing/*


deep_clean:
	rm -rf target/*

target/slotdef.yaml:
	poetry run python dh_testing/slotdef_to_yaml.py > $@

#make_interface:
#	mkdir -p DataHarmonizer/web/templates/dh_testing/
#	cp src/schema/dh_testing.yaml DataHarmonizer/web/templates/dh_testing/
#	cd DataHarmonizer/web/templates/dh_testing/ ; poetry run python ../../../script/linkml.py --input dh_testing.yaml

DataHarmonizer/web/templates/dh_testing/schema.json:
	echo "export default {};" > DataHarmonizer/web/templates/dh_testing/export.js
	poetry run gen-linkml --format json --mergeimports src/schema/dh_testing.yaml > DataHarmonizer/web/templates/dh_testing/schema.json