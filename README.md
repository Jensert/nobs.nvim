# nobs
A **N**o-**B**ullshit **B**uild **S**ystem (Also usable for *no*t *b*uild *s*ystem things) for Neovim.

Tired of overly complicated build systems and plugins that require way too much configuration to run a single command? <br>
Meet **nobs**: the plugin that does exactly what it says on the tin. Define a command for your project folder once, and then run it anytime without fuss, ceremony, or extra config files. It’s simple, it’s fast, and it’s perfectly named.

## Features

- Save a single command per workspace/project folder.
- Execute the saved command anytime, from any file in that folder.
- Minimal, no-frills API with four intuitive commands:

## Command Description

`:CBS <command>`	Create Build System — saves a command for the current folder. Overwrites existing command for the current folder if there is one.<br>
`:RBS`	Remove Build System — deletes the saved command for the current folder.<br>
`:GBS`	Get Build System — shows the saved command for the current folder.<br>
`:EBS`	Execute Build System — runs the saved command in a terminal split.

## How it works
```
Project Folder A          Project Folder B
┌────────────────┐        ┌─────────────────────┐
│ :CBS cargo run │        │ :CBS python main.py │
└───────┬────────┘        └───────┬─────────────┘
        │                         │
        ▼                         ▼
+----------------+         +------------------+
| Saved Command: |         | Saved Command:   |
| "cargo run"    |         | "python main.py" |
+----------------+         +------------------+
        │                         │
        ▼                         ▼
    :EBS runs                 :EBS runs
   cargo run                python main.py
```
## Installation
Using vim.pack (neovim's included package manager in 0.12+)
```
vim.pack({ 'https://github.com/Jensert/nobs.nvim' })
```

lazy.nvim
```
return {
  "Jensert/nobs.nvim",
  config = function()
    require("nobs")
  end
}
```

## Usage
1. Create a Build System

Define a command for the current project folder:
```
:CBS cargo run
```

2. Execute the Build System

Run your saved command anytime.
Note that this must be executed from the same folder as where you created the build system (where you used :CBS in step 1)
```
:EBS
```

3. Remove a Build System
Delete the saved command:
```
:RBS
```

5. Check Build System in the current directory:
```
:GBS
```

## Todo
- Option to save vim commands
