# Makefile for SSG4 generation script for acm.cse.sc.edu
SRVPORT="8000"

include Makefile.conf

# Make everything
all: 
	bin/ssg4 $(SRC) $(DST) $(TITLE) $(PREFIX)
	bin/GenIndex/main.py $(SRC) $(DST)

# Remove all generated files
clean: 
	cd $(DST) && rm .files && rm -r *

# Serve the Generated HTML for testing purposes
srv:
	cd $(DST) && python3 -m http.server $(SRVPORT)

# Generate Just the index
index: 
	bin/GenIndex/main.py $(SRC) $(DST)
	
# Re-create the proper directories if needed
init:
	mkdir $(DST)
	mkdir $(SRC)

# Pull content from the remote repository
pull:
	cd $(SRC) && git pull
	cd $(DST) && git pull

# Push rendered content to the remote repository
push:
	cd $(SRC) && git add * && git commit && git push
	cd $(DST) && git add * && git commit && git push

# Re-clone the Source and Destination Repos
clone:
	git clone $(SRC_REPO) $(SRC)
	git clone $(DST_REPO) $(DST)
