# Local LLM

This project sets up and runs a local Large Language Model (LLM) using Ollama. 
It provides a script to install and run Aider from isolated docker container.
By running from the docker container, it we avoid giving Aider access to the entire hard drive.
Its highly advisable to run Aider in this way for security and privacy reasons.
Aider is configured to run with Ollama's local LLM server.

Aider interacts with the LLM for various tasks and may modify the file system, perform git operations, etc.

## Install dependencies on MacOS

1. **Install `ollama`:**

   ```sh
   brew install ollama
   ```

2. **Start the Ollama server:**

   ```sh
   ollama serve
   ```

3. **Download a coding model:**

   Open a new terminal tab. For a smaller model:

   ```sh
   ollama pull qwen2.5-coder:14b
   ```

   Or for a larger model with better reasoning ability:

   ```sh
   ollama pull qwen2.5-coder:32b
   ```

## How to Use

You have two options:

1. **Run the `aider.sh` script from this repository:**

   This script checks if Ollama is running and starts it if necessary, 
   then runs Aider in a Docker container which is connected to Ollama server.
   Override using `OLLAMA_API_BASE=http://<ip>:11434 aider.sh` if Ollama is running on a different host.

   ```sh
   ./aider.sh
   ```

2. **Install Aider globally:**

   Use the `install-aider.sh` script to install Aider globally on your system.

   ```sh
   ./install-aider.sh
   ```

   Follow the prompts to select the appropriate profile file 
   (e.g., `.bash_profile`, `.zprofile`, or `.profile`) and add `~/bin` to your PATH if it's not already included.
   After installation, you can run Aider using the command:

   ```sh
   aider --model ollama/qwen2.5-coder:14b 
   ```
   
   Or use an aider configuration file to set default options:

   ```sh
   aider --config aider.config.yaml
   ```
   Again, override using `OLLAME_API_BASE` environment variable if Ollama is running on a different host:

   ```sh
   OLLAMA_API_BASE='http://<ip>:11434' aider --config aider.config.yaml
   ```
   
## Configuration

Create an `aider.config.yaml` file to set default options for Aider.
Example configuration:

```yaml
model: ollama/qwen2.5-coder:14b
commit: false # or true to enable automatic git commits
```

## References

- [Run aider with docker](https://aider.chat/docs/install/docker.html)
- [Aider Options](https://aider.chat/docs/config/options.html)
- [Aider Config file](https://aider.chat/docs/config/aider_conf.html)
- [Ollama Documentation](https://ollama.com/docs)
- [Docker Installation Guide](https://docs.docker.com/get-docker/)
