
.SECONDARY: 

all_files = generated/NIEM_tools.docx generated/NIEM_tools.pptx

.PHONY: all
all: ${all_files}

generated/%.pptx: generated/%.pptx.md
	pandoc \
	  --to=pptx --output=$@ \
	  --from=markdown+yaml_metadata_block $<

generated/%.docx: generated/%.docx.md
	pandoc \
	  --to=docx --output=$@ \
	  --from=markdown+yaml_metadata_block $<

generated/%.pptx.md: %.mm mm-to-md-for-pptx.xsl
	mkdir -p ${dir $@}
	saxon --in=$< --out=$@ --xsl=mm-to-md-for-pptx.xsl

generated/%.docx.md: %.mm mm-to-md-for-docx.xsl
	mkdir -p ${dir $@}
	saxon --in=$< --out=$@ --xsl=mm-to-md-for-docx.xsl

.PHONY: clean
clean:
	${RM} ${all_files}
	${RM} -r clean
