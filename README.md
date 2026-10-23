# Portable OpenClaude

A portable OpenClaude environment for Windows, powered by Node.js.

Set up Node.js and OpenClaude locally inside the project folder without requiring a traditional system-wide Node.js installation.

## ✨ Features

- **Portable Node.js:** Keeps Node.js inside the project directory.
- **Automatic Setup:** Downloads Node.js, verifies its SHA-256 checksum, extracts it, and installs OpenClaude.
- **Local npm Directories:** Stores global npm packages and cache inside the project.
- **Simple Launching:** Start OpenClaude using a separate batch file.
- **Easy to Move:** Designed to be transferable between compatible Windows PCs.

## 📁 Project Structure

```text
Portable-OpenClaude/
├── node/                     # Downloaded portable Node.js runtime
├── npm-global/               # Globally installed npm packages
├── npm-cache/                # npm cache
├── Setup-OpenClaude.bat      # Initial setup and installation
├── Launch-OpenClaude.bat     # Launch OpenClaude
├── README.md
├── .gitignore
└── LICENSE
```

The `node/`, `npm-global/`, and `npm-cache/` directories are generated or populated during setup. They do not need to be committed to GitHub.

## 🖥️ Requirements

- Windows 10 or Windows 11, 64-bit recommended.
- An internet connection for the initial setup and package installation.
- Windows PowerShell.
- Sufficient disk space and permission to write to the project directory.

Some managed computers may block downloads or script execution.

## 🚀 Getting Started

### 1. Download the repository

Download or clone this repository to a folder on your computer.

### 2. Run the setup

Double-click:

```text
Setup-OpenClaude.bat
```

The setup script is designed to:

1. Download the configured official Node.js Windows archive.
2. Verify the archive's SHA-256 checksum.
3. Extract Node.js into the project directory.
4. Create local npm global and cache directories.
5. Install `@twigpine/openclaude@latest`.
6. Check whether the OpenClaude launcher exists.

### 3. Launch OpenClaude

After successful setup, run:

```text
Launch-OpenClaude.bat
```

## 💾 Portable Usage

The project is designed to keep Node.js and npm's global package environment within its own directory.

To move the environment to another compatible Windows PC, copy the complete project folder, including the generated runtime and package directories.

Portability is not guaranteed on every computer. OpenClaude may have additional runtime, network, authentication, or system requirements.

## 🔒 Security Notes

- The setup script should verify the downloaded archive against the official SHA-256 checksum for the selected Node.js release.
- Review batch scripts before running them.
- Only download Node.js from the official website: https://nodejs.org/
- Do not commit API keys, authentication tokens, credentials, or personal configuration files.

## 🛠️ Troubleshooting

**Setup fails while downloading Node.js**
- Check your internet connection.
- Check whether your firewall or network blocks the download.

**Checksum verification fails**
- Do not use the rejected archive. Retry the download and verify the checksum against the official Node.js release information.

**OpenClaude installation fails**
- Review the npm error displayed in the setup window.
- Check your network connection and whether the installed Node.js version meets the package requirements.

**OpenClaude launcher is missing**
- Run `Setup-OpenClaude.bat` again and check whether npm installation completed successfully.

## 📜 License

See the [LICENSE](LICENSE) file.

---

**Note:** This repository provides setup scripts and a portable runtime workflow. It does not guarantee that every dependency or external service used by OpenClaude is fully portable.
