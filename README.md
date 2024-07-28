# NixOS Configuration

This repository contains configuration files for NixOS. Follow the instructions below to set up and use these configurations on your NixOS system.

## Setup Instructions

To use these configuration files, follow these steps:

1. **Navigate to the NixOS Configuration Directory**

   Open a terminal and go to the `/etc/nixos/` directory:

   ```sh
   cd /etc/nixos/
   ```

2. **Remove the Existing `configuration.nix` File**

   Delete the current `configuration.nix` file:

   ```sh
   sudo rm configuration.nix
   ```

3. **Create a Symbolic Link to the New Configuration**

   Create a symbolic link to the `configuration.nix` file in this repository. Replace `{directory-of-nixos-config}` with the path to the directory of this repository:

   ```sh
   sudo ln -s {directory-of-nixos-config}/configuration.nix .
   ```

4. **Apply the New Configuration**

   Finally, apply the new configuration with:

   ```sh
   sudo nixos-rebuild switch
   ```

   This command will apply the new configuration and restart the necessary services.

## Development

For development purposes, there are a few useful scripts included in the `scripts/` directory:

- **Format Configuration Files**

  To format all configuration files, run:

  ```sh
  ./scripts/format.sh
  ```

- **Run Linter**

  To check the linting of your configuration files, run:

  ```sh
  ./scripts/check-lint.sh
  ```

- **Run Linter in Watch Mode**

  To run the linter in watch mode (for continuous linting while you develop), use:

  ```sh
  ./scripts/watch-lint.sh
  ```

These scripts help maintain code quality and ensure consistent formatting across your configuration files.

## Contributing

Feel free to contribute to this repository by submitting pull requests or opening issues. Make sure to follow the existing coding style and use the provided scripts to check for formatting and linting issues.

## License

This project is licensed under the MIT License. See the [LICENSE](LICENSE) file for more details.
