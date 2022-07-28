.PHONY: all clean make_interface

all: clean DataHarmonizer/web/templates/dh_testing/schema.json

clean:
	mkdir -p target
	rm -rf DataHarmonizer/web/templates/dh_testing/*
	rm -rf src/schema/dh_testing_from_sheets.yaml
	rm -rf src/schema/dh_testing_generated.yaml


deep_clean:
	rm -rf target/*

target/slotdef.yaml:
	poetry run python dh_testing/slotdef_to_yaml.py > $@

#make_interface:
#	mkdir -p DataHarmonizer/web/templates/dh_testing/
#	cp src/schema/dh_testing.yaml DataHarmonizer/web/templates/dh_testing/
#	cd DataHarmonizer/web/templates/dh_testing/ ; poetry run python ../../../script/linkml.py --input dh_testing.yaml

src/schema/dh_testing_from_sheets.yaml:
	#   todo test_any_of_enums
	#   todo test_structured_pattern
	poetry run sheets2linkml \
 		--output $@ \
 		--gsheet-id 1YppckQLKpHFA6ZX0nr1qNhp52ISA98P_flPpqWCT6UQ schema classes enums prefixes  subsets slots

src/schema/dh_testing_generated.yaml: src/schema/dh_testing_core.yaml src/schema/dh_testing_from_sheets.yaml
	poetry run gen-linkml \
		--format yaml \
		--output $@ $<

DataHarmonizer/web/templates/dh_testing/schema.json: src/schema/dh_testing_generated.yaml
	echo "export default {};" > DataHarmonizer/web/templates/dh_testing/export.js
	poetry run gen-linkml --format json --mergeimports $< > $@