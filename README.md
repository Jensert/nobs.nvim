# nobs — 
### A No-Bullshit Build System (which is not 'just' a Build System) for Neovim.

Tired of overly complicated build systems and plugins that require way too much configuration to run a single command? Meet nobs: the plugin that does exactly what it says on the tin. Define a command for your project folder once, and then run it anytime without fuss, ceremony, or extra config files. It’s simple, it’s fast, and it’s perfectly named.

Features

Save a single command per workspace/project folder.

Execute the saved command anytime, from any file in that folder.

Minimal, no-frills API with four intuitive commands:

Command	Description
:CBS <command>	Create Build System — saves a command for the current folder.
:RBS	Remove Build System — deletes the saved command for the current folder.
:GBS	Get Build System — shows the saved command for the current folder.
:EBS	Execute Build System — runs the saved command in a terminal.

## Installation
Using vim.pack (neovim 0.12+)
vim.pack({ 'https://github.com/Jensert/nobs.nvim' })

lazy.nvim
use {
  "https://github.com/Jensert/nobs.nvim",
  config = function()
    require("nobs")
  end
}

## Usage
1. Create a Build System

Define a command for the current project folder:
`` :CBS cargo run ``

2. Execute the Build System

Run your saved command anytime.
Note that this must be executed from the same folder as where you created the build system (where you used :CBS in step 1)
`` :EBS ``

3. Remove a build system
Delete the saved command:
`` :RBS ``

4. Check build system in the current directory:
`` :GBS ``
