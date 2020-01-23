
.SECONDARY: 

all_files = NIEM_tools.docx NIEM_tools.pptx
junk_files = NIEM_tools.md

.PHONY: all
all: ${all_files}

%.pptx: %.md
	pandoc \
	  --to=pptx --output=$@ \
	  --from=markdown+yaml_metadata_block $<

%.docx: %.md
	pandoc \
	  --to=docx --output=$@ \
	  --from=markdown+yaml_metadata_block $<

%.md: %.mm mm-to-md.xsl
	saxon --in=$< --out=$@ --xsl=mm-to-md.xsl

.PHONY: clean
clean:
	${RM} ${all_files} ${junk_files}

