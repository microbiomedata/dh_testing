.PHONY: all clean make_interface

all: clean DataHarmonizer/web/templates/dh_testing/schema.json target/project/dh_testing.py src/schema/dh_testing_generated.yaml

clean:
	mkdir -p target
	mkdir -p logs
	rm -rf DataHarmonizer/web/templates/dh_testing/*
	rm -rf src/schema/dh_testing_from_sheets.yaml
	rm -rf src/schema/dh_testing_generated.yaml
	rm -rf src/schema/dh_testing_subsets_from_sheets.yaml


deep_clean: clean
	rm -rf target/*

target/slotdef.yaml:
	poetry run python dh_testing/slotdef_to_yaml.py > $@

#make_interface:
#	mkdir -p DataHarmonizer/web/templates/dh_testing/
#	cp src/schema/dh_testing.yaml DataHarmonizer/web/templates/dh_testing/
#	cd DataHarmonizer/web/templates/dh_testing/ ; poetry run python ../../../script/linkml.py --input dh_testing.yaml

src/schema/dh_testing_from_sheets.yaml:
	#   todo test_any_of_enums in sheets?
	#   todo test_structured_pattern in sheets?
	#   todo subsets in sheets?
	poetry run sheets2linkml \
 		--output $@ \
 		--gsheet-id 1YppckQLKpHFA6ZX0nr1qNhp52ISA98P_flPpqWCT6UQ schema classes enums prefixes slots


src/schema/dh_testing_subsets_from_sheets.yaml:
	#   todo test_any_of_enums in sheets?
	#   todo test_structured_pattern in sheets?
	#   todo subsets in sheets?
	poetry run sheets2linkml \
		--name dh_testing_subsets \
 		--output $@ \
 		--gsheet-id 1YppckQLKpHFA6ZX0nr1qNhp52ISA98P_flPpqWCT6UQ subsets

src/schema/examples_from_sheet.yaml:
	#   todo test_any_of_enums in sheets?
	#   todo test_structured_pattern in sheets?
	#   todo subsets in sheets?
	poetry run sheets2linkml \
 		--output $@ \
 		--gsheet-id 1wVoaiFg47aT9YWNeRfTZ8tYHN8s8PAuDx5i2HUcDpvQ schema subsets

src/schema/examples_generated.yaml: src/schema/examples_core.yaml src/schema/examples_from_sheet.yaml
	poetry run gen-linkml \
		--no-materialize-attributes \
		--format yaml \
		--output $@ $<

src/schema/dh_testing_generated.yaml: src/schema/dh_testing_core.yaml src/schema/dh_testing_from_sheets.yaml
	poetry run gen-linkml \
		--no-materialize-attributes \
		--format yaml \
		--output $@ $<

target/project/dh_testing.py: src/schema/dh_testing_core.yaml src/schema/dh_testing_from_sheets.yaml
	mkdir -p target/project
	poetry run gen-project \
		--dir target/project $<


DataHarmonizer/web/templates/dh_testing/schema.json: src/schema/dh_testing_core.yaml src/schema/dh_testing_from_sheets.yaml
	echo "export default {};" > DataHarmonizer/web/templates/dh_testing/export.js
	poetry run gen-linkml --format json --mergeimports $< > $@


temp: src/schema/dh_testing_generated.yaml
	mkdir -p target/sheet_output
	poetry run linkml2sheets \
		--schema $< \
		--output-directory target/sheet_output src/templates/subsets.tsv