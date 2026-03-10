.PHONY: addbin addbin-auth addbin-java \
	addbin-opencode addbin-opencode-auth addbin-opencode-java \
	addbin-claude addbin-claude-java \
	addbin-junie addbin-junie-java \
	addbin-copilot addbin-copilot-java \
	render-wrappers check-generated-wrappers \
	removebin removebin-opencode removebin-claude removebin-junie removebin-copilot ensure-local-bin

addbin: addbin-opencode

addbin-auth: addbin-opencode-auth

addbin-java: addbin-opencode-java

render-wrappers:
	bash scripts/render-wrappers

check-generated-wrappers:
	bash scripts/render-wrappers --check

addbin-opencode addbin-opencode-auth addbin-opencode-java \
addbin-claude addbin-claude-java \
addbin-junie addbin-junie-java \
addbin-copilot addbin-copilot-java: render-wrappers

addbin-opencode: ensure-local-bin
	rm -f ~/.local/bin/opencode ~/.local/bin/opencode-auth ~/.local/bin/opencode-java ~/.local/bin/opencode-git ~/.local/bin/opencode-java-git
	echo "Adding opencode to ~/.local/bin/opencode"
	cp agents/opencode/scripts/opencode ~/.local/bin/opencode
	chmod +x ~/.local/bin/opencode
	echo "Adding opencode-auth to ~/.local/bin/opencode-auth"
	cp agents/opencode/scripts/opencode-auth ~/.local/bin/opencode-auth
	chmod +x ~/.local/bin/opencode-auth

addbin-opencode-auth: ensure-local-bin
	rm -f ~/.local/bin/opencode ~/.local/bin/opencode-auth ~/.local/bin/opencode-java ~/.local/bin/opencode-git ~/.local/bin/opencode-java-git
	echo "Adding opencode-auth to ~/.local/bin/opencode-auth"
	cp agents/opencode/scripts/opencode-auth ~/.local/bin/opencode-auth
	chmod +x ~/.local/bin/opencode-auth

addbin-opencode-java: ensure-local-bin
	rm -f ~/.local/bin/opencode ~/.local/bin/opencode-auth ~/.local/bin/opencode-java ~/.local/bin/opencode-git ~/.local/bin/opencode-java-git
	echo "Adding opencode to ~/.local/bin/opencode"
	cp agents/opencode/scripts/opencode ~/.local/bin/opencode
	chmod +x ~/.local/bin/opencode
	echo "Adding opencode-auth to ~/.local/bin/opencode-auth"
	cp agents/opencode/scripts/opencode-auth ~/.local/bin/opencode-auth
	chmod +x ~/.local/bin/opencode-auth
	echo "Adding opencode-java to ~/.local/bin/opencode-java"
	cp agents/opencode/scripts/opencode-java ~/.local/bin/opencode-java
	chmod +x ~/.local/bin/opencode-java

addbin-claude: ensure-local-bin
	rm -f ~/.local/bin/claude ~/.local/bin/claude-java ~/.local/bin/claude-git ~/.local/bin/claude-java-git
	echo "Adding claude to ~/.local/bin/claude"
	cp agents/claude/scripts/claude ~/.local/bin/claude
	chmod +x ~/.local/bin/claude

addbin-claude-java: ensure-local-bin
	rm -f ~/.local/bin/claude ~/.local/bin/claude-java ~/.local/bin/claude-git ~/.local/bin/claude-java-git
	echo "Adding claude to ~/.local/bin/claude"
	cp agents/claude/scripts/claude ~/.local/bin/claude
	chmod +x ~/.local/bin/claude
	echo "Adding claude-java to ~/.local/bin/claude-java"
	cp agents/claude/scripts/claude-java ~/.local/bin/claude-java
	chmod +x ~/.local/bin/claude-java

addbin-junie: ensure-local-bin
	rm -f ~/.local/bin/junie ~/.local/bin/junie-java ~/.local/bin/junie-git ~/.local/bin/junie-java-git
	echo "Adding junie to ~/.local/bin/junie"
	cp agents/junie/scripts/junie ~/.local/bin/junie
	chmod +x ~/.local/bin/junie

addbin-junie-java: ensure-local-bin
	rm -f ~/.local/bin/junie ~/.local/bin/junie-java ~/.local/bin/junie-git ~/.local/bin/junie-java-git
	echo "Adding junie to ~/.local/bin/junie"
	cp agents/junie/scripts/junie ~/.local/bin/junie
	chmod +x ~/.local/bin/junie
	echo "Adding junie-java to ~/.local/bin/junie-java"
	cp agents/junie/scripts/junie-java ~/.local/bin/junie-java
	chmod +x ~/.local/bin/junie-java

addbin-copilot: ensure-local-bin
	rm -f ~/.local/bin/copilot ~/.local/bin/copilot-java ~/.local/bin/copilot-git ~/.local/bin/copilot-java-git
	echo "Adding copilot to ~/.local/bin/copilot"
	cp agents/copilot/scripts/copilot ~/.local/bin/copilot
	chmod +x ~/.local/bin/copilot

addbin-copilot-java: ensure-local-bin
	rm -f ~/.local/bin/copilot ~/.local/bin/copilot-java ~/.local/bin/copilot-git ~/.local/bin/copilot-java-git
	echo "Adding copilot to ~/.local/bin/copilot"
	cp agents/copilot/scripts/copilot ~/.local/bin/copilot
	chmod +x ~/.local/bin/copilot
	echo "Adding copilot-java to ~/.local/bin/copilot-java"
	cp agents/copilot/scripts/copilot-java ~/.local/bin/copilot-java
	chmod +x ~/.local/bin/copilot-java

ensure-local-bin:
	mkdir -p ~/.local/bin

removebin: removebin-opencode removebin-claude removebin-junie removebin-copilot

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
	rm -f ~/.local/bin/junie-git
	rm -f ~/.local/bin/junie-java
	rm -f ~/.local/bin/junie-java-git

removebin-copilot:
	rm -f ~/.local/bin/copilot
	rm -f ~/.local/bin/copilot-git
	rm -f ~/.local/bin/copilot-java
	rm -f ~/.local/bin/copilot-java-git
