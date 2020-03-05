ProjectName = ViperSample

# init
init:
	defaults write com.apple.dt.Xcode ShowBuildOperationDuration YES
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
