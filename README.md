# Local LLM

This project sets up and runs a local Large Language Model (LLM) using Ollama. It also provides a script to install and run Aider, a tool that interacts with the LLM for various tasks.

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

   For a smaller model:

   ```sh
   ollama pull qwen2.5-coder:14b
   ```

   Or for a larger model with better reasoning ability:

   ```sh
   ollama pull qwen2.5-coder:32b
   ```

4. **Install Aider:**

   ```sh
   python -m pip install aider-install && aider-install
   ```

## How to Use

1. **Run the `aider.sh` script:**

   This script checks if Ollama is running and starts it if necessary, then runs Aider in a Docker container.

   ```sh
   ./aider.sh
   ```

2. **Install Aider globally:**

   Use the `install-aider.sh` script to install Aider globally on your system.

   ```sh
   ./install-aider.sh
   ```

   Follow the prompts to select the appropriate profile file (e.g., `.bash_profile`, `.zprofile`, or `.profile`) and add `~/bin` to your PATH if it's not already included.

3. **Run Aider:**

   After installation, you can run Aider using the command:

   ```sh
   aider
   ```

## References

- [Run aider with docker](https://aider.chat/docs/install/docker.html)
