
.SECONDARY: 

all_files = \
  generated/NIEM_tools.md \
  generated/NIEM_Tools_Requirements.docx \
  generated/NIEM_Tools_Roadmap.pptx \

.PHONY: all
all: ${all_files}

generated/%.pptx: tmp/%.pptx.md
	@ mkdir -p ${dir $@}
	pandoc \
	  --to=pptx --output=$@ \
	  --from=markdown+yaml_metadata_block $<

generated/%.docx: tmp/%.md reference.docx
	@ mkdir -p ${dir $@}
	pandoc \
	  --to=docx --output=$@ \
	  --reference-doc=reference.docx \
	  --from=markdown+yaml_metadata_block $<

generated/%.md: tmp/%.md
	@ mkdir -p ${dir $@}
	cp $< $@

tmp/NIEM_tools.mm: NIEM_tools.mm
	@ mkdir -p ${dir $@}
	cp $< $@

tmp/%.pptx.md: tmp/%.mm mm-to-md-for-pptx.xsl
	saxon --in=$< --out=$@ --xsl=mm-to-md-for-pptx.xsl

tmp/%.md: tmp/%.mm mm-to-md.xsl
	saxon --in=$< --out=$@ --xsl=mm-to-md.xsl

tmp/NIEM_Tools_Requirements.mm: NIEM_tools.mm mm-extract-branch.xsl
	@ mkdir -p ${dir $@}
	saxon --in=$< --out=$@ --xsl=mm-extract-branch.xsl -- title='NIEM Tools Requirements'

tmp/NIEM_Tools_Roadmap.mm: NIEM_tools.mm mm-extract-branch.xsl
	@ mkdir -p ${dir $@}
	saxon --in=$< --out=$@ --xsl=mm-extract-branch.xsl -- title='NIEM Tools Roadmap'

.PHONY: clean
clean:
	${RM} ${all_files}
	${RM} -r tmp generated
