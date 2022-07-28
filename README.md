# dh_testing
Sandbox for testing the content of various [LinkML](https://linkml.io/) schema features against [DataHarmonizer](https://github.com/cidgoh/DataHarmonizer)

Motivated by
- https://github.com/microbiomedata/sheets_and_friends/issues/105
  - https://github.com/microbiomedata/sheets_and_friends/issues/104
    - MAM: check pipeline for converting NMDC/MIxS class (not type) ranges into patterns (via structured patterns) and then using the patterns to validate DataHarmonizer input
    - see also https://github.com/microbiomedata/sheets_and_friends/pull/115
- https://github.com/microbiomedata/sheets_and_friends/issues/107
  - Several efforts underway to improve pipeline for retrieving EnvO and Uberon terms from public sources, providing a way for subject-matter experts to curate the retrieved lists, and then injecting per-environment enumerations for each of the MIxS environmental triad slots. **MAM: elaborate**.

Looking good:
- https://github.com/microbiomedata/sheets_and_friends/issues/106 (DH help screens)

MAM: get a better understanding of how DH interfaces are built and deployed to the NMDC submission portal now. May not involve GitHub pages anymore (so checking and sharing dev builds can probably be done with GH pages, instead of Netlify). This repo uses `gen-linkml --format json` to generate the JSON for the DH interface, not `script/linkml.py`. Then the DH web content can be served locally or packaged up with `yarn dev` and webpack. I believe the dependence on using DH as a git submodule will be removed eventually. The consequences of that need to be documented, too. 

Therefore, most of these are at least mostly irrelevant now:
- https://github.com/microbiomedata/sheets_and_friends/issues/108
- https://github.com/microbiomedata/sheets_and_friends/issues/111
- https://github.com/microbiomedata/sheets_and_friends/issues/114

Note that there are differences between DH's XXX and LinkML's sheets2linkml. Might be an opportunity for improving sheets2linkml.

