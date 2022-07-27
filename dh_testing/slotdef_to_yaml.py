from linkml_runtime import SchemaView
from linkml_runtime.dumpers import yaml_dumper

meta_elements_by_alias = {"slot": "slot_definition"}

meta_url = "https://raw.githubusercontent.com/linkml/linkml-model/main/linkml_model/model/schema/meta.yaml"

meta_view = SchemaView(meta_url)

slot_def = meta_view.induced_class(meta_elements_by_alias['slot'])

print(yaml_dumper.dumps(slot_def))