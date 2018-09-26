
# This is a hack for expediency; we go via obo format since
# that was easy to hack a generator for in perl.
# It would be better to use RDF and treat as instances
target/TranslatorMilestones.obo: downloads/TranslatorMilestones.tsv
	./scripts/milestones2obo.pl $< > $@.tmp && mv $@.tmp $@

# perform additional hack to fix URIs
target/TranslatorMilestones.owl: target/TranslatorMilestones.obo
	robot convert -i $< -o $@.tmp.owl && ./scripts/fix-owl.pl $@.tmp.owl > $@

target/TranslatorMilestones.json: target/TranslatorMilestones.owl
	robot convert -i $< -o $@

target/TranslatorMilestones.ttl: target/TranslatorMilestones.owl
	robot convert -i $< -o $@

# Build the main image
target/TranslatorMilestones.png: target/TranslatorMilestones.json config/main-style.json
	og2dot.js $< -s config/main-style.json -t png -o $@

# TODO: spreadsheets URL
# download/TranslatorMilestones.tsv
