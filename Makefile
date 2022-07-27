.PHONY: all clean

all: clean target/slotdef.yaml

clean:
	mkdir -p target

deep_clean:
	rm -rf target/*

target/slotdef.yaml:
	poetry run python dh_testing/slotdef_to_yaml.py > $@

make_interface:
	mkdir -p DataHarmonizer/web/templates/dh_testing/
	cp src/schema/dh_testing.yaml DataHarmonizer/web/templates/dh_testing/
	cd DataHarmonizer/web/templates/dh_testing/ ; poetry run python ../../../script/linkml.py --input dh_testing.yaml