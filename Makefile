.PHONY: help add list remove serve

help:
	@echo "Peios APT Repository"
	@echo ""
	@echo "Targets:"
	@echo "  add DEB=path/to/file.deb  - Import a .deb into the unstable suite"
	@echo "  list                      - List packages in the repository"
	@echo "  remove PKG=name           - Remove a package from the repository"
	@echo "  serve                     - Serve locally on port 8080 for testing"

add:
	@test -n "$(DEB)" || (echo "Usage: make add DEB=path/to/file.deb" && exit 1)
	reprepro -b . includedeb unstable $(DEB)

list:
	reprepro -b . list unstable

remove:
	@test -n "$(PKG)" || (echo "Usage: make remove PKG=peios-core" && exit 1)
	reprepro -b . remove unstable $(PKG)

serve:
	@echo "Serving APT repo at http://localhost:8080"
	@echo "Add to sources.list: deb [trusted=yes] http://localhost:8080 unstable main"
	python3 -m http.server 8080
