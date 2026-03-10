.PHONY: build build-all build-java build-base build-base-java build-opencode build-opencode-java build-claude build-claude-java build-junie build-junie-java build-copilot build-copilot-java \
	rebuild-base rebuild-base-java rebuild-opencode rebuild-opencode-java rebuild-claude rebuild-claude-java rebuild-junie rebuild-junie-java rebuild-copilot rebuild-copilot-java

build: build-opencode

build-all: build-opencode build-opencode-java build-claude build-claude-java build-junie build-junie-java build-copilot build-copilot-java

build-java: build-opencode-java

build-base:
	docker build -t agent-runtime-base:fedora43 -f agents/base/common.Containerfile .

build-base-java: build-base
	docker build -t agent-runtime-base-java:fedora43 -f agents/base/java.Containerfile .

rebuild-base:
	docker build --no-cache -t agent-runtime-base:fedora43 -f agents/base/common.Containerfile .

rebuild-base-java: rebuild-base
	docker build --no-cache -t agent-runtime-base-java:fedora43 -f agents/base/java.Containerfile .

build-opencode: build-base
	docker build -t opencode-container -f agents/opencode/base.Containerfile .
	$(MAKE) addbin-opencode

rebuild-opencode: build-base
	docker build --no-cache -t opencode-container -f agents/opencode/base.Containerfile .
	$(MAKE) addbin-opencode

build-opencode-java: build-base-java
	docker build -t opencode-container-java -f agents/opencode/java.Containerfile .
	$(MAKE) addbin-opencode-java

rebuild-opencode-java: build-base-java
	docker build --no-cache -t opencode-container-java -f agents/opencode/java.Containerfile .
	$(MAKE) addbin-opencode-java

build-claude: build-base
	docker build -t claude-code-container -f agents/claude/base.Containerfile .
	$(MAKE) addbin-claude

rebuild-claude: build-base
	docker build --no-cache -t claude-code-container -f agents/claude/base.Containerfile .
	$(MAKE) addbin-claude

build-claude-java: build-base-java
	docker build -t claude-code-container-java -f agents/claude/java.Containerfile .
	$(MAKE) addbin-claude-java

rebuild-claude-java: build-base-java
	docker build --no-cache -t claude-code-container-java -f agents/claude/java.Containerfile .
	$(MAKE) addbin-claude-java

build-junie: build-base
	docker build -t junie-container -f agents/junie/base.Containerfile .
	$(MAKE) addbin-junie

rebuild-junie: build-base
	docker build --no-cache -t junie-container -f agents/junie/base.Containerfile .
	$(MAKE) addbin-junie

build-junie-java: build-base-java
	docker build -t junie-container-java -f agents/junie/java.Containerfile .
	$(MAKE) addbin-junie-java

rebuild-junie-java: build-base-java
	docker build --no-cache -t junie-container-java -f agents/junie/java.Containerfile .
	$(MAKE) addbin-junie-java

build-copilot: build-base
	docker build -t copilot-container -f agents/copilot/base.Containerfile .
	$(MAKE) addbin-copilot

rebuild-copilot: build-base
	docker build --no-cache -t copilot-container -f agents/copilot/base.Containerfile .
	$(MAKE) addbin-copilot

build-copilot-java: build-base-java
	docker build -t copilot-container-java -f agents/copilot/java.Containerfile .
	$(MAKE) addbin-copilot-java

rebuild-copilot-java: build-base-java
	docker build --no-cache -t copilot-container-java -f agents/copilot/java.Containerfile .
	$(MAKE) addbin-copilot-java
