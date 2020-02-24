ProjectName = ViperSample

# init
init:
	make install
	make generate
	make open

# install
install:
	mint bootstrap

# generate
generate:
	mint run xcodegen xcodegen generate

# open
open:
	open $(ProjectName).xcodeproj
