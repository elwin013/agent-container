.PHONY: addbin addbin-auth addbin-git addbin-java addbin-java-git \
	addbin-opencode addbin-opencode-auth addbin-opencode-git addbin-opencode-java addbin-opencode-java-git \
	addbin-claude addbin-claude-git addbin-claude-java addbin-claude-java-git \
	addbin-junie addbin-junie-auth addbin-junie-git addbin-junie-java addbin-junie-java-git \
	removebin removebin-opencode removebin-claude removebin-junie ensure-local-bin

addbin: addbin-opencode

addbin-auth: addbin-opencode-auth

addbin-git: addbin-opencode-git

addbin-java: addbin-opencode-java

addbin-java-git: addbin-opencode-java-git

addbin-opencode: ensure-local-bin
	echo "Adding opencode to ~/.local/bin/opencode"
	cp agents/opencode/scripts/opencode ~/.local/bin/opencode
	chmod +x ~/.local/bin/opencode

addbin-opencode-auth: ensure-local-bin
	echo "Adding opencode-auth to ~/.local/bin/opencode-auth"
	cp agents/opencode/scripts/opencode-auth ~/.local/bin/opencode-auth
	chmod +x ~/.local/bin/opencode-auth

addbin-opencode-git: ensure-local-bin
	echo "Adding opencode-git to ~/.local/bin/opencode-git"
	cp agents/opencode/scripts/opencode-git ~/.local/bin/opencode-git
	chmod +x ~/.local/bin/opencode-git

addbin-opencode-java: ensure-local-bin
	echo "Adding opencode-java to ~/.local/bin/opencode-java"
	cp agents/opencode/scripts/opencode-java ~/.local/bin/opencode-java
	chmod +x ~/.local/bin/opencode-java

addbin-opencode-java-git: ensure-local-bin
	echo "Adding opencode-java-git to ~/.local/bin/opencode-java-git"
	cp agents/opencode/scripts/opencode-java-git ~/.local/bin/opencode-java-git
	chmod +x ~/.local/bin/opencode-java-git

addbin-claude: ensure-local-bin
	echo "Adding claude to ~/.local/bin/claude"
	cp agents/claude/scripts/claude ~/.local/bin/claude
	chmod +x ~/.local/bin/claude

addbin-claude-git: ensure-local-bin
	echo "Adding claude-git to ~/.local/bin/claude-git"
	cp agents/claude/scripts/claude-git ~/.local/bin/claude-git
	chmod +x ~/.local/bin/claude-git

addbin-claude-java: ensure-local-bin
	echo "Adding claude-java to ~/.local/bin/claude-java"
	cp agents/claude/scripts/claude-java ~/.local/bin/claude-java
	chmod +x ~/.local/bin/claude-java

addbin-claude-java-git: ensure-local-bin
	echo "Adding claude-java-git to ~/.local/bin/claude-java-git"
	cp agents/claude/scripts/claude-java-git ~/.local/bin/claude-java-git
	chmod +x ~/.local/bin/claude-java-git

addbin-junie: ensure-local-bin
	echo "Adding junie to ~/.local/bin/junie"
	cp agents/junie/scripts/junie ~/.local/bin/junie
	chmod +x ~/.local/bin/junie

addbin-junie-auth: ensure-local-bin
	echo "Adding junie-auth to ~/.local/bin/junie-auth"
	cp agents/junie/scripts/junie-auth ~/.local/bin/junie-auth
	chmod +x ~/.local/bin/junie-auth

addbin-junie-git: ensure-local-bin
	echo "Adding junie-git to ~/.local/bin/junie-git"
	cp agents/junie/scripts/junie-git ~/.local/bin/junie-git
	chmod +x ~/.local/bin/junie-git

addbin-junie-java: ensure-local-bin
	echo "Adding junie-java to ~/.local/bin/junie-java"
	cp agents/junie/scripts/junie-java ~/.local/bin/junie-java
	chmod +x ~/.local/bin/junie-java

addbin-junie-java-git: ensure-local-bin
	echo "Adding junie-java-git to ~/.local/bin/junie-java-git"
	cp agents/junie/scripts/junie-java-git ~/.local/bin/junie-java-git
	chmod +x ~/.local/bin/junie-java-git

ensure-local-bin:
	mkdir -p ~/.local/bin

removebin: removebin-opencode removebin-claude removebin-junie

removebin-opencode:
	rm -f ~/.local/bin/opencode
	rm -f ~/.local/bin/opencode-auth
	rm -f ~/.local/bin/opencode-git
	rm -f ~/.local/bin/opencode-java
	rm -f ~/.local/bin/opencode-java-git

removebin-claude:
	rm -f ~/.local/bin/claude
	rm -f ~/.local/bin/claude-git
	rm -f ~/.local/bin/claude-java
	rm -f ~/.local/bin/claude-java-git

removebin-junie:
	rm -f ~/.local/bin/junie
	rm -f ~/.local/bin/junie-auth
	rm -f ~/.local/bin/junie-git
	rm -f ~/.local/bin/junie-java
	rm -f ~/.local/bin/junie-java-git
