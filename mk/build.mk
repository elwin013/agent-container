.PHONY: build build-all build-java build-base build-base-java build-opencode build-opencode-java build-claude build-claude-java build-junie build-junie-java

build: build-opencode

build-all: build-opencode build-opencode-java build-claude build-claude-java build-junie build-junie-java

build-java: build-opencode-java

build-base:
	docker build -t agent-runtime-base:fedora43 -f agents/base/common.Containerfile .

build-base-java: build-base
	docker build -t agent-runtime-base-java:fedora43 -f agents/base/java.Containerfile .

build-opencode: build-base
	docker build -t opencode-container -f agents/opencode/base.Containerfile .
	$(MAKE) addbin-opencode addbin-opencode-auth addbin-opencode-git

build-opencode-java: build-base-java
	docker build -t opencode-container-java -f agents/opencode/java.Containerfile .
	$(MAKE) addbin-opencode addbin-opencode-auth addbin-opencode-git addbin-opencode-java addbin-opencode-java-git

build-claude: build-base
	docker build -t claude-code-container -f agents/claude/base.Containerfile .
	$(MAKE) addbin-claude addbin-claude-git

build-claude-java: build-base-java
	docker build -t claude-code-container-java -f agents/claude/java.Containerfile .
	$(MAKE) addbin-claude addbin-claude-git addbin-claude-java addbin-claude-java-git

build-junie: build-base
	docker build -t junie-container -f agents/junie/base.Containerfile .
	$(MAKE) addbin-junie addbin-junie-auth addbin-junie-git

build-junie-java: build-base-java
	docker build -t junie-container-java -f agents/junie/java.Containerfile .
	$(MAKE) addbin-junie addbin-junie-auth addbin-junie-git addbin-junie-java addbin-junie-java-git
